let func =  
 (table as table, optional equationCriteria as any) =>
let

    equationCriteriaNew = if equationCriteria  = null then Comparer.OrdinalIgnoreCase
                                                      else List.Transform(equationCriteria, each {_, Comparer.OrdinalIgnoreCase}),

    TableDistinctCaseInsensitive = Table.Distinct(table, equationCriteriaNew)
in
    TableDistinctCaseInsensitive
, documentation = [
Documentation.Name =  " Table.DistinctCI.pq
", Documentation.Description = " Case insensitive Table.Distinct
" , Documentation.LongDescription = " Case insensitive Table.Distinct
", Documentation.Category = " Table Transformation
", Documentation.Source = " local
", Documentation.Author = " Imke Feldmann: www.TheBIccountant.com .
", Documentation.Examples = {[Description =  " 
" , Code = " 
 ", Result = " 
"]}] 
 in 
  Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation)) 
