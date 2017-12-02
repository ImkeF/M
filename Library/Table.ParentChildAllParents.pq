let func =  
 (ParChTable as table,
ChildKey as text,
ParentKey as text,
LevelColumnName as text) =>


let
/*//Debug Parameters
ParChTable = Nodes0,
ChildKey = "NodeKey",
ParentKey = "ParentKey",
LevelColumnName = "Name",
*/

    #"Merged Queries0" = Table.NestedJoin(ParChTable,{"NodeKey"},ParChTable,{"ParentKey"},"SelectRelevantColumns",JoinKind.LeftOuter),
    CheckIfIsLeaf = Table.AddColumn(#"Merged Queries0", "IsLeaf", each if Table.IsEmpty([SelectRelevantColumns]) then "no" else "yes"),
    CheckMissingParentColumn = Table.AddColumn(CheckIfIsLeaf, "MissingParentRecord", each if [IsLeaf]="no" and [ParentKey]="" then "MissingParentRecord" else null),
    SelectRelevantColumns = Table.Buffer(Table.SelectColumns(CheckMissingParentColumn, {ChildKey, ParentKey, LevelColumnName})),
    AddStartPath = Table.AddColumn(SelectRelevantColumns, "Path", each Text.Trim([NodeKey]&"|"&[ParentKey], "|")),
    #"Duplicated Column" = Table.DuplicateColumn(AddStartPath, "Name", "FirstName"),
    Feed = Table.Buffer(Table.DuplicateColumn(#"Duplicated Column", "ParentKey", "FirstParentKey")),

// Retrieve all parents per row
    fnAllParents = List.Generate(()=>
    [Result= Feed, Level=1],
    each Table.RowCount([Result]) > 0,
    each [ Result= let
            #"Merged Queries" = Table.NestedJoin([Result],{ParentKey},SelectRelevantColumns,{ChildKey},"Added Custom",JoinKind.Inner),
            #"Removed Columns1" = Table.RemoveColumns(#"Merged Queries",{"ParentKey"}),
            #"Expanded Added Custom" = Table.ExpandTableColumn(#"Removed Columns1", "Added Custom", {"ParentKey", "Name"}, {"ParentKey.1", "Name.1"}),
            #"Duplicated Column" = Table.DuplicateColumn(#"Expanded Added Custom", "ParentKey.1", "ParentKey"),
            #"Merged Columns" = Table.CombineColumns(#"Duplicated Column",{"Path", "ParentKey.1"},Combiner.CombineTextByDelimiter("|", QuoteStyle.None),"Path"),
            #"Merged Columns2" = Table.CombineColumns( #"Merged Columns" ,{"Name", "Name.1"},Combiner.CombineTextByDelimiter("|", QuoteStyle.None),"Name")
          in
            #"Merged Columns2",
          Level = [Level]+1
        ]),
    ConvertToTable = Table.FromList(fnAllParents, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    ExpandLevel = Table.ExpandRecordColumn(ConvertToTable, "Column1", {"Result", "Level"}, {"Result", "Level"}),
    #"Expanded Result" = Table.ExpandTableColumn(ExpandLevel, "Result", {"Name", "ParentKey", "NodeKey", "Path", "FirstName", "FirstParentKey"}, {"Name", "ParentKey", "NodeKey", "Path", "FirstName", "FirstParentKey"}),
    FilterBlankParents = Table.SelectRows(#"Expanded Result", each ([ParentKey] = "")),
    #"Removed Columns" = Table.RemoveColumns(FilterBlankParents,{"ParentKey"}),
    #"Trimmed Text" = Table.TransformColumns(#"Removed Columns",{{"Path", each Text.Trim(_, "|")}}),
    ReverseOrderName = Table.TransformColumns(#"Trimmed Text",{{"Name", each Text.Combine(List.Reverse(Text.Split(_, "|")), "|")}}),
    ReverseOrderPath = Table.TransformColumns(ReverseOrderName,{{"Path", each Text.Combine(List.Reverse(Text.Split(_, "|")), "|")}}),
    #"Reordered Columns" = Table.ReorderColumns(ReverseOrderPath,{"NodeKey", "FirstParentKey", "Path", "FirstName", "Level", "Name"}),
    #"Split Column by Delimiter" = Table.SplitColumn(#"Reordered Columns", "Name", Splitter.SplitTextByDelimiter("|", QuoteStyle.Csv), List.Transform({1..Table.RowCount(ConvertToTable)}, each "Level "&Text.From(_))),
    #"Merged Queries" = Table.NestedJoin(#"Split Column by Delimiter",{"NodeKey", "FirstParentKey"},ParChTable,{"NodeKey", "ParentKey"},"Split Column by Delimiter",JoinKind.LeftOuter),
    #"Expanded Split Column by Delimiter" = Table.ExpandTableColumn(#"Merged Queries", "Split Column by Delimiter", List.Difference(Table.ColumnNames(ParChTable), Table.ColumnNames(SelectRelevantColumns)))
in
    #"Expanded Split Column by Delimiter"
, documentation = [
Documentation.Name =  " Table.SolveParentChild
", Documentation.Description = " Creates columns for all parents, multiple parents are supported
" , Documentation.LongDescription = " Creates columns for all parents, multiple parents are supported
", Documentation.Category = " Table
", Documentation.Source = " local
", Documentation.Author = " Imke Feldmann: www.TheBIccountant.com
", Documentation.Examples = {[Description =  " See: http://wp.me/p6lgsG-sl for more details
" , Code = " 
 ", Result = " 
"]}] 
 in 
  Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation)) 
