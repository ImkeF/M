"let func =   
 (
  TableWithTextColumn as table, 
  ColumnNameTextToReplace as text, 
  ReplacementsTable as table, 
  ColumnNameWordToReplace as text, 
  ColumnNameReplaceWith as text
) => 
  let
    Source = ReplacementsTable,
    CreateListOfLists = Table.AddColumn(
        Source, 
        ""Liste"", 
        each ({Record.Field(_, ColumnNameWordToReplace), Record.Field(_, ColumnNameReplaceWith)})
      ),
    Text = TableWithTextColumn,
    TurnTextToList = Table.AddColumn(
        Text, 
        ""Custom"", 
        each Text.Split(Record.Field(_, ColumnNameTextToReplace), "" "")
      ),
    Replacements = Table.AddColumn(
        TurnTextToList, 
        ""Changed Text Expected"", 
        each Text.Combine(List.ReplaceMatchingItems([Custom], CreateListOfLists[Liste]), "" "")
      ),
    Cleanup = Table.RemoveColumns(Replacements, {""Custom"", ""Text""})
  in
    Cleanup ,
documentation = [
Documentation.Name =  "" Table.ReplaceMultiple.pq "",
Documentation.Description = "" Replaces multiple values at a time in a table column without recursion. "",
Documentation.LongDescription = ""  Replaces multiple values at a time in a table column without recursion: http://www.thebiccountant.com/2016/05/22/multiple-replacements-in-power-bi-and-power-query/ The <code>ReplacementsTable </code> must have the values to be replaced in the 1st column and the new value in the 2nd. "",
Documentation.Category = "" Table.ColumnOperations "",
Documentation.Source = "" http://www.thebiccountant.com/2016/05/22/multiple-replacements-in-power-bi-and-power-query/ . "",
Documentation.Version = "" 2.0 "",
Documentation.Author = "" Imke Feldmann "",
Documentation.Examples = {[Description =  ""  "",
Code = "" let 
    TableWithText = #table( {""""Text""""}, List.Zip( { {""""the cat sat on the mat"""" ,""""the cat sat next to the dog"""" ,""""the dog chased the cat"""" ,""""the dog sat on the mat"""" ,""""the catamaran sails through the air""""} } ) ), 
    ReplacementsTable = #table( {""""Word To Replace"""", """"Replace With""""}, List.Zip( { {""""cat"""" ,""""mat"""" ,""""dog"""" ,""""the"""" ,""""air""""}, {""""bear"""" ,""""chair"""" ,""""dragon"""" ,""""THE"""" ,""""water""""} } ) ),
// The query containing the function has to be called """"fnTable_ReplaceMultiple_pq""""
    Result = fnTable_ReplaceMultiple_pq ( TableWithText , """"Text"""", ReplacementsTable, """"Word To Replace"""", """"Replace With"""" ) 
in 
    Result "",
Result = "" Changed Text Expected
---------------------
THE bear sat on THE chair
THE bear sat next to THE dragon
THE dragon chased THE bear
THE dragon sat on THE chair
THE catamaran sails through THE water ""]}]
  
 in  
  Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))  "
