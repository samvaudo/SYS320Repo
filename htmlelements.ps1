$scraped_page = Invoke-WebRequest -UserAgent 10 http://10.0.17.39/ToBeScraped.html
<#
Write-Output "Number 9"
$scraped_page.Count

# 10
Write-Output "Number 10"
$scraped_page.Links

# 11
Write-Output "Number 11"
$scraped_page.Links | Select-Object Href, OuterText


#12
Write-Output "Number 12"
$h2s = 1
$h2s = $scraped_page.ParsedHtml.body.getElementsByTagName("h2") | Select-Object OuterText

$h2s

#>

$divs1=$scraped_page.ParsedHtml.body.getElementsByTagName("div") | Where-Object { $_.getAttributeNode("class").Value -like "div-1" } | select innerText

$divs1