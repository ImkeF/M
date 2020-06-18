let func =   
 (X as number, Mean as number, Standard_dev as number, Cumulative as logical) as number =>
if  Cumulative = false 
    then
        1/(Standard_dev*(Number.Sqrt(2*Number.PI) ))* 
        Number.Power(
            Number.E,
            -0.5* (Number.Power((X-Mean)/Standard_dev,2))
            )
    else 
        [   NormZ = Number.Abs( X - Mean) / Standard_dev,
            Calc = ( ( 1 / Number.Sqrt( 2 * Number.PI ) ) * ( Number.Power( Number.E, - ( Number.Power ( NormZ, 2 ) / 2 ) ) / 
                        ( 0.226 + 0.64 * NormZ + 0.33 * Number.Sqrt ( Number.Power( NormZ, 2 ) + 3 ) ) ) ),
            Result = if X < Mean then Calc else 1 - Calc
        ][Result] ,
documentation = [
Documentation.Name =  " Xls.NORMDIST.pq ",
Documentation.Description = " Returns the normal distribution for the specified mean and standard deviation.  ",
Documentation.LongDescription = " Returns the normal distribution for the specified mean and standard deviation. https://support.microsoft.com/en-us/office/normdist-function-126db625-c53e-4591-9a22-c9ff422d6d58 ",
Documentation.Category = " Xls.Statistical ",
Documentation.Source = " www.TheBIccountant.com  ",
Documentation.Version = " 1.0 ",
Documentation.Author = " Imke Feldmann ",
Documentation.Examples = {[Description =  "  ",
Code = "  ",
Result = "  "]}]
  
 in  
  Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))  
