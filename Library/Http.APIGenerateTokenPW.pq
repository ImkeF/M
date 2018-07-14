let func =   
 (username as text, password as text, client_id as text, client_secret as text,
 optional redirect_uri as text, optional token_uri as text, optional authorize_uri as text, optional resource as text) =>

let
   
    //URI's
    redirect_uri = if redirect_uri = null then "https://login.live.com/oauth20_desktop.srf" else redirect_uri,
    token_uri = if token_uri = null then "https://login.windows.net/common/oauth2/token" else token_uri, 
    authorize_uri = if authorize_uri = null then "https://login.windows.net/common/oauth2/authorize" else authorize_uri,
    resource = if resource = null then "https://analysis.windows.net/powerbi/api" else resource ,
    

   tokenResponse = Json.Document(Web.Contents(token_uri,          
                                [
                                    Content=
                                    Text.ToBinary(Uri.BuildQueryString(
                                    [
                                        client_id = client_id
                                        ,client_secret=client_secret
                                        ,username=username
                                        ,password=password
                                        ,resource=resource
                                        ,grant_type = "password"
                                        ,redirect_uri = redirect_uri
                                    ]))
                                    ,Headers=
                                        [Accept="application/json"]
                                        , ManualStatusHandling={400}
                                ])),
                                access_token = tokenResponse[access_token],
    token = tokenResponse[access_token]
in
    token ,
documentation = [
Documentation.Name =  " Http.APIGenerateTokenPW ",
Documentation.Description = " Generates a Token for an API with username and password ",
Documentation.LongDescription = " Generates a Token for an API with username and password. Urls default to Power BI API ",
Documentation.Category = " Other ",
Documentation.Source = " . https://prathy.com/2017/09/calling-power-bi-api-using-power-bi-desktop-to-document-power-bi-service/ . ",
Documentation.Version = " 1.0 ",
Documentation.Author = " Imke Feldmann converted query from Prathy Kamasani to function",
Documentation.Examples = {[Description =  "  ",
Code = "  ",
Result = "  "]}]
  
 in  
  Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))  
