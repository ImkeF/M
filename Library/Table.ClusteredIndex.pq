let func =   
 (Table as table, Cols as list, optional newColumnName as text, optional initialValue as nullable number, optional increment as nullable number) as table   => 
let
    NewColumnName = if newColumnName = null then "ClusteredIndex" else newColumnName,
    InitialValue  = if initialValue = null then 0 else initialValue ,
    Increment = if increment = null then 1 else increment,
    Group = Table.Group(Table, Cols, {{"Table", each Table.AddIndexColumn(_, NewColumnName, InitialValue, Increment), type table}}),
    Combine = Table.Combine(Group[Table])
in
    Combine ,
documentation = [
Documentation.Name =  " Table.ClusteredIndex ",
Documentation.Description = " Returns a <code>Table</code> with a new column with a specific <code>name</code> that, for each row, contains an index of the row in the table. <code>initialValue</code> is 0 and can be adjusted in 4th parameter, <code>increment</code> is 1 (can be adjusted in 5th parameter) ",
Documentation.LongDescription = " Returns a <code>Table</code> with a new column with a specific <code>name</code> that, for each row, contains an index of the row in the table.  ",
Documentation.Category = " Table ",
Documentation.Source = "  ",
Documentation.Version = " 1.0 ",
Documentation.Author = " Imke Feldmann (inspired by Cameron Wallace: https://goo.gl/D8Bc1L ) ",
Documentation.Examples = {[Description =  "  ",
Code = " Table_ClusteredIndex(#table( {""Group"", ""Value""}, List.Zip({ {""A"" ,""A"" ,""A"" ,""B"" ,""B""}, {""5"" ,""10"" ,""12"" ,""7"" ,""8""} })  ), {""Group""}, ""MyClustedIndex"", 1) ",
Result = " #table( {""Group"", ""Value"", ""MyClustedIndex""}, List.Zip( { {""A"" ,""A"" ,""A"" ,""B"" ,""B""}, {""5"" ,""10"" ,""12"" ,""7"" ,""8""}, {""1"" ,""2"" ,""3"" ,""1"" ,""2""} } ) ) "]}]
  
 in  
  Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))  
