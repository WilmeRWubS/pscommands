# Vraag de gebruiker om "enable" of "disable" in te voeren
$actie = Read-Host "Voer 'enable' of 'disable' in om het contextmenu in of uit te schakelen"

# RegPad en CLSID instellen
$regPath = "HKCU:\Software\Classes\CLSID"
$clsid = "{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}"
$subKey = "InprocServer32"

if ($actie -eq "disable") {
    # Schakel het eerste contextmenu uit
    New-Item -Path "$regPath\$clsid" -Force
    New-Item -Path "$regPath\$clsid\$subKey" -Force
    Set-ItemProperty -Path "$regPath\$clsid\$subKey" -Name "(Default)" -Value ""
    Write-Output "Contextmenu is uitgeschakeld. Verkenner wordt opnieuw gestart om de wijzigingen door te voeren."
} elseif ($actie -eq "enable") {
    # Schakel het eerste contextmenu in
    Remove-Item -Path "$regPath\$clsid" -Recurse -Force
    Write-Output "Contextmenu is ingeschakeld. Verkenner wordt opnieuw gestart om de wijzigingen door te voeren."
} else {
    Write-Output "Ongeldige invoer. Voer 'enable' of 'disable' in."
    exit
}

# Verkenner opnieuw starten
Stop-Process -Name "explorer" -Force
Start-Process "explorer"