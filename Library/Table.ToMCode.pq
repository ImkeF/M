let func =   
(Table as table) =>
let
    ReplaceNulls = Table.ReplaceValue(Table,null,"",Replacer.ReplaceValue,Table.ColumnNames(Table)),
	   ListOfColumns = Table.ToRows(ReplaceNulls ),
	   ConvertToTable = Table.FromList(ListOfColumns, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
	   CoreString = Table.AddColumn(ConvertToTable, "Custom", each Text.Combine(List.Transform([Column1], each Text.From(_)),""" ,""")),
	   FullString = "= #table( {""" & Text.Combine(Table.ColumnNames(Table), """, """) & """}, { {"""& Text.Combine(CoreString[Custom], """}, {""")&"""} }  )"
in
    FullString ,
documentation = [
Documentation.Name =  " Table.ToMCode ",
Documentation.Description = " Transforms a  <code>Table</code>  to a string of M code that will create that table in the query editor. ",
Documentation.LongDescription = " Transforms a  <code>Table</code>  to a string of M code that will create that table in the query editor. ",
Documentation.Category = " Table ",
Documentation.Source = "  ",
Documentation.Version = " 1.0 ",
Documentation.Author = " Imke Feldmann: www.TheBIccountant.com . ",
Documentation.Examples = {[Description =  "  ",
Code = " = fnTableAddMergeOtherColumns(Table.FromColumns({ {""Have fun with Power Query"" ,""Sooth performance pains""}, {""Gasper""}, {""Kevin""}, {""Oz""}, {""Wyn"" ,""Wyn""} }, {""Value"", ""Gasper"", ""Kevin"", ""Oz"", ""Wyn""} ), {""Value""}, "", "", ""My new Column"") ",
Result = " = Table.FromColumns({ {""Have fun with Power Query"" ,""Sooth performance pains""}, {""Gasper""}, {""Kevin""}, {""Oz""}, {""Wyn"" ,""Wyn""}, {""Gasper, Kevin, Oz, Wyn"" ,""Wyn""} }, {""Value"", ""Gasper"", ""Kevin"", ""Oz"", ""Wyn"", ""My new Column""} ) "]}]
  
 in  
  Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))  

