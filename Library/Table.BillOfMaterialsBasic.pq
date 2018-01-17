let func =  
 
(Table as table, Parent as text, Child as text, Qty as text) =>
let

 ChgTypeKeyCols = Table.Buffer(Table.TransformColumnTypes(Table,{{Parent, type text}, {Child, type text}})),
 ReplaceNulls = Table.ReplaceValue(ChgTypeKeyCols ,null,"",Replacer.ReplaceValue,{Parent}),
 MissingParents = List.Buffer(List.Select(List.Difference(List.Distinct(Table.Column(ReplaceNulls , Parent)), List.Distinct(Table.Column(ReplaceNulls , Child))), each _ <> "")),
 CleanTable = Table.Buffer(Table.Combine({ReplaceNulls , #table({Child, Parent}, List.Transform(MissingParents, each {_, ""}))})),
// Start the iteration with the top-parents only
 SelectTopParents = Table.SelectRows(CleanTable , each Record.Field(_, Parent)=""),
 Custom1 = SelectTopParents,
// Add Path-column where the necessary 2 fields: Child and Qty are collected
 AddPath = Table.AddColumn(Custom1, "Path", each #table({"Path_", "Qty_"}, {{Record.Field(_, Child), Record.Field(_, Qty)}})),
// Combine Parent and Child of the BOM-table as long as there are still new children in the next iteration step & write the elements into the Path-table
 ResolveBOM = List.Generate(()=>
  [Result=AddPath, Level=0],
  each Table.RowCount([Result]) > 0,
  each [ Result = let
   A = Table.NestedJoin(ChgTypeKeyCols,{Parent},[Result],{Child},"NewColumn",JoinKind.Inner),
   B = Table.ExpandTableColumn(A, "NewColumn", {"Path"}, {"PathOld"}),
   C = Table.AddColumn(B,"Path", each Table.Combine({[PathOld], #table({"Path_", "Qty_"}, {{Record.Field(_, Child), Record.Field(_, Qty)}})}))
   in C,
   Level = [Level]+1 ]),
 ConvertToTable = Table.FromList(ResolveBOM, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
 ExpandBOM1 = Table.ExpandRecordColumn(ConvertToTable, Table.ColumnNames(ConvertToTable){0}, {"Level", "Result"}, {"Level", "Result"}),
 ExpandBOM2 = Table.ExpandTableColumn(ExpandBOM1, "Result", Table.ColumnNames(ExpandBOM1[Result]{1})),
// Add a couple of fields/columns needed for the reports
 AddFields = Table.AddColumn(ExpandBOM2, "NewFields", each [
 TotalQty = List.Product([Path][Qty_]),
 SpacedPath = Text.Repeat(" | ", [Level])&Record.Field(_, Child),
 PathItems = [Path][Path_],
 PathExplode = Text.Combine(PathItems, "/"),
// PathWhereUsed = Text.Combine(List.Reverse(PathItems), "/"),
 TopParentProduct = PathItems{0} ]),
 ExpandNewFields = Table.ExpandRecordColumn(AddFields, "NewFields", Record.FieldNames(AddFields[NewFields]{0})),
// Create column indicating if item is purchase item
 PurchaseItems = Table.Buffer(Table.FromColumns({List.Difference(List.Distinct(Table.Column(ChgTypeKeyCols, Child)), List.Distinct(Table.Column(ChgTypeKeyCols, Parent)))})),
 MergePurchaseItem = Table.NestedJoin(ExpandNewFields,{Child},PurchaseItems,{Table.ColumnNames(PurchaseItems){0}},"NewColumn",JoinKind.LeftOuter),
 ExpandPurchaseItem = Table.ExpandTableColumn(MergePurchaseItem, "NewColumn", {Table.ColumnNames(PurchaseItems){0}}, {"PurchaseItem"}),
 Cleanup1 = Table.RemoveColumns(ExpandPurchaseItem,{"PathOld", "Path", "PathItems"}),
 Cleanup2 = Table.TransformColumnTypes(Cleanup1,{{Qty, type number}, {"TotalQty", type number}})
 in
 Cleanup2
 
, documentation = [
Documentation.Name =  " Table.BillOfMaterialsBasic
", Documentation.Description = " Dynamically solve a Bill of materials-structure, generating as many hierarch-columns as necessary.
" , Documentation.LongDescription = " Dynamically solve a Bill of materials-structure, generating as many hierarch-columns as necessary. See: http://www.thebiccountant.com/2017/05/08/dynamic-bill-of-material-bom-solution-in-excel-and-powerbi/#more-1782 .
", Documentation.Category = " Table
", Documentation.Source = " http://www.thebiccountant.com/2017/05/08/dynamic-bill-of-material-bom-solution-in-excel-and-powerbi/#more-1782
", Documentation.Author = " Imke Feldmann: www.TheBIccountant.com .
", Documentation.Examples = {[Description =  " http://www.thebiccountant.com/2017/05/08/dynamic-bill-of-material-bom-solution-in-excel-and-powerbi/#more-1782
" , Code = " 
 ", Result = " 
"]}] 
 in 
  Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation)) 

