let func =   
 (environment) =>
 let
    Source = environment,
    #"Converted to Table" = Record.ToTable(Source),
    #"Filtered Rows" = Table.SelectRows(#"Converted to Table", each Text.EndsWith([Name], ".pq")),
    #"Sorted Rows" = Table.Sort(#"Filtered Rows",{{"Name", Order.Ascending}}),
    #"Added Custom" = Table.AddColumn(#"Sorted Rows", "Custom", each Documentation.FunctionFieldValues.pq([Value])),
    #"Expanded Custom" = Table.ExpandRecordColumn(#"Added Custom", "Custom", {"Documentation.LongDescription", "Documentation.Category"}, {"Documentation.LongDescription", "Documentation.Category"}),
    #"Trimmed Text" = Table.TransformColumns(#"Expanded Custom",{{"Documentation.LongDescription", Text.Trim, type text}, {"Documentation.Category", Text.Trim, type text}}),
    #"Cleaned Text" = Table.TransformColumns(#"Trimmed Text",{{"Documentation.LongDescription", Text.Clean, type text}, {"Documentation.Category", Text.Clean, type text}})
in
    #"Cleaned Text" ,
documentation = [
Documentation.Name =  " Function.MyLibrary ",
Documentation.Description = " Returns a table with all custom functions in the library (ending with .pq) ",
Documentation.LongDescription = " Returns a table with all custom functions in the library (ending with .pq), pass # s hared as environment ",
Documentation.Category = " Function ",
Documentation.Source = "  ",
Documentation.Version = " 1.0 ",
Documentation.Author = " Imke Feldmann: www.TheBIccountant.com . ",
Documentation.Examples = {[Description =  "  ",
Code = "  ",
Result = "  "]}]
  
 in  
  Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))  

