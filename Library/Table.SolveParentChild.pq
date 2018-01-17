let func =  
 //*
(ParChTable as table,
ChildKey as text,
ParentKey as text,
LevelColumnName as text) =>
//*/

let
/*
//Debug Parameters
ParChTable = Nodes1,
ChildKey = "NodeKey1",
ParentKey = "ParentKey1",
LevelColumnName = "Name1",
*/


    SelectRelevantColumns = Table.SelectColumns(ParChTable, {ChildKey, ParentKey, LevelColumnName}),
    #"Changed Type" = Table.TransformColumnTypes(SelectRelevantColumns ,{{ChildKey, type text}, {ParentKey, type text}}),
    ReplaceNulls = Table.ReplaceValue(#"Changed Type",null,"",Replacer.ReplaceValue,{ParentKey}),
    //    CleanParChTable = Table.Distinct(ReplaceNulls , {ChildKey, ParentKey}),
    MissingParents = List.Buffer(List.Select(List.Difference(List.Distinct(Table.Column(ReplaceNulls , ParentKey)), List.Distinct(Table.Column(ReplaceNulls , ChildKey))), each _ <> "")),
    CleanTable = Table.Buffer(Table.Combine({ReplaceNulls , #table({ChildKey, LevelColumnName, ParentKey}, List.Transform(MissingParents, each {_, "Unknown TopLevel"& Text.From(List.PositionOf(MissingParents, _)), ""}))})),
    #"Merged Queries0" = Table.NestedJoin(CleanTable,{ChildKey},CleanTable,{ParentKey},"SelectRelevantColumns",JoinKind.LeftOuter),
    CheckIfIsLeaf = Table.AddColumn(#"Merged Queries0", "IsLeaf", each if Table.IsEmpty([SelectRelevantColumns]) then "yes" else "no"),
    #"Replaced Value1" = Table.ReplaceValue(CheckIfIsLeaf,null,"",Replacer.ReplaceValue,{ParentKey, LevelColumnName}),
    AddStartPath = Table.AddColumn(#"Replaced Value1", "Path", each Text.Trim(Record.Field(_, ChildKey)&"|"&Record.Field(_,ParentKey), "|")),
    #"Duplicated Column" = Table.DuplicateColumn(AddStartPath, LevelColumnName, "FirstName"),
    Feed = Table.DuplicateColumn(#"Duplicated Column", ParentKey, "FirstParentKey"),

// Retrieve all parents per row
    fnAllParents = List.Generate(()=>
    [Result= Feed, Level=1],
    each Table.RowCount([Result]) > 0,
    each [ Result= let
            #"Merged Queries" = Table.NestedJoin([Result],{ParentKey},CleanTable,{ChildKey},"Added Custom",JoinKind.Inner),
            #"Removed Columns1" = Table.RemoveColumns(#"Merged Queries",{ParentKey}),
            #"Expanded Added Custom" = Table.ExpandTableColumn(#"Removed Columns1", "Added Custom", {ParentKey, LevelColumnName}, {"ParentKey.1", "Name.1"}),
            #"Duplicated Column" = Table.DuplicateColumn(#"Expanded Added Custom", "ParentKey.1", ParentKey),
            #"Merged Columns" = Table.CombineColumns(#"Duplicated Column",{"Path", "ParentKey.1"},Combiner.CombineTextByDelimiter("|", QuoteStyle.None),"Path"),
            #"Merged Columns2" = Table.CombineColumns( #"Merged Columns" ,{LevelColumnName, "Name.1"},Combiner.CombineTextByDelimiter("|", QuoteStyle.None),LevelColumnName)
          in
            #"Merged Columns2",
          Level = [Level]+1
        ]),
    ConvertToTable = Table.FromList(fnAllParents, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    ExpandLevel = Table.ExpandRecordColumn(ConvertToTable, "Column1", {"Result", "Level"}, {"Result", "Level"}),
    #"Expanded Result" = Table.ExpandTableColumn(ExpandLevel, "Result", {LevelColumnName, ParentKey, ChildKey, "Path", "FirstName", "FirstParentKey"}, {"Name", "ParentKey", "NodeKey", "Path", "FirstName", "FirstParentKey"}),
    #"Filtered Rows1" = Table.SelectRows(#"Expanded Result", each ([ParentKey] = null or [ParentKey] = "")),
    #"Removed Columns" = Table.RemoveColumns(#"Filtered Rows1",{"ParentKey"}),
    #"Trimmed Text" = Table.TransformColumns(#"Removed Columns",{{"Path", each Text.Trim(_, "|")}}),
    ReverseOrderName = Table.TransformColumns(#"Trimmed Text",{{"Name", each Text.Combine(List.Reverse(Text.Split(_, "|")), "|")}}),
    ReverseOrderPath = Table.TransformColumns(ReverseOrderName,{{"Path", each Text.Combine(List.Reverse(Text.Split(_, "|")), "|")}}),
    #"Reordered Columns" = Table.ReorderColumns(ReverseOrderPath,{"NodeKey", "FirstParentKey", "Path", "FirstName", "Level", "Name"}),
    #"Split Column by Delimiter" = Table.SplitColumn(#"Reordered Columns", "Name", Splitter.SplitTextByDelimiter("|", QuoteStyle.Csv), List.Transform({1..Table.RowCount(ConvertToTable)}, each "Level "&Text.From(_))),
    #"Merged Queries" = Table.NestedJoin(#"Split Column by Delimiter",{"NodeKey", "FirstParentKey"},ParChTable ,{ChildKey, ParentKey},"Split Column by Delimiter",JoinKind.LeftOuter),
    #"Expanded Split Column by Delimiter" = Table.ExpandTableColumn(#"Merged Queries", "Split Column by Delimiter", List.Difference(Table.ColumnNames(ParChTable), Table.ColumnNames(#"Replaced Value1")))
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
