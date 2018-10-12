let func =  
 (number, divisor) => if number>0 then number-Number.RoundDown(number/divisor,0) else Number.Abs(divisor)+number
, documentation = [
Documentation.Name =  " fnNumber.ModXls.pq
", Documentation.Description = " simple Number.Mod that returns the same like Excel or DAX when negative figures are involved
" , Documentation.LongDescription = " simple Number.Mod that returns the same like Excel or DAX when negative figures are involved
", Documentation.Category = " Number.Operations
", Documentation.Source = " local
", Documentation.Author = " Imke Feldmann: www.TheBIccountant.com
", Documentation.Examples = {[Description =  " (number, divisor) 
" , Code = " 
 ", Result = " 
"]}] 
 in 
  Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation)) 

