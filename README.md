Text
# M
This repo contains custom functions in the language M, which can be used in Power BI, Power Query (or Get & Transform) in Excel or in Analysis Services (version 2017 upwards).  

This video describes how to use them:  

There are currently 2 libraries:   
+ Library: Main library who holds pure M-functions
+ LibraryR: Holds M-functions that contain R-code. So you need to have R installed for them to run. But once installed and configured, you can use these functions just like the other M-functions. Further details check out here: [Using R in the Query Editor]( https://docs.microsoft.com/en-us/power-bi/desktop-r-in-query-editor)   

If you want to have these functions “at your fingertips” without manually copy- & pasting them into every single file, you can also use M-extensions. They will make all those custom functions part of the native function library so that you can use them all alike. See here how that works: [Create a function library in Power BI using M extensions](http://www.thebiccountant.com/2017/10/06/create-a-function-library-in-power-bi-using-m-extensions/) 


## Table of contents:
 
## Date
"Function | Description
-------- | -----------
[Date.DatesBetween.pq](https://github.com/ImkeF/M/blob/master/Library/Date.DatesBetween.pq) | Creates a list of dates according to the chosen interval between Start and End. The dates created will always be at the end of the interval, so could be in the future if today is chosen.
[Date.DimDate.pq](https://github.com/ImkeF/M/blob/master/Library/Date.DimDate.pq) | Standard DimDate gregorian calendar accd. To Marco Russo DAX calendar"
## Function
"Function | Description
-------- | -----------
[Function.Pipe.pq](https://github.com/ImkeF/M/blob/master/Library/Function.Pipe.pq) | Allows you to pipe your M functions"
## Other
"Function | Description
-------- | -----------
[GetCodeFromGithub.pq](https://github.com/ImkeF/M/blob/master/Library/GetCodeFromGithub.pq)
[SQLFirstNRowsFromAllTables.pq](https://github.com/ImkeF/M/blob/master/Library/SQLFirstNRowsFromAllTables.pq) | fetches the first N rows in all tables (and views) from a database at once and presents them in a compact form"
## Stat
"Function | Description
-------- | -----------
[Stat.Trend.pq](https://github.com/ImkeF/M/blob/master/Library/Stat.Trend.pq)"
## Table
"Function | Description
-------- | -----------
[Table.ColumnRunningTotal.pq](https://github.com/ImkeF/M/blob/master/Library/Table.ColumnRunningTotal.pq) | Fast way to add running total to a table
[Table.ExportToCsvR.pq](https://github.com/ImkeF/M/blob/master/Library/Table.ExportToCsvR.pq)
[Table.ParentChildAllParents.pq](https://github.com/ImkeF/M/blob/master/Library/Table.ParentChildAllParents.pq)
[Table.ToMarkdown.pq](https://github.com/ImkeF/M/blob/master/Library/Table.ToMarkdown.pq)
[Table.UnpivotByNumbers.pq](https://github.com/ImkeF/M/blob/master/Library/Table.UnpivotByNumbers.pq) | Unpivots a table according to the number of columns and header rows passed on in the parameters"
## Text
"Function | Description
-------- | -----------
[Text.RemoveHtmlTags.pq](https://github.com/ImkeF/M/blob/master/Library/Text.RemoveHtmlTags.pq) | Removes all Html tags from a text"
