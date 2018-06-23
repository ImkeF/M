let func =   
 (Table as table, OtherColumnNames, Delimiter as text, MergedColumnName as text) =>

let
    MergeColumns = List.Difference(Table.ColumnNames(Table), OtherColumnNames),
    Result = Table.AddColumn(Table, MergedColumnName, each Text.Combine(Record.FieldValues(Record.SelectFields(_,MergeColumns)), Delimiter), type text)
in
    Result ,
documentation = [
Documentation.Name =  " Table.AddMergeOtherColumns ",
Documentation.Description = " Adds a column named <code>MergedColumnName</code>  to a <code>Table</code>  that merges all other columns than named <code>OtherColumnNames</code>. <code>Delimiter</code> as a text string. ",
Documentation.LongDescription = " Adds a column named <code>MergedColumnName</code>  to a <code>Table</code>  that merges all other columns than named <code>OtherColumnNames</code>. <code>Delimiter</code> as a text string. ",
Documentation.Category = " Table ",
Documentation.Source = "  ",
Documentation.Version = " 1.0 ",
Documentation.Author = " Imke Feldmann: www.TheBIccountant.com . ",
Documentation.Examples = {[Description =  "  ",
Code = "  ",
Result = "  "]}]
  
 in  
  Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))  


