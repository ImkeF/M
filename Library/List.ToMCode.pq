let func =   
 (List) =>
let
    Source = List,
    CoreString = Text.Combine(List.Transform(Source, each Text.From(_)), """, """),
    FullString = "= {"""& CoreString &"""}" 
in
    FullString ,
documentation = [
Documentation.Name =  " List.ToMCode ",
Documentation.Description = " Transforms a  <code>List</code>  to a string of M code that will create that list in the query editor. ",
Documentation.LongDescription = " Transforms a  <code>List</code>  to a string of M code that will create that list in the query editor. ",
Documentation.Category = " Table ",
Documentation.Source = "  ",
Documentation.Version = " 1.0 ",
Documentation.Author = " Imke Feldmann: www.TheBIccountant.com . ",
Documentation.Examples = {[Description =  "  ",
Code = "  ",
Result = "  "]}]
  
 in  
  Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))  

