let func = 
(MasterPath as text, BlobPath as text) =>
let
/* debug parameters
    MasterPath = "https://github.com/ImkeF/RM/tree/master",
    BlobPath = "https://github.com/ImkeF/RM/blob/master",
*/


    FileEndings = {".pq", ".m"},
    Source = Web.Page(Web.Contents(MasterPath)),
    Data0 = Source{0}[Data],
    ColumnFunctionNames = Table.ColumnNames(Data0){1},
    #"Filtered Rows" = Table.SelectRows(Data0, each List.AnyTrue(List.Transform(FileEndings, (list)=> Text.EndsWith(Record.Field(_,ColumnFunctionNames), list)))),
    CreateURL = Table.AddColumn(#"Filtered Rows", "URLFunctionCode", each BlobPath&"/"&Record.Field(_, ColumnFunctionNames)),
    GetCode = Table.AddColumn(CreateURL, "GetCode", each Text.Combine(Web.Page(Web.Contents([URLFunctionCode]))[Data]{0}[Column2], "#(lf)")),
    #"Removed Other Columns" = Table.SelectColumns(GetCode,{"GetCode", ColumnFunctionNames}),
    #"Renamed Columns" = Table.RenameColumns(#"Removed Other Columns",{{ColumnFunctionNames, "Name"}}),
    CleanFunctionName = Table.TransformColumns(#"Renamed Columns", {{"Name", each Text.BeforeDelimiter(_, ".", {0, RelativePosition.FromEnd}), type text}}),
    Evaluate = Table.AddColumn(CleanFunctionName , "TestCode", each Expression.Evaluate([GetCode],#shared))
in
    Evaluate 

, documentation = [
Documentation.Name =  " fnGetCodeFromGithub
", Documentation.Description = " Fetches function code from GitHub
", Documentation.Category = " Accessing data
", Documentation.Author = " Imke Feldmann: www.TheBIccountant.com
", Documentation.Examples = {[Description =  " 1) Path to repo main page 2) Path to the single files
" , Code = " Check this blogpost: http://wp.me/p6lgsG-Gx explaining how it works
 ", Result = " 
"]}] 
 in 
  Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))
