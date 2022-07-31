Function pause ($message)
{
    # Check if running Powershell ISE
    if ($psISE)
    {
        Add-Type -AssemblyName System.Windows.Forms
        [System.Windows.Forms.MessageBox]::Show("$message")
    }
    else
    {
        Write-Host "$message" -ForegroundColor Yellow
        $x = $host.ui.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    }
}

Write-Output "Welcome to Fix-NetmarbleLauncher... Lets fix the Netmarble Launcher!"
$fileName = "$env:APPDATA/Netmarble Launcher/config.json"
$fileNameBackup = "$fileName.backup_$(Get-Date -Format FileDateTimeUniversal)"
Copy-Item $fileName $fileNameBackup
Write-Output " - Made a backup of your existing file to $fileNameBackup"

$settings = Get-Content -Raw $fileName | ConvertFrom-Json
$available = "$((Get-Volume -DriveLetter C | Select -ExpandProperty SizeRemaining)/1024/1024/1024) GB"
$jsonToAdd = """dist"":{""C"":{""available"": ""$available""}}"
$newSettings = @()

if ($settings.dist.C.available) {
	Write-Output " - Found an existing entry for C drive. Updating available disk space..."
	$settings.dist.C.available = $available
	$newSettings = ($settings | ConvertTo-Json -Depth 10)
} else {
	Write-Output " - Adding available disk space for C drive to launcher config..."
	$newSettings = ($settings | ConvertTo-Json -Depth 10) -replace """gameManageGames"": {},","""gameManageGames"": {},$jsonToAdd,"
	$newSettings = $newSettings | ConvertFrom-Json | ConvertTo-Json -Depth 10
}

Write-Output "All done. Please reopen the launcher now and install your game!"

$newSettings | Out-File $fileName

pause "Press any key to exit"