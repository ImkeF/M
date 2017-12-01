let func = 

(TableWithCode as table, CodeColumnName as text) =>
let
    Source= TableWithCode,
    EvaluateFunction = Table.AddColumn(Source, "Value", each Expression.Evaluate(Record.Field(_, CodeColumnName), #shared)),
    Cleanup = Table.RemoveColumns(EvaluateFunction,{CodeColumnName}),
    ToRecord = Record.FromTable(Cleanup)
in
    ToRecord

, documentation = [
Documentation.Name =  " fnRecord.ToFunctionRecord
", Documentation.Description = " Converts a table with function code to a record where the function is active
", Documentation.Category = " Table.Transformations
", Documentation.Author = " Imke Feldmann: www.TheBIccountant.com
", Documentation.Examples = {[Description =  " 
" , Code = " Check this blogpost explaining how it works: http://wp.me/p6lgsG-Gx
 ", Result = " 
"]}] 
 in 
  Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))
