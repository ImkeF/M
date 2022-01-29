let func =   
 (SourceTable as table, KeyColumnName as text, CommaSeparatedListOfOtherColumnNames as text) =>
    let
        /* Debug parameters
    SourceTable = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("i45WSkxJU9JRcgTi3EoFN8+g4BAFl9Ti5KLMgpLM/DygsKFSrE60UlFJFUJZWmZRcQmaMlOwstKszGwgxwmiTqE4NTk/LwWiEihkBFaTn1NweBtCUbCrs7+fi4KLa7BzkGdAiKe/H1zl4T2HlxzelgPkO0PUlmRkFqWgWWysFBsLAA==", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type nullable text) meta [Serialized.Text = true]) in type table [Column1 = _t, MyKeyColumn = _t, MyDescriptionColumn = _t, MyNoColumn = _t]),
    KeyColumnName = "MyKeyColumn",
    CommaSeparatedListOfOtherColumnNames = "MyDescriptionColumn, MyNoColumn", 
    */ 
    
        TransformedColumNameList = List.Transform(
            Text.Split(CommaSeparatedListOfOtherColumnNames, ","), 
            each Text.Trim(Text.Clean(_))
        ), 
        Source = SourceTable, 
        LowercaseTable = Table.Distinct(
            Table.TransformColumns(
                Source, 
                List.Transform(
                    Table.ColumnNames(Source), 
                    each {_, (x) => Text.Lower(Text.From(x)), type text}
                )
            ), 
            {KeyColumnName} & TransformedColumNameList
        ), 
        GroupOnKeyColumn = Table.Group(
            LowercaseTable, 
            KeyColumnName, 
            {{"Count", List.Count}, {"Dups", each _}}
        ), 
        #"Filtered Rows" = Table.SelectRows(GroupOnKeyColumn, each ([Count] <> 1)), 
        #"Expanded Dups" = Table.ExpandTableColumn(
            #"Filtered Rows", 
            "Dups", 
            TransformedColumNameList
        )
    in
        #"Expanded Dups" ,
documentation = [
Documentation.Name =  " Check_DimensionTable ",
Documentation.Description = " Returns rows from a <code>SourceTable</code> whose dimension attributes are not unique per each <code>KeyColumnName</code> ",
Documentation.LongDescription = " Returns rows from a <code>SourceTable</code> whose dimension attributes (<code>CommaSeparatedListOfOtherColumnNames</code>) are not unique per each <code>KeyColumnName</code> ",
Documentation.Category = " Check ",
Documentation.Source = " www.TheBIcountant.com ",
Documentation.Version = " 1.0 ",
Documentation.Author = " Imke Feldmann ",
Documentation.Examples = {[Description =  "  ",
Code = " let
    FirstParameter = #table( type table [Column1 = Text.Type, MyKeyColumn = Text.Type, MyDescriptionColumn = Text.Type, MyNoColumn = Int64.Type], 
 
//  Column1| MyKeyColumn|     MyDescriptionColumn| MyNoColumn| 
{//--------|------------|------------------------|-----------|  
{     ""adf"",         ""A"",  ""my FIRST Description"",          1 }, 
{     ""rtz"",         ""A"",  ""my first Description"",          5 }, 
{    ""ujik"",         ""B"",      ""my  second Descr"",          2 }, 
{    ""olpö"",         ""B"", ""my SECOND DESCRIPTION"",          2 }, 
{    ""üäöl"",         ""C"",  ""my third Description"",          3 } } ) ,
SecondParameter = ""MyKeyColumn"",
ThirdParameter = ""MyDescriptionColumn, MyNoColumn"",
Result = Check_DimensionTable(FirstParameter, SecondParameter, ThirdParameter)
in
    Result ",
Result = " #table( type table [MyKeyColumn = Text.Type, Count = Number.Type, MyDescriptionColumn = Any.Type, MyNoColumn = Any.Type], 
 
//  MyKeyColumn| Count|     MyDescriptionColumn| MyNoColumn| 
{//------------|------|------------------------|-----------|  
{           ""a"",     2,  ""my first description"",        ""1"" }, 
{           ""a"",     2,  ""my first description"",        ""5"" }, 
{           ""b"",     2,      ""my  second descr"",        ""2"" }, 
{           ""b"",     2, ""my second description"",        ""2"" } } )  "]}]
  
 in  
  Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))  
