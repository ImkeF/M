Text
# M
This repo contains custom functions in the language M, which can be used in Power BI, Power Query (or Get & Transform) in Excel or in Analysis Services (version 2017 upwards).

This video describes how to use them:  https://www.youtube.com/watch?v=6TQN6KPG74Q

There are currently 2 libraries:
+ Library: Main library who holds pure M-functions
+ LibraryR: Holds M-functions that contain R-code. So you need to have R installed for them to run. But once installed and configured, you can use these functions just like the other M-functions. Further details check out here: [Using R in the Query Editor]( https://docs.microsoft.com/en-us/power-bi/desktop-r-in-query-editor)


## Table of contents:

## AccessingData
"Function | Description
-------- | -----------
[AccessingData.DropboxFolder.pq](https://github.com/ImkeF/M/blob/master/Library/AccessingData.DropboxFolder.pq) | Returns a table with contents from your selected Dropbox folder. The optional field 'folder' allows you to access sub-folders within the main folder.
[AccessingData.MCodeFromFile.pq](https://github.com/ImkeF/M/blob/master/Library/AccessingData.MCodeFromFile.pq) | Extract M-code from Excel- or Power BI files, see: http://www.thebiccountant.com/2017/10/15/bulk-extracting-power-query-m-code-from-multiple-pbix-files-in-power-bi/ ."
## Date
"Function | Description
-------- | -----------
[Date.DatesBetween.pq](https://github.com/ImkeF/M/blob/master/Library/Date.DatesBetween.pq) | Creates a list of dates according to the chosen interval between Start and End. The dates created will always be at the end of the interval, so could be in the future if today is chosen.
[Date.DimDate.pq](https://github.com/ImkeF/M/blob/master/Library/Date.DimDate.pq) | Standard DimDate gregorian calendar accd. To Marco Russo DAX calendar"
## Function
"Function | Description
-------- | -----------
[Function.Pipe.pq](https://github.com/ImkeF/M/blob/master/Library/Function.Pipe.pq) | Allows to use piping-syntax: http://www.thebiccountant.com/2017/08/16/should-we-pipe-m/"
## Other
"Function | Description
-------- | -----------
[GetCodeFromGithub.pq](https://github.com/ImkeF/M/blob/master/Library/GetCodeFromGithub.pq)
[SQLFirstNRowsFromAllTables.pq](https://github.com/ImkeF/M/blob/master/Library/SQLFirstNRowsFromAllTables.pq) | fetches the first N rows in all tables (and views) from a database at once and presents them in a compact form
[ImportPdfTextR.pq](https://github.com/ImkeF/M/blob/master/LibraryR/ImportPdfTextR.pq) | R script to import text from a pdf file. Returns a table with one row per page by default. Using 1 in the second optional parameter will return one row per line of text instead with matching indices."
## Table
"Function | Description
-------- | -----------
[Table.BillOfMaterialsBasic.pq](https://github.com/ImkeF/M/blob/master/Library/Table.BillOfMaterialsBasic.pq) | Dynamically solve a Bill of materials-structure, generating as many hierarch-columns as necessary. See: http://www.thebiccountant.com/2017/05/08/dynamic-bill-of-material-bom-solution-in-excel-and-powerbi/#more-1782 .
[Table.BlendDataTableau.pq](https://github.com/ImkeF/M/blob/master/Library/Table.BlendDataTableau.pq) | Blends table data like in Tableau. See: http://www.thebiccountant.com/2017/02/23/blending-data-in-powerbi-like-in-tableau/
[Table.ColumnRunningTotal.pq](https://github.com/ImkeF/M/blob/master/Library/Table.ColumnRunningTotal.pq) | Fast way to add running total to a table
[Table.ReplaceMultiple.pq](https://github.com/ImkeF/M/blob/master/Library/Table.ReplaceMultiple.pq) | Replaces multiple values at a time in a table column without recursion: http://www.thebiccountant.com/2016/05/22/multiple-replacements-in-power-bi-and-power-query/ The <code>ReplacementsTable </code> must have the values to be replaced in the 1st column and the new value in the 2nd.
[Table.SolveParentChild.pq](https://github.com/ImkeF/M/blob/master/Library/Table.SolveParentChild.pq) | Creates columns for all parents, multiple parents are supported
[Table.ToMarkdown.pq](https://github.com/ImkeF/M/blob/master/Library/Table.ToMarkdown.pq)
[Table.UnpivotByNumbers.pq](https://github.com/ImkeF/M/blob/master/Library/Table.UnpivotByNumbers.pq) | Unpivots a table according to the number of columns and header rows passed on in the parameters
[Table.UnpivotKeepNulls.pq](https://github.com/ImkeF/M/blob/master/Library/Table.UnpivotKeepNulls.pq) | Unpivots columns (or optional other columns) while keeping empty fields (with null). Any entry to the 3rd parameter will set to ""Unpivot Other Columns"" instead.
[Table.ExportToCsv.pq](https://github.com/ImkeF/M/blob/master/LibraryR/Table.ExportToCsv.pq) | Exports a table to a csv file using R-script in PowerBI Desktop. You can pass the path in with backward-slashes, that will be reversed automatically."
## Text
"Function | Description
-------- | -----------
[Text.RemoveHtmlTags.pq](https://github.com/ImkeF/M/blob/master/Library/Text.RemoveHtmlTags.pq) | Removes all Html tags from a text
[Text.RemoveRepeatingCharacters.pq](https://github.com/ImkeF/M/blob/master/Library/Text.RemoveRepeatingCharacters.pq) | Removes repeating characters of the delimiter from a string"
