<div class="topic">
    <h1 class="title">Number.Mod</h1>
    <div id="mainSection">
      <div id="mainBody"> <p>This topic applies to the Power Query Formula Language which can be used with <a href="https://support.office.com/article/Introduction-to-Microsoft-Power-Query-for-Excel-6E92E2F4-2079-4E1F-BAD5-89F6269CD605">Power Query</a> and <a href="http://go.microsoft.com/fwlink/p/?LinkId=618607">Power BI Desktop</a> to build queries that mashup data. See the list of <a href="https://msdn.microsoft.com/en-us/library/mt211003.aspx">function categories</a>.</p><div><h2 class="LW_CollapsibleArea_TitleDiv"><div><a class="LW_CollapsibleArea_TitleAhref" title="Collapse" role="heading"><span class="cl_CollapsibleArea_expanding LW_CollapsibleArea_Img"></span><span class="LW_CollapsibleArea_Title">About</span></a><div id="Anchor_0" class="LW_CollapsibleArea_Anchor_Div"><a href="/en-us/library/mt253344.aspx#Anchor_0" class="LW_CollapsibleArea_Anchor_Img" title="Right-click to copy and share the link for this section"></a></div><div class="LW_CollapsibleArea_HrDiv"><hr class="LW_CollapsibleArea_Hr" /></div></div></h2><div class="sectionblock"><a id="About"></a></div></div><p>Divides two numbers and returns the remainder of the resulting number.</p>

```Number.Mod(number as nullable number, divisor as nullable number, optional precision as nullable number) as nullable number ```


<div><h2 class="LW_CollapsibleArea_TitleDiv"><div><a class="LW_CollapsibleArea_TitleAhref" title="Collapse" role="heading"><span class="cl_CollapsibleArea_expanding LW_CollapsibleArea_Img"></span><span class="LW_CollapsibleArea_Title">Arguments</span></a><div id="Anchor_1" class="LW_CollapsibleArea_Anchor_Div"><a href="/en-us/library/mt253344.aspx#Anchor_1" class="LW_CollapsibleArea_Anchor_Img" title="Right-click to copy and share the link for this section"></a></div><div class="LW_CollapsibleArea_HrDiv"><hr class="LW_CollapsibleArea_Hr" /></div></div></h2><div class="sectionblock"><a id="Arguments"></a></div></div><table Responsive="true" summary="table"><thead><tr Responsive="true"><th scope="col">Argument</th><th scope="col">Description</th></tr></thead><tbody><tr><td data-th="Argument">number</td><td data-th="Description">Dividend or numerator.</td></tr><tr><td data-th="Argument">divisor</td><td data-th="Description">Divisor or denominator.</td></tr></tbody></table><div><h2 class="LW_CollapsibleArea_TitleDiv"><div><a class="LW_CollapsibleArea_TitleAhref" title="Collapse" role="heading"><span class="cl_CollapsibleArea_expanding LW_CollapsibleArea_Img"></span><span class="LW_CollapsibleArea_Title">Example</span></a><div id="Anchor_2" class="LW_CollapsibleArea_Anchor_Div"><a href="/en-us/library/mt253344.aspx#Anchor_2" class="LW_CollapsibleArea_Anchor_Img" title="Right-click to copy and share the link for this section"></a></div><div class="LW_CollapsibleArea_HrDiv"><hr class="LW_CollapsibleArea_Hr" /></div></div></h2><div class="sectionblock"><a id="Example"></a></div></div>


```Number.Mod(83, 9)  ```   equals 2 



## Caveats
- Diverging signs at numerator and divisor will lead to different results compared to Excel and DAX (http://www.thebiccountant.com/2017/09/13/number-mod-rescue-pack-power-bi-power-query/) 


## Alternatives
- [Number.ModX](../Number.ModX.pq) : Returns the same results than the modulo-function in Excel and DAX 
