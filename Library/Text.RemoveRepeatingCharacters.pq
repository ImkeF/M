let func =  
 (Text as text, Delimiter as text) as text =>
let
    TextToList = List.Buffer(Text.Split(Text, Delimiter)),
    FilterList = List.Select(TextToList, each _ <> ""),
    Result = Text.Combine(FilterList, Delimiter)
in
    Result
, documentation = [
Documentation.Name =  " Text.RemoveRepeatingCharacters
", Documentation.Description = " Removes repeating characters of the delimiter from a string
" , Documentation.LongDescription = " Removes repeating characters of the delimiter from a string
", Documentation.Category = " Text Modification
", Documentation.Source = " http://wp.me/p6lgsG-M9  .
", Documentation.Author = " Imke Feldmann: www.TheBIccountant.com .
", Documentation.Examples = {[Description =  " Removes repeating characters of the delimiter from a string
" , Code = " RemoveRepeatingCharacters(""Imke      Feldmann"", "" "")
 ", Result = " ""Imke Feldmann""
"]}] 
 in 
  Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))
