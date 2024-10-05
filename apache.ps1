function ApacheLogs1(){
$logsNotformatted = GetContent -Path C:\xampp\apache\logs\access.log
$tableRecords = None

for ($i = 0; $i -lt $logsNotformatted.Count; $i++) {

$words = $line -split ' '
    $timestamp = $words[3].TrimStart('[') + " " + $words[4].TrimEnd(']')
            $method = $words[5].Trim('"')
            $url = $words[6]
            $ip = $words[0]
            $status = $words[8]
            $tableRecords += [pscustomobject]@{
                IP        = $ip
                Timestamp = $timestamp
                Method    = $method
                Url       = $url
                Status    = $status
}
}
return $tableRecords | Where-Object {$_.IP -like "10.*"}
}
$tableRecords = ApacheLogs1
$tableRecords | Format-Table -AutoSize -Wrap