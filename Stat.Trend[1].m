
//*ShortDescr** Calculates a trend according to Excel's TREND-function but without the option to define your own slope and intercept.
// Slope and intercept will be calculated according to the input data.
// Use: Just pass the values from the past that shall be considered (YList) and the number of intervalls (NoOfIntervalls) to be calculated for the future.
// Suggested improvement: Completely harmonize to EXCEL-TREND:
// a) Options to omitt intercept ([CONST]=FALSE)
// b) Use specific [known_x's] instead of default {0...n}
// c) Harmonize input parameter syntax
(YList as list, NoOfIntervalls as number) =>

let
Source = Table.FromColumns({YList}),
xAxis = Table.AddIndexColumn(Source, "Index", 1, 1),
Rename1 = Table.RenameColumns(xAxis,{{"Column1", "y"}, {"Index", "x"}}),
AvgX = List.Average(Rename1[x]),
AvgY = List.Average(Rename1[y]),
x = Table.AddColumn(Rename1, "xX", each [x]-List.Average(Rename1[x])),
y = Table.AddColumn(x, "yY", each [y]-List.Average(x[y])),
xy = Table.AddColumn(y, "xy", each [xX]*[yY]),
xXx = Table.AddColumn(xy, "xXx", each [xX]*[xX]),
a = List.Sum(xXx[xy])/List.Sum(xXx[xXx]),
b = AvgY-(a*AvgX),
ListIntervalls = {List.Max(Rename1[x])+1..List.Max(Rename1[x])+NoOfIntervalls},
TableIntervalls = Table.FromList(ListIntervalls, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
Rename = Table.RenameColumns(TableIntervalls,{{"Column1", "x"}}),
Values = Table.AddColumn(Rename, "y", each [x]*a+b),
TREND = Table.Combine({Rename1,Values})
in
TREND


 
