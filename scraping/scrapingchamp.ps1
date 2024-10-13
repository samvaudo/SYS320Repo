function gatherClasses(){

$page = Invoke-WebRequest -TimeoutSec 2 http://10.0.17.39/courses-1.html

#Get all the tr elements of the HTML Doc

$trs=$page.ParsedHtml.body.getElementsByTagName("tr")

#Empty Array to hold
$FullTable = @()
for($i=1; $i -lt $trs.length; $i++){ #Loop through each element
    
    #Get each td element of tr element
    $tds = $trs[$i].getElementsByTagName("td")

    #Seporate Time date  from each field
    $Times = $tds[5].innerText.split("-")

    $FullTable += [PSCustomObject]@{"Class Code" = $tds[0].innerText; `
                                    "Title"      = $tds[1].innerText; `
                                    "Days"       = $tds[4].innerText; `
                                    "Time Start" = $Times[0]; `
                                    "Time End"   = $Times[1]; `
                                    "Instructor" = $tds[6].innerText; `
                                    "Location"   = $tds[9].innerText; `
                                }
}
return $FullTable
}

function daysTranslator($FullTable){
for ($i=0; $i -lt $FullTable.length; $i++){
    $Days = @();

    if($FullTable[$i].Days -ilike "M"){ $Days += "Monday" }

    if($FullTable[$i].Days -ilike "*T[TWF]*"){ $Days += "Tuesday" }
    ElseIf($FullTable[$i].Days -ilike "T"){ $Days += "Tuesday" }

    if($FullTable[$i].Days -ilike "W"){ $Days += "Wednesday" }

    if($FullTable[$i].Days -ilike "TH"){ $Days += "Thursday" }

    if($FullTable[$i].Days -ilike "*F"){ $Days += "Friday" }

    $FullTable[$i].Days = $Days
}
return $FullTable
}


