let func =  
 (table as table, optional comparisonCriteria as any) =>

Table.Buffer(Table.Sort(table, comparisonCriteria))
, documentation = [
Documentation.Name =  " Table.SortB.pq
", Documentation.Description = " Buffered Table.Sort
" , Documentation.LongDescription = " Buffered Table.Sort. Buffers the result to maintain the sort order in future referencing steps
", Documentation.Category = " Table Transformation
", Documentation.Source = " local
", Documentation.Author = " Imke Feldmann: www.TheBIccountant.com .
", Documentation.Examples = {[Description =  " 
" , Code = " 
 ", Result = " 
"]}] 
 in 
  Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation)) 

