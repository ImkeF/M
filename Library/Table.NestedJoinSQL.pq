(SQLTable as table, keysql as list, filtertable as table, keyfilter as list, optional newColumnName as text, optional JoinKind) =>

let
// 1 Splitting filter table  into chuncks of 200 lines and add index
Quelle = filtertable ,
AddIndex = Table.AddIndexColumn(Quelle, "Index", 1, 1),
FilterTable = Table.AddColumn(AddIndex, "Group", each Number.RoundUp([Index]/200)),

// 2 Performing the filter operation in a function
function = (group)=>
let
Source = SQLTable,
Result = Table.Buffer(Table.NestedJoin(Source,keysql,Table.SelectRows(FilterTable, each [Group] = group),keyfilter,"NewColumn",JoinKind.Inner))
in
Result,

// 3 Main query: Create table with groups to call function from, call function and expand (thereby stitching the results back together)
Source = {1..Number.RoundUp(List.Max(FilterTable[Group]))},
ConvertToTable = Table.FromList(Source, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
AddFunctionCol = Table.AddColumn(ConvertToTable, "Custom", each function([Column1])),
Remove = Table.RemoveColumns(AddFunctionCol ,{"Column1"}),
#"Expanded Custom" = Table.ExpandTableColumn(Remove, "Custom", Table.ColumnNames(Remove[Custom]{0}))
in
#"Expanded Custom"
