let func =  
 // fetches the first N rows in all tables from a database at once and presents them in a compact form
(Server as text, Database as text, NumberOfRows as number) as table => 

let
    Source = Sql.Database(Server, Database, [CreateNavigationProperties=false]),
    #"Filtered Rows" = Table.SelectRows(Source, each Value.Is([Data], type table)),
    #"Added Custom" = Table.AddColumn(#"Filtered Rows", "Custom", each Table.Transpose(Table.DemoteHeaders(Table.Buffer(Table.FirstN([Data],NumberOfRows))))),
    #"Expanded Custom" = Table.ExpandTableColumn(#"Added Custom", "Custom", Table.ColumnNames(#"Added Custom"[Custom]{0}))
in
    #"Expanded Custom"
, documentation = [
Documentation.Name =  " Sql.Database_FirstNRowsFromAllTables
", Documentation.Description = " fetches the first N rows in all tables (and views) from a database at once and presents them in a compact form
" , Documentation.LongDescription = " fetches the first N rows in all tables (and views) from a database at once and presents them in a compact form
", Documentation.Category = " Accessing data
", Documentation.Source = " local
", Documentation.Author = " Imke Feldmann: www.TheBIccountant.com
", Documentation.Examples = {[Description =  " 
" , Code = " 
 ", Result = " 
"]}] 
 in 
  Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation)) 
