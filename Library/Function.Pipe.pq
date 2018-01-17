let func =  
 
 (x, operations) => List.Accumulate(operations, x, (state, current) => Function.Invoke(current{0}, {state}&List.Skip(current)))

, documentation = [
Documentation.Name =  " Syntax.Pipe
", Documentation.Description = " Allows to use piping-syntax. 
" , Documentation.LongDescription = " Allows to use piping-syntax: http://www.thebiccountant.com/2017/08/16/should-we-pipe-m/
", Documentation.Category = " Documentation
", Documentation.Source = "  http://www.thebiccountant.com/2017/08/16/should-we-pipe-m/ .
", Documentation.Author = " Imke Feldmann: www.TheBIccountant.com .
", Documentation.Examples = {[Description =  " 
" , Code = " 
 ", Result = " 
"]}] 
 in 
  Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation)) 



