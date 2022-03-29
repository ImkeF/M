let func =   
 (Table as table) =>
let
  Table = Table,
  ListOfColumns = Table.ToRows(Table),
  ConvertToTable = Table.FromList(
      ListOfColumns, 
      Splitter.SplitByNothing(), 
      null, 
      null, 
      ExtraValues.Error
    ),
  CoreString = Table.AddColumn(
      ConvertToTable, 
      "Custom", 
      each Text.Combine(List.Transform([Column1], each if _ = null then "null" else """" & Text.Replace(Text.From(_),"""","""""") & """"), ", ")
    ),
  FullString = "= #table( {"""
    & Text.Combine(Table.ColumnNames(Table), """, """)
    & """}, #(lf) { {"
    & Text.Combine(CoreString[Custom], "}, #(lf) {")
    & "} } ) "
in
  FullString,
documentation = [
Documentation.Name =  " Table.ToMCode ",
Documentation.Description = " Transforms a  <code>Table</code>  to a string of M code that will create that table in the query editor. ",
Documentation.LongDescription = " Transforms a  <code>Table</code>  to a string of M code that will create that table in the query editor. ",
Documentation.Category = " Table ",
Documentation.Source = "  ",
Documentation.Version = " 1.0.1 ",
Documentation.Author = " Imke Feldmann: www.TheBIccountant.com . ",
Documentation.Examples = {[Description =  "  ",
Code = "  ",
Result = "  "]}]
  
 in  
  Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))
