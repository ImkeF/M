let func =  
 let
ListDateImpl = 
(From as date, To as date, Selection as text) =>
let

/*Debug Parameters
From = #date(2007, 12, 24),
To = #date(2018, 1, 1),
Selection = "Week",
*/

IChain = (x as any, operations) => List.Accumulate(operations, x, (state, current) => Function.Invoke(current{0}, {state}&List.Skip(current))),

    CaseFunctions = [Day= {Date.AddDays, Number.From(To-From)+1, Date.From},
    Week = {Date.AddWeeks, Number.RoundUp((Number.From(To-From)+1)/7), Date.EndOfWeek},
    Month = {Date.AddMonths, (Date.Year(To)*12+Date.Month(To))-(Date.Year(From)*12+Date.Month(From))+1, Date.EndOfMonth},
    Quarter = {Date.AddQuarters, (Date.Year(To)*4+Date.QuarterOfYear(To))-(Date.Year(From)*4+Date.QuarterOfYear(From))+1, Date.EndOfQuarter},
    Year = {Date.AddYears,Date.Year(To)-Date.Year(From)+1, Date.EndOfYear} ],
    Case = Record.Field(CaseFunctions, Selection),
    DateFunction = List.Transform({0..Case{1}-1}, each Function.Invoke(Case{2}, {Function.Invoke(Case{0}, {From, _})})),
    Custom1 = List.Transform({0..Case{1}-1}, each IChain(From, {{Case{2}}, {Case{0}, _} }))
in
    Custom1,

ListDateType = type function (
    From as (type date meta [
        Documentation.FieldCaption = "From Date",
        Documentation.FieldDescription = "Select Start Date"
       // Documentation.SampleValues = {"Hello world", "Hola mundo"}
    ]),
  To as (type date meta [
        Documentation.FieldCaption = "To Date",
        Documentation.FieldDescription = "Select End Date"
       // Documentation.SampleValues = {"Hello world", "Hola mundo"}
    ]),
     Selection as (type text meta [
        Documentation.FieldCaption = "Select Date Interval",
        Documentation.FieldDescription = "Select Date Interval",
        Documentation.AllowedValues = {"Day", "Week", "Month", "Quarter", "Year"}
    ]))
    as table meta [
        Documentation.Name = "List of date intervalls",
        Documentation.LongDescription = "Creates list of dates intervals, select start, end and intervall",
        Documentation.Examples = {[
            Description = "",
            Code = "",
            Result = ""
        ]}
    ],


ListDatesIntervalls = Value.ReplaceType(ListDateImpl, ListDateType)

in
ListDatesIntervalls
, documentation = [
Documentation.Name =  " Dates.ListDateIntervals
", Documentation.Description = " Creates a list of dates according to the chosen interval between Start and End. Allowed values for 3rd parameter: "Year", "Quarter", "Month", "Week" or "Day".
" , Documentation.LongDescription = " Creates a list of dates according to the chosen interval between Start and End. The dates created will always be at the end of the interval, so could be in the future if today is chosen.
", Documentation.Category = " Table
", Documentation.Source = " local 
", Documentation.Author = " Imke Feldmann: www.TheBIccountant.com . 
", Documentation.Examples = {[Description =  " 
" , Code = " 
 ", Result = " 
"]}] 
 in 
  Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation)) 

