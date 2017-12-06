/* Exports the current table to csv. 
1st argument is the reference to the table (or previous stepname)
2nd argument: Pass full PathFile specification as parameter, slashes will be converted automatically
*/

(dataset as table, path as text) =>

let

    ConvertedPath = Text.Replace(path, "\", "/"),

    RScript = R.Execute("write.csv(dataset,"""&ConvertedPath&""") 

                         output <- dataset

                         ",[dataset=dataset]),

    output = RScript{[Name="output"]}[Value]

in

    output
