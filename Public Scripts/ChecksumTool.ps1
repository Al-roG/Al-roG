# A simple tool to make sure the checksum hasn't been altered

Write-Host "############################" -ForegroundColor Cyan 
Write-Host "### " -F Cyan -NoNewline; `
Write-Host "Rognli Checksum Tool" -F Yellow -NoNewline; `
Write-Host " ###" -F Cyan
Write-Host "############################" -ForegroundColor Cyan
Write-Host ""
Write-Host ""

Write-Host " Input filepath to downloaded file: " -F Yellow -NoNewline; $FileToCompare = Read-Host
$FilePath = $FileToCompare -replace '"', ''
Write-Host ""
Write-Host " Input the file hash from the source: " -F Yellow -NoNewline; $TrueHash = Read-Host 
Write-Host ""


if (( Get-FileHash $FilePath ).Hash -eq $TrueHash)
{ Write-host "The file hash is correct. The file is safe to use." -ForegroundColor Green }
else 
{ Write-Host "The file hash is a mismatch. Do NOT use this file." -ForegroundColor Red }

Write-Host ""
Write-Host "Press any key to exit..." -ForegroundColor Cyan -NoNewline; Read-Host
Exit