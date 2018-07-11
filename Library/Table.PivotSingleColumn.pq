let func =   
 (Table as table, NumberOfColumns as number) =>
let
    Source = Table,
    #"Added Index" = Table.AddIndexColumn(Source, "Index", 0, 1),
    #"Inserted Modulo" = Table.AddColumn(#"Added Index", "Modulo", each "Column" & Text.From(Number.Mod([Index], NumberOfColumns)+1), type number),
    #"Integer-Divided Column" = Table.TransformColumns(#"Inserted Modulo", {{"Index", each Number.IntegerDivide(_, NumberOfColumns ), Int64.Type}}),
    #"Pivoted Column" = Table.Pivot(Table.TransformColumnTypes(#"Integer-Divided Column", {{"Modulo", type text}}, "en-GB"), List.Distinct(Table.TransformColumnTypes(#"Integer-Divided Column", {{"Modulo", type text}}, "en-GB")[Modulo]), "Modulo", Table.ColumnNames(Table){0})
in
    #"Pivoted Column" ,
documentation = [
Documentation.Name =  " Table.PivotSingleColumn ",
Documentation.Description = " Transforms a <code>Table</code> with a single column into a table with <code>NumberOfColumns</code>. ",
Documentation.LongDescription = " Transforms a <code>Table</code> with a single column into a table with <code>NumberOfColumns</code>. ",
Documentation.Category = " Table ",
Documentation.Source = "  ",
Documentation.Version = " 1.0 ",
Documentation.Author = " Imke Feldmann (www.TheBIccountant.com ) ",
Documentation.Examples = {[Description =  "  ",
Code = " Table.PivotSingleColumn(#table( {""Column1""}, List.Zip( { {""Apple"" ,""Fruit"" ,""10"" ,""Cucumber"" ,""Veg"" ,""5"" ,""Pear"" ,""Fruit"" ,""2""} } ) )) ",
Result = " #table( {""Index"", ""Column1"", ""Column2"", ""Column3""}, List.Zip( { {""0"" ,""1"" ,""2""}, {""Apple"" ,""Cucumber"" ,""Pear""}, {""Fruit"" ,""Veg"" ,""Fruit""}, {""10"" ,""5"" ,""2""} } ) ) "]}]
  
 in  
  Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))  
