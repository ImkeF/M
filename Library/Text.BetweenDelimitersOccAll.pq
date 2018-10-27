let func =   
 (InputText as text, StartDelimiter as text, EndDelimiter as text, optional Alternative_Dummy as text) =>

let
    // If the end delimiter contains the same characters than the start delimiter then that portion has to be replaced in the end parameter by a dummy. Otherwise the query fails.
    AlternativeDummy = Alternative_Dummy,
    Dummy = if AlternativeDummy is null then "*+*" else AlternativeDummy,
    String = InputText,
    ParaStart = StartDelimiter,
    ParaEnd = EndDelimiter,
    
    // If the delimiters are identical, a different logic has to be applied.
    IdenticalDelimiters = ParaEnd = ParaStart,
    // Start of logic for identical delimiters
    SplitText = Text.Split(String, ParaStart),
    ResultIdenticalDelimiters = List.Alternate(SplitText,1,1),
    
    // Start of logic for different start- and end-delimiters: Create dummy end-delimiter.
    DummyParaEnd = Text.Replace(ParaEnd, ParaStart, Dummy),
    DummyString = Text.Replace(String, ParaEnd, DummyParaEnd),
    SplitByParaStart = List.Skip(Text.Split(DummyString, ParaStart),1),
    ConvertToTable = Table.FromList(SplitByParaStart, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    ExtractBeforeParaEnd = Table.AddColumn(ConvertToTable, "Result", each Text.BeforeDelimiter([Column1], DummyParaEnd)),
    Cleanup = Table.RemoveColumns(ExtractBeforeParaEnd,{"Column1"})[Result],
    
    Result = if Text.Contains(String, ParaStart) and Text.Contains(String, ParaEnd) 
                then (if IdenticalDelimiters 
                        then ResultIdenticalDelimiters 
                        else Cleanup) 
                else error Error.Record( "At least one of the delimiters is not found in the string" )
in
    Result ,
documentation = [
Documentation.Name =  " Text.BetweenDelimitersOccAll ",
Documentation.Description = " Returns  all occurrances of text strings between a delimiter pair.  ",
Documentation.LongDescription = " Returns  all occurrances of text strings between a delimiter pair. Optional parameter Alternative_Dummy can be used if Dummy shall not be *+*. ",
Documentation.Category = " Text ",
Documentation.Source = " https://wp.me/p6lgsG-Y5 ",
Documentation.Version = " 1.0 ",
Documentation.Author = " Imke Feldmann: www.TheBIccountant.com: https://wp.me/p6lgsG-Y5  . ",
Documentation.Examples = {[Description =  " See this blogpost: https://wp.me/p6lgsG-Y5 ",
Code = " TextBetweenDelimitersOccAll(""Meanwhile I prefer *Python!* to *R!*"", ""*"", ""!*"") ",
Result = " {""Python"", ""R""} "]}]
  
 in  
  Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))  
