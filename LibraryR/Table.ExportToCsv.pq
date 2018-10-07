let func =  
 // Exports the current table to csv. Pass full PathFile specification as parameter

(path as text, dataset as table) =>

let

    TransformToText = Table.TransformColumnTypes(dataset, List.Transform(Table.ColumnNames(dataset), each {_, type text})),
    ConvertedPath = Text.Replace(path, "\", "/"),

    RScript = R.Execute("write.csv(dataset,"""&ConvertedPath&""") 

                         output <- TransformToText

                         ",[dataset=dataset]),

    output = RScript{[Name="output"]}[Value]

in

    output
, documentation = [
Documentation.Name =  " Table.ExportToCsv
", Documentation.Description = " Exports a table to a csv file using R-script in PowerBI Desktop
" , Documentation.LongDescription = " Exports a table to a csv file using R-script in PowerBI Desktop. You can pass the path in with backward-slashes, that will be reversed automatically.
", Documentation.Category = " Table.Other
", Documentation.Source = " http://www.thebiccountant.com/2015/12/28/how-to-export-data-from-power-bi-and-power-query/ .
", Documentation.Author = " Imke Feldmann: www.TheBIccountant.com
", Documentation.Examples = {[Description =  " Details see: http://www.thebiccountant.com/2015/12/28/how-to-export-data-from-power-bi-and-power-query/ 
" , Code = " 
 ", Result = " 
"]}] 
 in 
  Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))

