## Presentation & Credits
# This is a simple tool to make sure the checksum hasn't been altered on a file.
# Either input two file paths if you wish to compare two files.
# If you wish you compare a file towards a pre-fetched hash, select Manual input.


Write-Host "###############################" -ForegroundColor Cyan 
Write-Host "### " -F Cyan -NoNewline; `
Write-Host "Rognli Checksum Tool v2" -F Yellow -NoNewline; `
Write-Host " ###" -F Cyan
Write-Host "###############################" -ForegroundColor Cyan
Write-Host ""
Write-Host ""

# Manual or Compare selection
Write-Host " Do you wish to (C)ompare two files or (M)anually input the hash? " -F Yellow -NoNewline; $UserSelection = Read-Host
Write-Host ""

# Compare hashes between two files

if ($UserSelection -eq 'C')
{ 
    Write-Host " Input path to source file: " -F Yellow -NoNewline; $SourceFilePath = Read-Host
    $SourceFile = $SourceFilePath -replace '"', ''
    Write-Host ""
    Write-Host " Input path to comparison file: " -F Yellow -NoNewline; $CompareFilePath = Read-Host
    $CompareFile = $CompareFilePath -replace '"', ''
    Write-Host ""
    if (( Get-FileHash $SourceFile ).Hash -eq (Get-FileHash $CompareFile).Hash )
    {  Write-host "The file hash is correct. The file is safe to use." -ForegroundColor Green }
    else
    { Write-Host "The file hash is a mismatch. Do NOT use this file." -ForegroundColor Red }
}

# Manual hash input comparison

if ($UserSelection -eq 'M')
{ 
    Write-Host " Input source hash: " -F Yellow -NoNewline; $SourceHash = Read-Host
    Write-Host ""
    Write-Host " Input path to comparison file: " -F Yellow -NoNewline; $CompareFilePath = Read-Host
    $CompareFile = $CompareFilePath -replace '"', ''
    Write-Host ""
    if (( Get-FileHash $CompareFile ).Hash -eq $SourceHash )
    {  Write-host "The file hash is correct. The file is safe to use." -ForegroundColor Green }
    else
    { Write-Host "The file hash is a mismatch. Do NOT use this file." -ForegroundColor Red }
}

# End the script

Write-Host ""
Write-Host "Press enter to end script..." -ForegroundColor Cyan -NoNewline; Read-Host
Return
