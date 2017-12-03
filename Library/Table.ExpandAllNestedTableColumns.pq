let func =  
(TableColumn as list, optional SourceNameColumn as list) =>
let
  AddIDs = 
    if 
    SourceNameColumn=null 
    then 
      TableColumn 
    else 
      let
        ZipNames = 
          List.Zip({TableColumn, SourceNameColumn}),
        AddColumnFunction = 
          (ListIn as list) => 
          Table.AddColumn(ListIn{0}, "Source", each ListIn{1}),
        AddColumns = 
          List.Transform(ZipNames, each AddColumnFunction(_))
      in
        AddColumns,
  Combine = Table.Combine(AddIDs)
in
  Combine
, documentation = [
Documentation.Name =  " Table.ExpandAllColumns
", Documentation.Description = " Expands all columns from different tables within one column at once
" , Documentation.LongDescription = " Expands all columns from different tables within one column at once
", Documentation.Category = " Table
", Documentation.Source = " .  https://blog.crossjoin.co.uk/2017/12/03/making-sure-all-columns-appear-when-you-combine-data-from-multiple-files-in-power-bi-power-query-m/#comment-42090  .
", Documentation.Author = " Chris Webb
", Documentation.Examples = {[Description =  " 
" , Code = " 
 ", Result = " 
"]}] 
 in 
  Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation)) 
