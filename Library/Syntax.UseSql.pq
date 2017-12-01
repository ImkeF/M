let func =  
 (SqlExpression as text) =>
let
Source = Expression.Evaluate(SqlExpression.ToExpression(SqlExpression, #shared), #shared) (#shared)
in
Source

, documentation = [
Documentation.Name =  " Syntax.UseSQL
", Documentation.Description = " Use SQL-statement to query your M-tables (!!!) in your current file.
" , Documentation.LongDescription = " Use SQL-statement to query your M-tables (!!!) in your current file. This is an experimental feature that might be removed.
", Documentation.Category = " Accessing data
", Documentation.Source = " https://ssbi-blog.de/technical-topics-english/the-environment-concept-in-m-for-power-query-and-power-bi-desktop-part-3/#comment-134
", Documentation.Author = " Imke Feldmann: www.TheBIccountant.com
", Documentation.Examples = {[Description =  " 
" , Code = " 
 ", Result = " 
"]}] 
 in 
  Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))
