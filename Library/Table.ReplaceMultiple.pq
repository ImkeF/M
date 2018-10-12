let func =  
 (TextToReplaceTable as table, TextColumnName as text, ReplacementsTable as table) => 
let
    Source = ReplacementsTable,
    CreateListOfLists = Table.Buffer(Table.ToRows(Source)),
    Text = TextToReplaceTable,
    TurnTextToList = Table.AddColumn(Text, "ReplacedText", each Text.Split(Record.Field(_, TextColumnName), " ")),
    Replacements = Table.AddColumn(TurnTextToList, "Changed Text Expected", 
                each Text.Combine(List.ReplaceMatchingItems([ReplacedText],CreateListOfLists)," ")),
    Cleanup = Table.RemoveColumns(Replacements,{"ReplacedText", TextColumnName})
in
    Cleanup
, documentation = [
Documentation.Name =  " Table.ReplaceMultiple
", Documentation.Description = " Replaces multiple values at a time in a table column without recursion.
" , Documentation.LongDescription = " Replaces multiple values at a time in a table column without recursion: http://www.thebiccountant.com/2016/05/22/multiple-replacements-in-power-bi-and-power-query/ The <code>ReplacementsTable </code> must have the values to be replaced in the 1st column and the new value in the 2nd.
", Documentation.Category = " Table
", Documentation.Source = "  http://www.thebiccountant.com/2016/05/22/multiple-replacements-in-power-bi-and-power-query/ .
", Documentation.Author = " Imke Feldmann: www.TheBIccountant.com .
", Documentation.Examples = {[Description =  " Details see: http://www.thebiccountant.com/2016/05/22/multiple-replacements-in-power-bi-and-power-query/ .
" , Code = " 
 ", Result = " 
"]}] 
 in 
  Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation)) 

