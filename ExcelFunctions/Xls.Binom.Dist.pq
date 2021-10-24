let func =   
 (x, n, p, IsCumulative) =>
    let
        MassFunction = (Number.Factorial(n) / (Number.Factorial(n - x) * Number.Factorial(x)))
            * Number.Power(p, x)
            * Number.Power(1 - p, n - x),
        CumulativeFunction =
            let
                myTable = Table.FromColumns({{0 .. x}}, {"Value"}),
                #"Added Custom" = Table.AddColumn(
                    myTable,
                    "B",
                    each (
                        Number.Factorial(n)
                            / (Number.Factorial(n - [Value]) * Number.Factorial([Value]))
                            * Number.Power(p, [Value])
                            * Number.Power(1 - p, n - [Value])
                    )
                ),
                Custom2 = List.Sum(#"Added Custom"[B])
            in
                Custom2,
        Case = if IsCumulative = 0 then MassFunction else CumulativeFunction
    in
        Case ,
documentation = [
Documentation.Name =  " Xls.Binom.Dist.pq ",
Documentation.Description = " Returns the individual term binomial distribution probability ",
Documentation.LongDescription = " Returns the individual term binomial distribution probability ",
Documentation.Category = " Xls.Statistical ",
Documentation.Source = " www.TheBIcountant.com ",
Documentation.Version = " 1.0 ",
Documentation.Author = " Imke Feldmann ",
Documentation.Examples = {[Description =  "  ",
Code = "  ",
Result = "  "]}]
  
 in  
  Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))  