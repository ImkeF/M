// Exports the current table to csv. Pass full PathFile specification as parameter
(path as text, dataset as table) =>
let
    ConvertedPath = Text.Replace(path, "\", "/"),
    RScript = R.Execute("write.csv(dataset,""&ConvertedPath&"") #(lf) output <- dataset",[dataset=dataset]),
    output = RScript{[Name="output"]}[Value]
in
    output
