let func =  
 (Start as date, End as date, optional Culture as text) =>

let
/*
    culture = if Culture = null then "en-US" else,
    Start = #date(2016, 1, 1),
    End = #date(2018,12,31),
*/

    culture = if Culture = null then "en-US" else Culture,
    Start = Start,
    End = End,
    TodayReference = Date.From(DateTime.LocalNow()),
    FirstYear = Date.Year(Start),
    LastYear = Date.Year(DateTime.LocalNow()),
    // For Fiscal 52-53 weeks (start depends on rules)
    FiscalCalendarFirstMonth = 7,
    // Use: 0 - Sunday, 1 - Monday, 2 - Tuesday, ... 5 - Friday, 6 - Saturday
    FirstDayOfWeek = 0,
    // Use: "Nearest" or "Last" 
    WeeklyType = "Nearest",
    // -- Supports only "445", "454", and "544"
    // -- Last:    for last weekday of the month at fiscal year end
    // -- Nearest: for last weekday nearest the end of month 
    // -- Reference for Last/Nearest definition: https://en.wikipedia.org/wiki/4%E2%80%934%E2%80%935_calendar)
    // --
    // -- For ISO calendar use 
    // --   FiscalCalendarFirstMonth = 1 (ISO always starts in January)
    // --   FirstDayOfWeek = 1           (ISO always starts on Monday)
    // --   WeeklyType = "Nearest"       (ISO use the nearest week type algorithm)
    // -- For US with last Saturday of the month at fiscal year end
    // --   FirstDayOfWeek = 0           (US weeks start on Sunday)
    // --   WeeklyType = "Last"
    // -- For US with last Saturday nearest the end of month
    // --   FirstDayOfWeek = 0           (US weeks start on Sunday)
    // --   WeeklyType = "Nearest"
    // --
    QuarterWeekType = """445""",
    // -- Prefix used in columns of standard Gregorian calendar
    CalendarGregorianPrefix = "",
    // Prefix used in columns of fiscal Gregorian calendar
    FiscalGregorianPrefix = "F",
    // -- Prefix used in columns of fiscal weekly calendar
    FiscalWeeklyPrefix = "FW ",
    // -- Supports "Weekly", "Custom"
    // -- Use CustomFiscalPeriods in case you need arbitrary definition of weekly fiscal years 
    // -- The first day of each year must be a weekday corresponding to the definition of FirstDayOfWeek
    WeeklyCalendarType = "Weekly",
    CustomFiscalPeriods_ = #table({"Fiscal YearNumber",
        "FirstDayOfYear", 
        "LastDayOfYear"},
        {
            { 2016 , "2016-06-28", "2016-07-02" },
            { 2017, "2016-07-03", "2017-07-01" },
            { 2018, "2017-07-02", "2018-06-30" },
            { 2019, "2018-07-01", "2019-06-29" }
        }
    ),
    CustomFiscalPeriods = Table.TransformColumnTypes(CustomFiscalPeriods_,{{"FirstDayOfYear", type date}, {"LastDayOfYear", type date}}),
    FirstDayCalendar = #date(FirstYear,1,1),
    LastDayCalendar = #date(LastYear,12,31),
    // Überprüfen!!
    WeekDayCalculationType = (FirstDayOfWeek),
    WFP1 = Table.FromColumns({{FirstYear..LastYear}}, {"Fiscal YearNumber"}),
    WFP2 = Table.AddColumn(WFP1, "CalendarType", each "Weekly"),
    #"Added Custom" = Table.AddColumn(WFP2, "FirstDayCurrentYear", each #date([Fiscal YearNumber], FiscalCalendarFirstMonth,1)),
    FirstDayNextYear = Table.AddColumn(#"Added Custom", "FirstDayNextYear", each #date([Fiscal YearNumber]+1, FiscalCalendarFirstMonth,1)),
    DayOfWeekNumberCurrentYear = Table.AddColumn(FirstDayNextYear, "DayOfWeekNumberCurrentYear", each Date.DayOfWeek([FirstDayCurrentYear], WeekDayCalculationType)),
    OffsetStartCurrentFiscalYear = Table.AddColumn(DayOfWeekNumberCurrentYear, "OffsetStartCurrentFiscalYear", each try if WeeklyType = "Last" then 1-[DayOfWeekNumberCurrentYear] else if [DayOfWeekNumberCurrentYear]>=5 then 8-[DayOfWeekNumberCurrentYear] else 1- [DayOfWeekNumberCurrentYear] otherwise "Unknown WeeklyType definition : "),
    DayOfWeekNumberNextYear = Table.AddColumn(OffsetStartCurrentFiscalYear, "DayOfWeekNumberNextYear", each Date.DayOfWeek([FirstDayNextYear], WeekDayCalculationType)),
    OffsetStartNextFiscalYear = Table.AddColumn(DayOfWeekNumberNextYear, "OffsetStartNextFiscalYear", each try if WeeklyType = "Last" then [DayOfWeekNumberCurrentYear] else if [DayOfWeekNumberCurrentYear]>=5 then 7-[DayOfWeekNumberCurrentYear] else - [DayOfWeekNumberCurrentYear] otherwise "Unknown WeeklyType definition : "),
    FirstDayOfYear = Table.AddColumn(OffsetStartNextFiscalYear, "FirstDayOfYear", each Date.AddDays([FirstDayCurrentYear],[OffsetStartCurrentFiscalYear])),
    WeeklyFiscalPeriods = Table.AddColumn(FirstDayOfYear, "LastDayOfYear", each Date.AddDays([FirstDayNextYear], [OffsetStartNextFiscalYear]-1)),
    CheckFirstDayOfWeek = if Date.DayOfWeek(List.Min(CustomFiscalPeriods[FirstDayOfYear]),1) <>FirstDayOfWeek+1 then "Error: CustomFiscalPeriods table does not match FirstDayOfWeek setting" else true,
    CustomFiscalPeriodsWithType = if CheckFirstDayOfWeek = true then Table.AddColumn(CustomFiscalPeriods, "CalendarType", each "Custom") else "Error",
    FiscalPeriods_ = Table.SelectColumns(Table.SelectRows(Table.Combine({WeeklyFiscalPeriods, CustomFiscalPeriodsWithType}), each [CalendarType] = WeeklyCalendarType), {"Fiscal YearNumber", "FirstDayOfYear", "LastDayOfYear"}),
    FiscalPeriods = Table.RenameColumns(FiscalPeriods_,{{"LastDayOfYear", "FW EndOfYear"}, {"FirstDayOfYear", "FW StartOfYear"}, {"Fiscal YearNumber", "FW YearNumber"}}),
    WeeksInP1 = Text.ToList(QuarterWeekType){1},
    WeeksInP2 = Text.ToList(QuarterWeekType){2},
    WeeksInP3 = Text.ToList(QuarterWeekType){3},
    FirstSundayReference = #date(1900,12,30),
    FirstWeekReference = Date.AddDays(FirstSundayReference, FirstDayOfWeek),
    RawDays = Table.FromColumns({List.Transform({Number.From(FirstDayCalendar)..Number.From(LastDayCalendar)}, each Date.From(_))}, {"Date"}),
    CalendarGregorianPrefixSpace = if  CalendarGregorianPrefix <> "" then CalendarGregorianPrefix & " " else "",
    FiscalGregorianPrefixSpace = if  FiscalGregorianPrefix <> "" then  FiscalGregorianPrefix & " " else "",
    FiscalWeeklyPrefixSpace = if  FiscalWeeklyPrefix <> "" then FiscalWeeklyPrefix & " " else "",
    #"Added Custom1" = Table.AddColumn(FiscalPeriods, "Date", each List.Transform({Number.From([FW StartOfYear])..Number.From([FW EndOfYear])}, each Date.From(_))),
    CustomFiscalRawDays = Table.ExpandListColumn(#"Added Custom1", "Date"),
    CSGB = Table.AddColumn(RawDays, "CalFields", each [DateKey = #"Calendar YearNumber"*10000, 
#"Calendar YearNumber"=Date.Year([Date]),
#"Calendar Year"=  CalendarGregorianPrefixSpace & Text.From(#"Calendar YearNumber"),
#"Calendar QuarterNumber"= Number.RoundUp( #"Calendar MonthNumber"/ 3, 0 ),
#"Calendar Quarter" = CalendarGregorianPrefix & "Q"
                    & Text.From(#"Calendar QuarterNumber")
                    & " ",
  #"Calendar YearQuarterNumber"= #"Calendar YearNumber"* 4

                    + #"Calendar QuarterNumber",
 #"Calendar Quarter Year"= CalendarGregorianPrefix   
& #"Calendar Quarter"
                    & " "
                    & Text.From(#"Calendar Year"),

#"Calendar MonthNumber" = Date.Month([Date]),
  #"Calendar Month"= Text.Start(Date.MonthName([Date], culture),3),
 #"Calendar YearMonthNumber" = #"Calendar YearNumber" * 12

                    + #"Calendar MonthNumber",
   #"Calendar Month Year"= #"Calendar Month"& " "& #"Calendar Year",
#"Calendar WeekNumber" = Date.WeekOfYear([Date], WeekDayCalculationType ),
   #"Calendar Week"= CalendarGregorianPrefix & "W"
                    & Text.PadStart( Text.From(#"Calendar WeekNumber"), 2 ,"0"),
#"Calendar YearWeekNumber" =  Number.IntegerDivide((  Number.From([Date])- Number.From(FirstWeekReference)), 7 ) ,
   #"Calendar Week Year"= CalendarGregorianPrefix 
                    & #"Calendar Week"
                    & "-"
                    & #"Calendar Year",
 #"Calendar WeekYearOrder"= #"Calendar YearNumber" * 100
                    + #"Calendar WeekNumber",
 #"Calendar DayOfYearNumber"= Date.DayOfYear([Date]),
#"Day of Month"= Date.Day([Date]),
WeekDayNumber = Date.DayOfWeek([Date])+1,
 #"Week Day"= Text.Start(Date.DayOfWeekName([Date], culture),3)
]),
    CalendarStandardGregorianBase = Table.ExpandRecordColumn(CSGB, "CalFields", Record.FieldNames(CSGB[CalFields]{0})),
CSG = Table.AddColumn(CalendarStandardGregorianBase, "CalGregorian", each [
#"Calendar RelativeWeekPos"=  List.Average(
                Table.SelectRows( CalendarStandardGregorianBase, each [Date] = TodayReference )
                [Calendar YearWeekNumber])-[Calendar YearWeekNumber],
#"Calendar RelativeMonthPos"= List.Average(
                Table.SelectRows( CalendarStandardGregorianBase, each [Date] = TodayReference )
                [Calendar YearMonthNumber])-[Calendar YearMonthNumber],
#"Calendar RelativeQuarterPos"= List.Average(
                Table.SelectRows( CalendarStandardGregorianBase, each [Date] = TodayReference )
                [Calendar YearQuarterNumber])-[Calendar YearQuarterNumber],
#"Calendar RelativeYearPos"= List.Average(
                Table.SelectRows( CalendarStandardGregorianBase, each [Date] = TodayReference )
                [Calendar YearNumber])-[Calendar YearNumber],     
#"Calendar StartOfMonth"= Date.StartOfMonth([Date]),
#"Calendar EndOfMonth"= Date.EndOfMonth([Date]),
#"Calendar DayOfMonth"= Date.Day([Date]),
#"Calendar StartOfQuarter"= Date.StartOfMonth(List.Min(Table.SelectRows(CalendarStandardGregorianBase, each [Calendar YearQuarterNumber] = [Calendar YearQuarterNumber])[Date])),
#"Calendar EndOfQuarter"= Date.StartOfMonth(List.Max(Table.SelectRows(CalendarStandardGregorianBase, each [Calendar YearQuarterNumber] = [Calendar YearQuarterNumber])[Date])),

#"Calendar DayOfQuarter"= Number.From([Date])-Number.From(#"Calendar StartOfQuarter")+1   
]),
    CalendarStandardGregorian = Table.ExpandRecordColumn(CSG, "CalGregorian", Record.FieldNames(CSG[CalGregorian]{0}))
in
    CalendarStandardGregorian
, documentation = [
Documentation.Name =  " Date.DimDate
", Documentation.Description = " Standard DimDate gregorian calendar accd. To Marco Russo DAX calendar
" , Documentation.LongDescription = " Standard DimDate gregorian calendar accd. To Marco Russo DAX calendar
", Documentation.Category = " Table
", Documentation.Source = " Calendar logic taken from Marco Russo DAX-calendar: https://github.com/marcosqlbi/DaxDateTemplate . 
", Documentation.Author = " Imke Feldmann: www.TheBIccountant.com
", Documentation.Examples = {[Description =  " 
" , Code = " 
 ", Result = " 
"]}] 
 in 
  Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation)) 

