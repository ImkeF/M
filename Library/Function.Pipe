let func =  
 (x, operations) => List.Accumulate(operations, x, (state, current) => Function.Invoke(current{0}, {state}&List.Skip(current)))
, documentation = [
Documentation.Name =  " Function.Pipe
", Documentation.Description = " Allows you to pipe your M functions
" , Documentation.LongDescription = " Allows you to pipe your M functions
", Documentation.Category = " Function
", Documentation.Source = " local
", Documentation.Author = " Imke Feldmann: www.TheBIccountant.com
", Documentation.Examples = {[Description =  " 
" , Code = " 
 ", Result = " 
"]}] 
 in 
  Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation)) 

