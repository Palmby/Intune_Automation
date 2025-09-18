<#
Automates the Device Hash pull of devices and moves it to an Azure Blob (does not support uploading into Intune automatically at this time) 
#>


#Install Autopilot Script from Powershell Gallery 
write-host "Pulling Autopilot Script and Enabling WinRM" -ForegroundColor Green
install-script -name get-windowsautopilotinfo -Force
Enable-PSRemoting -SkipNetworkProfileCheck -Force | Out-Null

$path = test-path C:\devicehash

#testing path
if ($path)
{
write-host "Path Exists" -ForegroundColor Green
}

else {
    mkdir C:\devicehash | Out-Null
    write-host "Path does Not Exist, Creating" -ForegroundColor Red
}

#get azcopy
Invoke-WebRequest -Uri "https://aka.ms/downloadazcopy-v10-windows" -OutFile C:\devicehash\AzCopy.zip -UseBasicParsing
Expand-Archive C:\devicehash/AzCopy.zip C:\devicehash\AzCopy -Force
Get-ChildItem C:\devicehash/AzCopy/*/azcopy.exe | Move-Item -Destination C:\devicehash

Get-WindowsAutoPilotInfo.ps1 -outputfile "C:\devicehash\$env:COMPUTERNAME.csv" -append 

C:\devicehash\azcopy.exe copy "C:\devicehash\$env:COMPUTERNAME.csv" #BLOB SAS SIGNATURE""


remove-item C:\devicehash -Recurse -Force
Write-Host "Folder C:\devicehash has been removed" -ForegroundColor "Yellow"
