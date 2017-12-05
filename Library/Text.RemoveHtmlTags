let func =  
 (HTML as text) =>
let
    Source = Text.From(HTML),
    SplitAny = Text.SplitAny(Source,"<>"),
    ListAlternate = List.Alternate(SplitAny,1,1,1),
    ListSelect = List.Select(ListAlternate, each _<>""),
    TextCombine = Text.Combine(ListSelect, "")
in
    TextCombine
, documentation = [
Documentation.Name =  " Text.RemoveHtmlTags
", Documentation.Description = " Removes all Html tags from a text
" , Documentation.LongDescription = " Removes all Html tags from a text
", Documentation.Category = " Text.Modification
", Documentation.Source = " Inspired by a solution from Bill Szysz
", Documentation.Author = " Imke Feldmann: www.TheBIccountant.com
", Documentation.Examples = {[Description =  " 
" , Code = " 
 ", Result = " 
"]}] 
 in 
  Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation)) 

