let
func = (Table as table, SortColumn as text, AmountColumn as text) =>

let
/* Debug parameters
Table = #"Price Paid", 
SortColumn = "Date", 
AmountColumn = "Price paid",
*/

// Sort table and buffer it
    Sorted = Table.Buffer(Table.AddIndexColumn(Table.Sort(Table,{{SortColumn, Order.Ascending}}), "Index",1,1)),
// Select the Columns
    SelectColumns = Table.SelectColumns(Sorted, {SortColumn, AmountColumn, "Index"}),
// Extract Amount column and buffer it
    ExtractAmountColumn = List.Buffer(Table.Column(SelectColumns, AmountColumn)),
// Calculate a list with all running Totals
    RunningTotal = List.Skip(List.Generate( ()=> [ListItem=0, Counter=0]
                                            ,each [Counter] <= List.Count(ExtractAmountColumn)
                                            ,each [ ListItem = ExtractAmountColumn{[Counter]}+[ListItem],
                                                    Counter = [Counter]+1
                                                   ]
                                            ),1),
    ConvertedTable = Table.FromList(RunningTotal, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    ExpandedColumn = Table.ExpandRecordColumn( ConvertedTable, "Column1", {"ListItem", "Counter"}, {"ListItem", "Counter"}),
    MergedQueries = Table.NestedJoin(Sorted,{"Index"}, ExpandedColumn,{"Counter"},"Expanded Column1",JoinKind.LeftOuter),
    Expand = Table.ExpandTableColumn( MergedQueries, "Expanded Column1", {"ListItem"}, {"RunningTotal"}),
    #"Removed Columns" = Table.RemoveColumns(Expand,{"Index"}),
    #"Changed Type" = Table.TransformColumnTypes(#"Removed Columns",{{"RunningTotal", type number}})
in
    #"Changed Type"
//*
, 
    documentation = [ Documentation.Name =  " Table.ColumnRunningTotal"
        ,Documentation.Description = " Fast way to add running total to a table"
        ,Documentation.LongDescription = " Fast way to add running total to a table"
        ,Documentation.Category = " Table"
        ,Documentation.Source = " local"
        ,Documentation.Author = " Imke Feldmann: www.TheBIccountant.com"
        ,Documentation.Examples = {[Description =  " ", Code = " ", Result = " "]}] 
 in 
  Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))
//*/
