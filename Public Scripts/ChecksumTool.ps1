## Presentation & Credits
# This is a simple tool to make sure the checksum hasn't been altered on a file.
# Either input two file paths if you wish to compare two files.
# If you wish you compare a file towards a pre-fetched hash, select Manual input.


Write-Host "#####################################" -ForegroundColor Cyan 
Write-Host "### " -F Cyan -NoNewline; `
Write-Host "Rognli Checksum Tool | v2.4 |" -F Yellow -NoNewline; `
Write-Host " ###" -F Cyan
Write-Host "#####################################" -ForegroundColor Cyan
Write-Host ""
Write-Host ""

# Manual or Compare selection

    Do { Write-Host " Do you wish to (C)ompare two files or (M)anually input the hash? " -F Yellow -NoNewline; $UserSelection = Read-Host }
    While (( $UserSelection -notlike "M" ) -and ($UserSelection -notlike "C"))

# Compare hashes between two files

If ($UserSelection -eq 'C') { 

# Fetch, validate and trim the source file path

    Do { Write-Host " Input path to source file (within quotation marks): " -F Yellow -NoNewline; $SourceFilePath = Read-Host }
    While (( $SourceFilePath -Like '') -or ( Test-Path -Path $SourceFilePath -IsValid ))
    $SourceFile = $SourceFilePath -Replace '"', ''  
    
    Write-Host ""

# Fetch, validate and trim the comparison file path

    Do { Write-Host " Input path to comparison file (within quotation marks): " -F Yellow -NoNewline; $CompareFilePath = Read-Host }
    While (( $CompareFilePath -Like '' ) -or ( Test-Path -Path $CompareFilePath -IsValid ))
    $CompareFile = $CompareFilePath -Replace '"', ''
    Write-Host ""

# Execute the hash comparison 

    If (( Get-FileHash $SourceFile ).Hash -eq (Get-FileHash $CompareFile).Hash )
    { Write-host "The file hash is correct. The file is safe to use." -F Green }
    Else
    { Write-Host "The file hash is a mismatch. Do NOT use this file." -F Red }
}

# Manual hash input comparison

If ($UserSelection -eq 'M') { 

# Fetch and measure the manual source hash

    Do { Write-Host " Input source hash: " -F Yellow -NoNewline; $SourceHash = Read-Host }
    While (( $SourceHash -Like '' ) -or ( $SourceHash.Length -lt 64 ))
    Write-Host ""

# Fetch, validate and trim the comparison file path

    Do { Write-Host " Input path to comparison file (within quotation marks): " -F Yellow -NoNewline; $CompareFilePath = Read-Host }
    While (( $CompareFilePath -Like '' ) -or ( Test-Path -Path $CompareFilePath -IsValid ))
    $CompareFile = $CompareFilePath -Replace '"', ''
    Write-Host ""

# Execute the hash comparison

    If (( Get-FileHash $CompareFile ).Hash -eq $SourceHash )
    { Write-host "The file hash is correct. The file is safe to use." -F Green }
    Else
    { Write-Host "The file hash is a mismatch. Do NOT use this file." -F Red }
}

# End the script

Write-Host ""
$Prompt = "Do you wish to (E)xit or (R)eturn? "

Do {
    Write-Host $Prompt -F Cyan -NoNewline; $ExitChoice = Read-Host
    If ($ExitChoice -eq 'R')
    { Return }
    If ($ExitChoice -eq 'E')
    { Exit }
} While ( 
    $ExitChoice -ne 'R' -or 'E'
)
