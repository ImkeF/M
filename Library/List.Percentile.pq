let func =   
 (list as list, percentile as number, optional Exc as any) =>

let

PercentileInc = 
let
    IsValidPercentile = percentile >= 0 and percentile <= 1,
    SeriesCount = List.Count(list),
    PercentileRank = percentile*(SeriesCount - 1) + 1, 
    PercentileRankRoundedUp = Number.RoundUp(PercentileRank),
    PercentileRankRoundedDown = Number.RoundDown(PercentileRank),
    Percentile1 = List.Max(List.MinN(list,PercentileRankRoundedDown)),
    Percentile2 = List.Max(List.MinN(list,PercentileRankRoundedUp)),
    Percentile = if IsValidPercentile then 
                    Percentile1+(Percentile2 - Percentile1) * (PercentileRank - PercentileRankRoundedDown)
                 else error "percentile must be between 0 and 1, inclusive."
in
    Percentile,

PercentileExc = 
let
    IsValidPercentile = percentile > 0 and percentile < 1,
    SeriesCount = List.Count(list),
    PercentileRank = percentile*(SeriesCount + 1), //percentile argument entered as decimal
    PercentileRankRoundedUp = Number.RoundUp(PercentileRank),
    PercentileRankRoundedDown = Number.RoundDown(PercentileRank),
    Percentile1 = List.Max(List.MinN(list,PercentileRankRoundedDown)),
    Percentile2 = List.Max(List.MinN(list,PercentileRankRoundedUp)),
    Percentile = if IsValidPercentile then 
                     Percentile1 + (Percentile2 - Percentile1) * (PercentileRank - PercentileRankRoundedDown)
                 else error "percentile must be between 0 and 1, exclusive."
in
    Percentile,

Result = if Exc = null or Exc = 0 then PercentileInc else PercentileExc

in
Result ,
documentation = [
Documentation.Name =  " List.Percentile ",
Documentation.Description = " Returns the k-th <code>percentile</code> of values in a <code>list</code>.  ",
Documentation.LongDescription = " Returns the k-th <code>percentile</code> of values in a <code>list</code>.  Use ""1"" in 3rd parameter to set from Inc (default) to Exc . ",
Documentation.Category = " List ",
Documentation.Source = " . https://goo.gl/YTDBL1 . ",
Documentation.Version = " 1.0 ",
Documentation.Author = " Colin Banfield https://goo.gl/YTDBL1 . ",
Documentation.Examples = {[Description =  "  ",
Code = " List.Percentile({1, 3, 2, 4}, 0.3) ",
Result = " 1.9 "]}]
  
 in  
  Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))  

