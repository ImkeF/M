let func =  
 // fnIndexMerge
(Table as table, SortColumn as text, AmountColumn as text) =>

let
/*
Table = FactInternetSales, 
SortColumn = "OrderDate", 
AmountColumn = "SalesAmount",
*/

SelectColumns = Table.SelectColumns(Table, {SortColumn, AmountColumn}),
// Sort table and buffer it
    Sorted = Table.Buffer(Table.AddIndexColumn(Table.Sort(SelectColumns ,{{SortColumn, Order.Ascending}}), "Index",1,1)),
// Extract Amount column and buffer it
    ExtractAmountColumn = List.Buffer(Table.Column(Sorted, AmountColumn)),
// Calculate a list with all running Totals
    RunningTotal = List.Skip(List.Generate( ()=> [ListItem=0, Counter=0],
                                                each [Counter] <= List.Count(ExtractAmountColumn),
                                                each [ListItem = ExtractAmountColumn{[Counter]}+[ListItem],
                                                      Counter = [Counter]+1]
                                         //       each [ListItem]
                                                ),1),
    #"Converted to Table" = Table.FromList(RunningTotal, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    #"Expanded Column1" = Table.ExpandRecordColumn(#"Converted to Table", "Column1", {"ListItem", "Counter"}, {"ListItem", "Counter"}),
    #"Merged Queries" = Table.NestedJoin(Sorted,{"Index"},#"Expanded Column1",{"Counter"},"Expanded Column1",JoinKind.LeftOuter),
    #"Expanded Expanded Column1" = Table.ExpandTableColumn(#"Merged Queries", "Expanded Column1", {"ListItem"}, {"RunningTotal"})
in
    #"Expanded Expanded Column1"
, documentation = [
Documentation.Name =  " Table.ColumnRunningTotal
", Documentation.Description = " Fast way to add running total to a table
" , Documentation.LongDescription = " Fast way to add running total to a table
", Documentation.Category = " Table
", Documentation.Source = " local
", Documentation.Author = " Imke Feldmann: www.TheBIccountant.com
", Documentation.Examples = {[Description =  " 
" , Code = " 
 ", Result = " 
"]}] 
 in 
  Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation)) 

