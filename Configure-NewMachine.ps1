function Install-Tools {
    iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))

    choco install -y googlechrome

    choco install -y sysinternals

    choco install -y beyondcompare2

    choco install -y fiddler4

    choco install -y curl

    choco install -y ilspy

    choco install -y git.install -params '"/GitOnlyOnPath /NoAutoCrlf"'

    choco install -y sublimetext2
}

function Disable-InternetExplorerESC {
    $AdminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
    if (Test-Path $AdminKey) {
        Set-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 0
    }
    
    $UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
    if (Test-Path $UserKey) {
        Set-ItemProperty -Path $UserKey -Name "IsInstalled" -Value 0
    }
    
    Write-Host "IE Enhanced Security Configuration (ESC) has been disabled." -ForegroundColor Green
}

function Change-FolderOptions {
    $Key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
    Set-ItemProperty $Key -Name "Hidden" -Value 1
    Set-ItemProperty $Key -Name "HideFileExt" -Value 0    
    Set-ItemProperty $Key -Name "HideDrivesWithNoMedia" -Value 1
    Write-Host "Folder options have been modified." -ForegroundColor Green
}

function TurnOff-UAC {
    New-ItemProperty -Path HKLM:Software\Microsoft\Windows\CurrentVersion\policies\system -Name EnableLUA -PropertyType DWord -Value 0 -Force
    Write-Host "UAC has been turned off. Restart computer to take effect." -ForegroundColor Green
}

Install-Tools

Disable-InternetExplorerESC

Change-FolderOptions

TurnOff-UAC

Restart-Computer
