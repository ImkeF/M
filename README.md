# M
This repo contains custom functions in the language M, which can be used in Power BI, Power Query (or Get & Transform) in Excel or in Analysis Services (version 2017 upwards).  

This video describes how to use them:  https://www.youtube.com/watch?v=6TQN6KPG74Q

There are currently 2 libraries:   
+ Library: Main library who holds pure M-functions
+ LibraryR: Holds M-functions that contain R-code. So you need to have R installed for them to run. But once installed and configured, you can use these functions just like the other M-functions. Further details check out here: [Using R in the Query Editor]( https://docs.microsoft.com/en-us/power-bi/desktop-r-in-query-editor)   


## Table of contents:
 
## AccessingData
Function | Description
-------- | -----------
[AccessingData.DropboxFolder.pq](https://github.com/ImkeF/M/tree/master/Library/AccessingData.DropboxFolder.pq) | Returns a table with contents from your selected Dropbox folder. The optional field 'folder' allows you to access sub-folders within the main folder.
[PowerBI.DataModel.pq](https://gist.githubusercontent.com/ImkeF/7f7431ea70ff6f702b5317edf738dae0/raw/2e166612df8b15287442214affc8f976f27dadcd/PowerBI.DataModel.pq) | Returns port number and database name of the latest Power BI data model opened with PBI Desktop.
[AccessingData.MCodeFromFile.pq](https://github.com/ImkeF/M/tree/master/Library/AccessingData.MCodeFromFile.pq) | Extract M-code from Excel- or Power BI files, see: http://www.thebiccountant.com/2017/10/15/bulk-extracting-power-query-m-code-from-multiple-pbix-files-in-power-bi/ .
[GetCodeFromGitHub.pq](https://gist.githubusercontent.com/ImkeF/b701190040107c4321457c87ef41db11/raw/0b97fe06d6fb8fce6885114f8bbff6b2461bfdc7/GetCodeFromGitHub.pq) | Fetches function code from GitHub
[fnSQLDB_FirstNOfAllTables](https://gist.githubusercontent.com/ImkeF/7f4fca8f7a7334d7fe7fb1ec761711da/raw/f3fe447a5878df313281ec95be35e3f378b85f0a/fnSQLDB_FirstNOfAllTables) | fetches the first N rows in all tables (and views) from a database at once and presents them in a compact form
[Syntax.UseSQL.pq](https://gist.githubusercontent.com/ImkeF/99c7e2dcca4b49076a5741dd5914bcce/raw/8d82289d9f8715ea174a0c2bffa95e5cecf7811a/Syntax.UseSQL.pq) | Use SQL-statement to query your M-tables (!!!) in your current file.
## Allocation
Function | Description
-------- | -----------
[Allocation.StretchAndCompress.pq](https://gist.githubusercontent.com/ImkeF/aaa9dd0e088f124349d74cad197d8a7f/raw/7dc13844afacc30190a582e982650ac8c1a12ab4/Allocation.StretchAndCompress.pq) | Allocates values by stretching or compressing a series of values over time
## DAX
Function | Description
-------- | -----------
[DAX.CalculateDebugger.pq](https://gist.githubusercontent.com/ImkeF/39824fd8b12ba30392d6b089b1fdd5c6/raw/98e516256a00a3f875ab009a38af1afa71bb81e9/DAX.CalculateDebugger.pq) | Produces DAX code to debug a filter argument of CALCULATE.
## Date
Function | Description
-------- | -----------
[Date.DatesBetween.pq](https://github.com/ImkeF/M/tree/master/Library/Date.DatesBetween.pq) | Creates a list of dates according to the chosen interval between Start and End. The dates created will always be at the end of the interval, so could be in the future if today is chosen.
[Date.DimDate.pq](https://github.com/ImkeF/M/tree/master/Library/Date.DimDate.pq) | Standard DimDate gregorian calendar accd. To Marco Russo DAX calendar
## DateTime
Function | Description
-------- | -----------
[DateTime.HoursBetween.pq](https://github.com/ImkeF/M/tree/master/Library/DateTime.HoursBetween.pq) | Returns a list of hours (datetime) that lie between the <code>Start</code> and <code>End</code>
## Documentation
Function | Description
-------- | -----------
[Documentation.FunctionFieldValues.pq](https://gist.githubusercontent.com/ImkeF/f706fb8e18c75011db89009d0b32f140/raw/33930a3b80cc8ee77d0fa4e0b6a23e48d920c29b/Documentation.FunctionFieldValues.pq) | Shows the values of the documentation-fields and the signature of a function
## Function
Function | Description
-------- | -----------
[Function.Pipe.pq](https://github.com/ImkeF/M/tree/master/Library/Function.Pipe.pq) | Allows to use piping-syntax: http://www.thebiccountant.com/2017/08/16/should-we-pipe-m/
[Function.QuickBooksTimeActivity.pq](https://gist.githubusercontent.com/ImkeF/873d4e62deaee07f2e79e38a52e90d2f/raw/307c9838e223d08cb063f3e402e2a3189c194c58/Function.QuickBooksTimeActivity.pq) | Fetches all available time activity fields from the QuickBooks connector. Optional parameter allows filtering after a certain date.
## Http
Function | Description
-------- | -----------
[Http.APIGenerateTokenPW.pq](https://github.com/ImkeF/M/tree/master/Library/Http.APIGenerateTokenPW.pq) | Generates a Token for an API with username and password. Urls default to Power BI API
## List
Function | Description
-------- | -----------
[List.ChunkUp.pq](https://gist.githubusercontent.com/ImkeF/2d494c6b6ecdb059b76a69a200edb200/raw/18dec3d067d05929a25cf1ab6f1d5f15b05dc4bc/List.ChunkUp.pq) | Chunks up an <code>inputList</code> into groups of <code>chunkSize</code>.
[List.Percentile.pq](https://github.com/ImkeF/M/tree/master/Library/List.Percentile.pq) | Returns the k-th <code>percentile</code> of values in a <code>list</code>.  Use "1" in 3rd parameter to set from Inc (default) to Exc .
[List.PermutationTable.pq](https://gist.githubusercontent.com/ImkeF/ce958b6c7a6b065a9c3c1b75f87d4c70/raw/40add5d73c56d99d2674fc9670ee053882621672/List.PermutationTable.pq) | Creates a permuations table from all elements from a <code>List</code>
[List.ToMCode.pq](https://github.com/ImkeF/M/tree/master/Library/List.ToMCode.pq) | Transforms a  <code>List</code>  to a string of M code that will create that list in the query editor.
[List.SelectPositions.pq](https://gist.githubusercontent.com/ImkeF/01da3ce14b5d3e23715ccae36b57f820/raw/eba8ac055b2fefa5f1db16f4a79392bd144cc41f/List.SelectPositions.pq) | Selects all items from  <code>SelectionList</code> that are on positions in <code>ListOfPositions</code>.
## NAV
Function | Description
-------- | -----------
[NAV.AccountListFromTotaling.pq](https://gist.githubusercontent.com/ImkeF/b393b41382794522d594db8f2da48e5a/raw/74214c5dba259a3150b75a16e1783dee71a41609/NAV.AccountListFromTotaling.pq) | Creates a list of account numbers from the totalling syntax in NAV chart of accounts or account schemes.
## Number
Function | Description
-------- | -----------
[Number.ModXls.pq](https://github.com/ImkeF/M/tree/master/Library/Number.ModXls.pq) | simple Number.Mod that returns the same like Excel or DAX when negative figures are involved
## Other
Function | Description
-------- | -----------
[Xlsx.ExtractQueries.pq](https://gist.githubusercontent.com/ImkeF/2659b2006ad7b0466ca1cfaed87c86e2/raw/92fcfe7eb9260bee8b07594313791cca8a0f3f3d/Xlsx.ExtractQueries.pq) | Extracts all queries from files in folder or xlsx-files
[SQLFirstNRowsFromAllTables.pq](https://github.com/ImkeF/M/tree/master/Library/SQLFirstNRowsFromAllTables.pq) | fetches the first N rows in all tables (and views) from a database at once and presents them in a compact form
[Export.CreateGist.pq](https://gist.githubusercontent.com/ImkeF/7202ba50867377988719f2c3492931f7/raw/45bf922c544fe25b5a3094356bea7baa21ddf021/Export.CreateGist.pq) | Creates a secret gist with the parameters provided. Optional parameter to make it public.
[ImportPdfTextR.pq](https://github.com/ImkeF/M/tree/master/LibraryR/ImportPdfTextR.pq) | R script to import text from a pdf file. Returns a table with one row per page by default. Using 1 in the second optional parameter will return one row per line of text instead with matching indices.
[M.Switch.pq](https://gist.githubusercontent.com/ImkeF/04f62a920f9ec9f16c1cfce70473608d/raw/e84bc18a1f013acfeeb344a286c59198687c2efc/M.Switch.pq) | Evaluates an  <code>Expression</code>  against a list of  <code>Values</code>  and returns one or multiple possible  <code>Results</code>  expressions.
[GetCodeFromGithub.pq](https://github.com/ImkeF/M/tree/master/Library/GetCodeFromGithub.pq) | 
## R Statistical Functions
Function | Description
-------- | -----------
[R Trend.pq](https://gist.githubusercontent.com/ImkeF/f62623fbef37b08c55b37cc07e6f4b07/raw/190d21dff4e228c6b0df88330993e05f5a014007/R%20Trend.pq) | R-function for trend (fitted(lm) and forecast (predict(lm)
## Record
Function | Description
-------- | -----------
[Record.FunctionToTable.pq](https://gist.githubusercontent.com/ImkeF/4ca73ece0883d1316f76ae4ad432bacc/raw/128239567bbe325b79cb0fefc1c08b34d903775f/Record.FunctionToTable.pq) | Transforms the function-record to a searcheable table showing metadata
[Record.AllQueries.pq](https://gist.githubusercontent.com/ImkeF/6adb85af867e89da77d0db4e98b83ee8/raw/995fca315b1c495109ea7d6d84efd6c11b933346/Record.AllQueries.pq) | Creates a record with different sorts of references to the existing queries in the query pane.
## Statistic
Function | Description
-------- | -----------
[XlsStat.Trend.pq](https://gist.githubusercontent.com/ImkeF/c2128a389f3ce9978b7b3a1fef0b2909/raw/c83760c5c8f15ee622d163740e45f243edb13b0c/XlsStat.Trend.pq) | Calculates a trend according to Excel's TREND-function but without the option to define your own slope and intercept.
## Table
Function | Description
-------- | -----------
[Table.SolveParentChild.pq](https://github.com/ImkeF/M/tree/master/Library/Table.SolveParentChild.pq) | Creates columns for all parents, multiple parents are supported
[Table.ReferenceDifferentRow.pq](https://gist.githubusercontent.com/ImkeF/7bdbabdea35fcd4403949177ff02ba7b/raw/be1faeea8b772e4316e7e93f794b610dc66fc3cc/Table.ReferenceDifferentRow.pq) | Adds columns to a <code>Table</code> with values from previous or next rows (according to the <code>Step</code>-index in the 2nd parameter)
[Table.UnpivotKeepNulls.pq](https://github.com/ImkeF/M/tree/master/Library/Table.UnpivotKeepNulls.pq) | Unpivots columns (or optional other columns) while keeping empty fields (with null). Any entry to the 3rd parameter will set to "Unpivot Other Columns" instead.
[Table.ToFunctionRecord.pq](https://gist.githubusercontent.com/ImkeF/b990a56ee5f2eadddb145324a9224a84/raw/dfd1786bdff7064b0caa447d5f448b0728219c31/Table.ToFunctionRecord.pq) | Converts a table with function code to a record where the function is active
[Table.UnpivotByNumbers.pq](https://github.com/ImkeF/M/tree/master/Library/Table.UnpivotByNumbers.pq) | Unpivots a table according to the number of columns and header rows passed on in the parameters
[ParentChildAllParents.pq](https://gist.githubusercontent.com/ImkeF/3a6b50e705bfbdbcb3480b6be505322a/raw/179e0bd0bced37328e92e54139c9ecdffbab301a/ParentChildAllParents.pq) | Creates columns for all parents, multiple parents are supported
[Table.ToMarkdown.pq](https://github.com/ImkeF/M/tree/master/Library/Table.ToMarkdown.pq) | 
[Table.ContainsAnywhere.pq](https://gist.githubusercontent.com/ImkeF/3bd562d00d9edd4d3be081f61b6d5f9e/raw/11481ab12900428c29117ed00131e46c21f5b2f5/Table.ContainsAnywhere.pq) | Checks if a string or list of strings is contained somewhere in the table.
[Table.ToMCode.pq](https://github.com/ImkeF/M/tree/master/Library/Table.ToMCode.pq) | Transforms a  <code>Table</code>  to a string of M code that will create that table in the query editor.
[Table.PreviousRow.pq](https://gist.githubusercontent.com/ImkeF/4ec90606617eb5a48e78e2ec02e7bdb8/raw/63369be8ea83ce24106ed27b6de53316bc1f9087/Table.PreviousRow.pq) | Superfast way to reference previous row
[Table.SortB.pq](https://github.com/ImkeF/M/tree/master/Library/Table.SortB.pq) | Buffered Table.Sort. Buffers the result to maintain the sort order in future referencing steps
[Table.ExpandAllColumns.pq](https://gist.githubusercontent.com/ImkeF/e529c319b603e497ee5ff1002b8ecbfc/raw/e1e7efa25fb75209515b776ee4f8097be9c0e49d/Table.ExpandAllColumns.pq) | Expands all columns from different tables within one column at once
[Table.ReplaceMultiple.pq](https://github.com/ImkeF/M/tree/master/Library/Table.ReplaceMultiple.pq) | Replaces multiple values at a time in a table column without recursion: http://www.thebiccountant.com/2016/05/22/multiple-replacements-in-power-bi-and-power-query/ The <code>ReplacementsTable </code> must have the values to be replaced in the 1st column and the new value in the 2nd.
[Table.SolveParentChild.pq](https://gist.githubusercontent.com/ImkeF/ed839fb6b3b73a1315270c95a8a44651/raw/2c34ff1e9e643fda878e14191d69b53ed3488ce3/Table.SolveParentChild.pq) | Creates columns for all parents, multiple parents are supported
[Table.ClusteredIndex.pq](https://github.com/ImkeF/M/tree/master/Library/Table.ClusteredIndex.pq) | Returns a <code>Table</code> with a new column with a specific <code>name</code> that, for each row, contains an index of the row in the table.
[Date.DatesBetween.pq](https://gist.githubusercontent.com/ImkeF/9bd1e4d3a9aecc999fb8883c5fd0a318/raw/b985d0de25e171558968828d1b934a095fd578fc/Date.DatesBetween.pq) | Creates a list of dates according to the chosen interval between Start and End. Allowed values for 3rd parameter: "Year", "Quarter", "Month", "Week" or "Day".
[Table.NestedJoinSQL.pq](https://github.com/ImkeF/M/tree/master/Library/Table.NestedJoinSQL.pq) | 
[TableFlattenJSON.pq](https://gist.githubusercontent.com/ImkeF/1dfcac25caa1fb5ec2af831fec8b15bb/raw/953f973f42d4923759f7bdf71c4ff051532538f0/TableFlattenJSON.pq) | Flattens expanded JSON table
[Table.DistinctCI.pq](https://github.com/ImkeF/M/tree/master/Library/Table.DistinctCI.pq) | Case insensitive Table.Distinct
[Table.AddRollingSum](https://gist.githubusercontent.com/ImkeF/821b98966cb543df1bd0ceab0b5f802c/raw/1ed275cbb8767f98c9aecd3b83d53dd5935fdb65/Table.AddRollingSum) | Adds a column with a rolling sum to a table.
[Table.ColumnRunningTotal.pq](https://github.com/ImkeF/M/tree/master/Library/Table.ColumnRunningTotal.pq) | Fast way to add running total to a table
[Table.ExportCsvPyhton.pq](https://gist.githubusercontent.com/ImkeF/9e30713789aa50e7e52c4a161af624a7/raw/b16be1614b79bb567f5c0e1e03f47664bade5961/Table.ExportCsvPyhton.pq) | Exports table to csv using Python-script.
[Table.BlendDataTableau.pq](https://github.com/ImkeF/M/tree/master/Library/Table.BlendDataTableau.pq) | Blends table data like in Tableau. See: http://www.thebiccountant.com/2017/02/23/blending-data-in-powerbi-like-in-tableau/
[TransformColumnTypesDynamically.pq](https://gist.githubusercontent.com/ImkeF/6af3d67c91b81d9eb0adceba0261a252/raw/1ef5daebbd226e2cae1f52f9b28a6dd814225001/TransformColumnTypesDynamically.pq) | Dynamically transforms column types from table  <code>t</code> according to the columns contens of its first 10 rows by default. The number of rows to be taken into consideration can be adjusted by the optional parameter  <code>maxSample</code>.
[Table.BillOfMaterialsBasic.pq](https://github.com/ImkeF/M/tree/master/Library/Table.BillOfMaterialsBasic.pq) | Dynamically solve a Bill of materials-structure, generating as many hierarch-columns as necessary. See: http://www.thebiccountant.com/2017/05/08/dynamic-bill-of-material-bom-solution-in-excel-and-powerbi/#more-1782 .
[Table.ImputerColumn.pq](https://gist.githubusercontent.com/ImkeF/ebb803f10ba17af6bb6a5d11d9a22c44/raw/6d1add69588638c6eefe547949ce7205de8f6997/Table.ImputerColumn.pq) | Replaces null values in a column with an aggregation of its existing values. Options: Replace nulls in all columns (leave the 3rd param. blank), replace with a figure from a different column (columns names goes into 4th param.), take row-aggregation instead/horizontal (use 1 in 5th param.).
[Table.AddMergeOtherColumns.pq](https://github.com/ImkeF/M/tree/master/Library/Table.AddMergeOtherColumns.pq) | Adds a column named <code>MergedColumnName</code> to a <code>Table</code> that merges all other columns than named <code>OtherColumnNames</code>. <code>Delimiter</code> as a text string.
[Table.InnerJoinForSQLFolding.pq](https://gist.githubusercontent.com/ImkeF/c8676c747a0e9ff6197d27efacf51708/raw/73b15ca06441c55f7f1ecb401ac0c0d60a7274d0/Table.InnerJoinForSQLFolding.pq) | Performs an inner join on a sql table with a non-sql-source that will fold. To be used as filter only, as none of the non-SQL columns can be expanded.
[Table.PivotSingleColumn.pq](https://github.com/ImkeF/M/tree/master/Library/Table.PivotSingleColumn.pq) | Transforms a <code>Table</code> with a single column into a table with <code>NumberOfColumns</code>.
[Table.GroupDynamicAggregation.pq](https://gist.githubusercontent.com/ImkeF/87130d9f67837dbceb3f1d5b3847c0cb/raw/e43b5a75874a7d702f1ff32a996fa94789a0c968/Table.GroupDynamicAggregation.pq) | Aggregates all columns from the <code>SourceTable</code> that are not included in <code>GroupColumnNames</code> with Sum as default operation. This can be changed in optional parameter <code>AggregationFunction</code>.
[Table.ExportToCsv.pq](https://github.com/ImkeF/M/tree/master/LibraryR/Table.ExportToCsv.pq) | Exports a table to a csv file using R-script in PowerBI Desktop. You can pass the path in with backward-slashes, that will be reversed automatically.
[Table.ColumnRunningTotal.pq](https://gist.githubusercontent.com/ImkeF/2523e8f057d7cab998687ad3c5af72e2/raw/2958e5bc68d844027319f490aa42ad5ba6009877/Table.ColumnRunningTotal.pq) | Fast way to add running total to a table
[Table.JsonExpandAll.pq](https://gist.githubusercontent.com/ImkeF/fb25fcb541981c29bd72dcccaaec8972/raw/535e7fa44c26a967e3050c85466cfe62e0e18979/Table.JsonExpandAll.pq) | Dynamically expands the <Json> Record and returns values in one column and additional columns to navigate.
[Table.RenameColumnsWithFunction.pq](https://gist.githubusercontent.com/ImkeF/2198118707e41dc5d801dd1d2415a172/raw/aeb98458b83e2686a761d7e39f46bb7b9278dd3c/Table.RenameColumnsWithFunction.pq) | Returns a <code>Table</code> with the column names transformed according to <code>MyFunction</code> from the 2nd parameter
[Table.ExpandAllXML.pq](https://gist.githubusercontent.com/ImkeF/fd9e08a2812a06c431cc98cb102ad922/raw/545ffebb6d0457c517c117ac84cd5d145fc89ef9/Table.ExpandAllXML.pq) | Dynamically expands the <XML> table ("Name" and "Value" as column headers) and returns values in one column and additional columns to navigate.
[Table.AddColumnT.pq](https://gist.githubusercontent.com/ImkeF/c9fa0500766b009de121d4c17a644cb9/raw/45cdd2e156242c405f0b19eccd42f1ad174b50ec/Table.AddColumnT.pq) | Adds a column to a  <code>Table_</code> that originates from a  list holding the values for the  <code>newColumn</code> . New <code>columnName</code>  to be passed as the last argument.
## Text
Function | Description
-------- | -----------
[Text.BetweenDelimitersOccAll.pq](https://github.com/ImkeF/M/tree/master/Library/Text.BetweenDelimitersOccAll.pq) | Returns  all occurrances of text strings between a delimiter pair. Optional parameter Alternative_Dummy can be used if Dummy shall not be *+*.
[Text.ShowHtmlTags.pq](https://gist.githubusercontent.com/ImkeF/3e5be93397a1aae7e037717f67084ba8/raw/8dd1ab3c19db71f11338da29614f15b503be1fe8/Text.ShowHtmlTags.pq) | Selects all Html tags from a text
[Text.RemoveHtmlTags.pq](https://github.com/ImkeF/M/tree/master/Library/Text.RemoveHtmlTags.pq) | Removes all Html tags from a text
[Text.BetweenDelimitersOccAll.pq](https://gist.githubusercontent.com/ImkeF/828b4c58dfd3ff4f3f7184b0f710e187/raw/6076b4b7feed0865d88fef560e685a66abebcd93/Text.BetweenDelimitersOccAll.pq) | Returns  all occurrances of text strings between a delimiter pair.
[Text.RemoveRepeatingCharacters.pq](https://github.com/ImkeF/M/tree/master/Library/Text.RemoveRepeatingCharacters.pq) | Removes repeating characters of the delimiter from a string
[Text.QueryNames.pq](https://gist.githubusercontent.com/ImkeF/0b26e771dbcfba362a97d7bf09d4cb33/raw/57e562b5f1e7fbd19442847c78079211c53da4e8/Text.QueryNames.pq) | Creates a string with all query names from the current file. Can only be used in the query editor, as shared will not work when loaded to the data model
[Text.FunctionRecordExpressionEvaluate.pq](https://gist.githubusercontent.com/ImkeF/287b48232079e5f69bc1e72019bd6b71/raw/b53e899940291d0a6d629aa092fd6e51a71d389c/Text.FunctionRecordExpressionEvaluate.pq) | Creates a string for a record or function (if 2nd parameter is used) for the function record in Expression.Evaluate, replacing #shared.
[Text.RemoveBetweenDelimiters.pq](https://gist.githubusercontent.com/ImkeF/b025cac646c90de394d9d96b6061b12b/raw/d6ee23d6d7d49c7a6b61f272fdb0c95d37252b31/Text.RemoveBetweenDelimiters.pq) | Removes text between 2 delimiters.
## Type
Function | Description
-------- | -----------
[Type.Text.pq](https://gist.githubusercontent.com/ImkeF/1633eef352bb017b4d84ad3cd23d394e/raw/c28a528a4c0ef15558bd2bbed78703f14f7aacef/Type.Text.pq) | Returns the type of the  <code>Value</code> in textform.
[Type.AsText](https://gist.githubusercontent.com/ImkeF/a26b34de8c88163f10a6b0dad901670e/raw/bcb176fb0e796bf9bef16417a4a3406e68e52a65/Type.AsText) | Returns type in text format
[Type.FromText](https://gist.githubusercontent.com/ImkeF/1d294fea374aff873f4b1ef87042d74e/raw/9b89933b70ae70f9acd2cd1fbee40cc3cfa88714/Type.FromText) | Returns a type from its textual representation.
