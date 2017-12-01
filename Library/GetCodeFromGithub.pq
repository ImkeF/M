let func = 
(MasterPath as text, BlobPath as text) =>
let
/* debug parameters
    MasterPath = "https://github.com/ImkeF/RM/tree/master",
    BlobPath = "https://github.com/ImkeF/RM/blob/master",
*/

    FileEndings = {".rm", ".m"},
    Source = Web.Page(Web.Contents(MasterPath)),
    Data0 = Source{0}[Data],
    #"Filtered Rows" = Table.SelectRows(Data0, each List.AnyTrue(List.Transform(FileEndings, (list)=> Text.EndsWith([#"Failed to load latest commit information."], list)))),
    CreateURL = Table.AddColumn(#"Filtered Rows", "URLFunctionCode", each BlobPath&"/"&[#"Failed to load latest commit information."]),
    GetCode = Table.AddColumn(CreateURL, "GetCode", each Text.Combine(Web.Page(Web.Contents([URLFunctionCode]))[Data]{0}[Column2], "#(lf)")),
    #"Removed Other Columns" = Table.SelectColumns(GetCode,{"GetCode", "Failed to load latest commit information."}),
    #"Renamed Columns" = Table.RenameColumns(#"Removed Other Columns",{{"Failed to load latest commit information.", "Name"}}),
    CleanFunctionName = Table.TransformColumns(#"Renamed Columns", {{"Name", each Text.BeforeDelimiter(_, ".", {0, RelativePosition.FromEnd}), type text}})
in
    CleanFunctionName

, documentation = [
Documentation.Name =  " fnGetCodeFromGithub
", Documentation.Description = " Fetches function code from GitHub
", Documentation.Category = " Accessing data
", Documentation.Author = " Imke Feldmann: www.TheBIccountant.com
", Documentation.Examples = {[Description =  " 1) Path to repo main page 2) Path to the single files
" , Code = " Check this blogpost explaining how it works: http://wp.me/p6lgsG-Gx
 ", Result = " 
"]}] 
 in 
  Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))
