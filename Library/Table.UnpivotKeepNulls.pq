let func =  
 (Table_ as table, Columns as list, optional Others as any) =>
let
    NonSelectedColumns = List.Difference(Table.ColumnNames(Table_),Columns),
    Unpivot = if Others <> null then NonSelectedColumns else Columns,
    AddColumn = Table.AddColumn(Table_, "Custom", each Record.ToTable(Record.SelectFields(_, Unpivot))),
    Cleanup = Table.RemoveColumns(AddColumn, Unpivot),
    Expand = Table.ExpandTableColumn(Cleanup, "Custom", {"Name", "Value"}, {"Name", "Value"})
in
    Expand
, documentation = [
Documentation.Name =  " Table.UnpivotKeepNulls
", Documentation.Description = " Unpivots columns (or optional other columns) while keeping empty fields (with null). 
" , Documentation.LongDescription = " Unpivots columns (or optional other columns) while keeping empty fields (with null). Any entry to the 3rd parameter will set to ""Unpivot Other Columns"" instead. 
", Documentation.Category = " Table Transformation
", Documentation.Source = " local
", Documentation.Author = " Imke Feldmann: www.TheBIccountant.com .
", Documentation.Examples = {[Description =  " 
" , Code = " 
 ", Result = " 
"]}] 
 in 
  Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation)) 

