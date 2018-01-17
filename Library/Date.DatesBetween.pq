let 
// ----------------------- Documentation ----------------------- 

documentation_ = [
Documentation.Name =  " Dates.DatesBetween
", Documentation.Description = " Creates a list of dates according to the chosen interval between Start and End. Allowed values for 3rd parameter: ""Year"", ""Quarter"", ""Month"", ""Week"" or ""Day"".
" , Documentation.LongDescription = " Creates a list of dates according to the chosen interval between Start and End. The dates created will always be at the end of the interval, so could be in the future if today is chosen.
", Documentation.Category = " Table
", Documentation.Source = " http://www.thebiccountant.com/2017/12/11/date-datesbetween-retrieve-dates-between-2-dates-power-bi-power-query/ . 
", Documentation.Author = " Imke Feldmann: www.TheBIccountant.com . 
", Documentation.Examples = {[Description =  " Check this blogpost: http://www.thebiccountant.com/2017/12/11/date-datesbetween-retrieve-dates-between-2-dates-power-bi-power-query/ .
" , Code = " 
 ", Result = " 
"]}],

// ----------------------- Function Code ----------------------- 
 
function_ =  

(From as date, To as date, optional Selection as text ) =>
let

// Create default-value "Day" if no selection for the 3rd parameter has been made
TimeInterval = if Selection = null then "Day" else Selection,

// Table with different values for each case
CaseFunctions = #table({"Case", "LastDateInTI", "TypeOfAddedTI", "NumberOfAddedTIs"},
		{   {"Day", Date.From, Date.AddDays, Number.From(To-From)+1},
		    {"Week", Date.EndOfWeek, Date.AddWeeks, Number.RoundUp((Number.From(To-From)+1)/7)},
		    {"Month", Date.EndOfMonth, Date.AddMonths, (Date.Year(To)*12+Date.Month(To))-(Date.Year(From)*12+Date.Month(From))+1},
		    {"Quarter", Date.EndOfQuarter, Date.AddQuarters, (Date.Year(To)*4+Date.QuarterOfYear(To))-(Date.Year(From)*4+Date.QuarterOfYear(From))+1},
		    {"Year", Date.EndOfYear, Date.AddYears,Date.Year(To)-Date.Year(From)+1} 
		} ),

// Filter table on selected case
		Case = CaseFunctions{[Case = TimeInterval]},
    
// Create list with dates: List with number of date intervals -> Add number of intervals to From-parameter -> shift dates at the end of each respective interval	
	DateFunction = List.Transform({0..Case[NumberOfAddedTIs]-1}, each Function.Invoke(Case[LastDateInTI], {Function.Invoke(Case[TypeOfAddedTI], {From, _})}))
in
    DateFunction,

// ----------------------- New Function Type ----------------------- 

type_ = type function (
      From as (type date),
      To as (type date),
      optional Selection as (type text meta [
                            Documentation.FieldCaption = "Select Date Interval",
                            Documentation.FieldDescription = "Select Date Interval, if nothing selected, the default value will be ""Day""",
                            Documentation.AllowedValues = {"Day", "Week", "Month", "Quarter", "Year"}
                            ])
        )
    as table meta documentation_,

// Replace the extisting type of the function with the individually defined
Result =  Value.ReplaceType(function_, type_)
 
 in 

Result
