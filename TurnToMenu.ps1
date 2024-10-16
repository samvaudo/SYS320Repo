./"Local User Menu"/StringHelper.ps1
./"Local User Menu"/Event-Logs.ps1
./"Local User Menu"/Users.ps1
./apache.ps1


clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - Display Last 10 Apache Logs`n"
$Prompt += "2 - Display last 10 Failed Logins`n"
$Prompt += "3 - Display at risk users`n"
$Prompt += "4 - Start Chrome`n"
$Prompt += "5 - Exit`n"

$operation = $true

while($operation){
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 5){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
        ApacheLogs1
    }

    elseif($choice -eq 2){
        $name = Read-Host -Prompt "Please enter the username for the user's failed login logs"

        # TODO: Check the given username with the checkUser function.
        if (checkUser($name) -not True){
            Write-Host "User does not exist, try again"
            continue
        }
        $days = Read-Host -Prompt "Enter the number of days to be displayed"
        $userLogins = getFailedLogins $days
        # TODO: Change the above line in a way that, the days 90 should be taken from the user

        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
    }
    elseif($choice -eq 3){
        $days = Read-Host -Prompt "Enter the number of days to be checked for at risk users"
        $userLogins = getFailedLogins $days
         
        $userExessive = $userLogins | Group-Object -Property Name | Where-Object {$_.Count -ge 10}

        if ($userExessive.Count -eq 0) { Write-Host "No at risk users" }

        else{
            Write-Host $userExessive
    }
    elseif($choice -eq 4){
        $chromeProcess = Get-Process -Name chrome -ErrorAction SilentlyContinue

        if ($chromeProcess) {
            Write-Host "Google Chrome is running. Stopping all instances..."
            Stop-Process -Name chrome -Force
            Write-Host "All instances of Google Chrome have been stopped."
        } else {

            Write-Host "Google Chrome is not running. Starting Chrome and navigating to Champlain.edu..."
            Start-Process "chrome.exe" "https://www.champlain.edu"
            Write-Host "Google Chrome has been started and directed to Champlain.edu."
        }
    }