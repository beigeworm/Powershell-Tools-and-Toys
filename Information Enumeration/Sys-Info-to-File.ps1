﻿Add-Type -AssemblyName System.Windows.Forms

# WMI Classes
$systemInfo = Get-WmiObject -Class Win32_OperatingSystem
$userInfo = Get-WmiObject -Class Win32_UserAccount
$processorInfo = Get-WmiObject -Class Win32_Processor
$computerSystemInfo = Get-WmiObject -Class Win32_ComputerSystem
$userInfo = Get-WmiObject -Class Win32_UserAccount
$videocardinfo = Get-WmiObject Win32_VideoController
$Hddinfo = Get-WmiObject Win32_LogicalDisk | select DeviceID, VolumeName, FileSystem, @{Name="Size_GB";Expression={"{0:N1} GB" -f ($_.Size / 1Gb)}}, @{Name="FreeSpace_GB";Expression={"{0:N1} GB" -f ($_.FreeSpace / 1Gb)}}, @{Name="FreeSpace_percent";Expression={"{0:N1}%" -f ((100 / ($_.Size / $_.FreeSpace)))}} | Format-Table DeviceID, VolumeName,FileSystem,@{ Name="Size GB"; Expression={$_.Size_GB}; align="right"; }, @{ Name="FreeSpace GB"; Expression={$_.FreeSpace_GB}; align="right"; }, @{ Name="FreeSpace %"; Expression={$_.FreeSpace_percent}; align="right"; } ;$Hddinfo=($Hddinfo| Out-String) ;$Hddinfo = ("$Hddinfo").TrimEnd("")
$RamInfo = Get-WmiObject Win32_PhysicalMemory | Measure-Object -Property capacity -Sum | % { "{0:N1} GB" -f ($_.sum / 1GB)}
$processor = "$($processorInfo.Name)"
$gpu = "$($videocardinfo.Name)"
$DiskHealth = Get-PhysicalDisk | Select-Object DeviceID, FriendlyName, OperationalStatus, HealthStatus; $DiskHealth = ($DiskHealth | Out-String)
$ver = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion').DisplayVersion

# User Information
$fullName = $($userInfo.FullName) ;$fullName = ("$fullName").TrimStart("")
$email = (Get-ComputerInfo).WindowsRegisteredOwner
$systemLocale = Get-WinSystemLocale;$systemLanguage = $systemLocale.Name
$userLanguageList = Get-WinUserLanguageList;$keyboardLayoutID = $userLanguageList[0].InputMethodTips[0]
$OSString = "$($systemInfo.Caption)"
$OSArch = "$($systemInfo.OSArchitecture)"
$computerPubIP=(Invoke-WebRequest ipinfo.io/ip -UseBasicParsing).Content
$users = "$($userInfo.Name)"
$userString = "`nFull Name : $($userInfo.FullName)"
$clipboard = Get-Clipboard

# System Information
$COMDevices = Get-Wmiobject Win32_USBControllerDevice | ForEach-Object{[Wmi]($_.Dependent)} | Select-Object Name, DeviceID, Manufacturer | Sort-Object -Descending Name | Format-Table; $usbdevices = ($COMDevices| Out-String)
$process=Get-WmiObject win32_process | select Handle, ProcessName, ExecutablePath; $process = ($process| Out-String)
$service=Get-CimInstance -ClassName Win32_Service | select State,Name,StartName,PathName | Where-Object {$_.State -like 'Running'}; $service = ($service | Out-String)
$software=Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | where { $_.DisplayName -notlike $null } |  Select-Object DisplayName, DisplayVersion, InstallDate | Sort-Object DisplayName | Format-Table -AutoSize; $software = ($software| Out-String)
$drivers=Get-WmiObject Win32_PnPSignedDriver| where { $_.DeviceName -notlike $null } | select DeviceName, FriendlyName, DriverProviderName, DriverVersion
$pshist = "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt";$pshistory = Get-Content $pshist -raw ;$pshistory = ($pshistory | Out-String) 
$RecentFiles = Get-ChildItem -Path $env:USERPROFILE -Recurse -File | Sort-Object LastWriteTime -Descending | Select-Object -First 100 FullName, LastWriteTime;$RecentFiles = ($RecentFiles | Out-String)
$Screen = [System.Windows.Forms.SystemInformation]::VirtualScreen;$Width = $Screen.Width;$Height = $Screen.Height;$screensize = "${width} x ${height}"

# Nearby WiFi Networks
$showNetworks = explorer.exe ms-availablenetworks:
sleep 4

$wshell = New-Object -ComObject wscript.shell
$wshell.AppActivate('explorer.exe')
$tab = 0
while ($tab -lt 6){
$wshell.SendKeys('{TAB}')
$tab++
}
$wshell.SendKeys('{ENTER}')
$wshell.SendKeys('{TAB}')
$wshell.SendKeys('{ESC}')
$NearbyWifi = (netsh wlan show networks mode=Bssid | ?{$_ -like "SSID*" -or $_ -like "*Signal*" -or $_ -like "*Band*"}).trim() | Format-Table SSID, Signal, Band
$Wifi = ($NearbyWifi|Out-String)

# Current System Metrics
function Get-PerformanceMetrics {
    $cpuUsage = Get-Counter '\Processor(_Total)\% Processor Time' | Select-Object -ExpandProperty CounterSamples | Select-Object CookedValue
    $memoryUsage = Get-Counter '\Memory\% Committed Bytes In Use' | Select-Object -ExpandProperty CounterSamples | Select-Object CookedValue
    $diskIO = Get-Counter '\PhysicalDisk(_Total)\Disk Transfers/sec' | Select-Object -ExpandProperty CounterSamples | Select-Object CookedValue
    $networkIO = Get-Counter '\Network Interface(*)\Bytes Total/sec' | Select-Object -ExpandProperty CounterSamples | Select-Object CookedValue

    return [PSCustomObject]@{
        CPUUsage = "{0:F2}" -f $cpuUsage.CookedValue
        MemoryUsage = "{0:F2}" -f $memoryUsage.CookedValue
        DiskIO = "{0:F2}" -f $diskIO.CookedValue
        NetworkIO = "{0:F2}" -f $networkIO.CookedValue
    }
}
$metrics = Get-PerformanceMetrics
$PMcpu = "CPU Usage: $($metrics.CPUUsage)%"
$PMmu = "Memory Usage: $($metrics.MemoryUsage)%"
$PMdio = "Disk I/O: $($metrics.DiskIO) transfers/sec"
$PMnio = "Network I/O: $($metrics.NetworkIO) bytes/sec"

# History and Bookmark Data
$Expression = '(http|https)://([\w-]+\.)+[\w-]+(/[\w- ./?%&=]*)*?'
$Paths = @{
    'chrome_history'    = "$Env:USERPROFILE\AppData\Local\Google\Chrome\User Data\Default\History"
    'chrome_bookmarks'  = "$Env:USERPROFILE\AppData\Local\Google\Chrome\User Data\Default\Bookmarks"
    'edge_history'      = "$Env:USERPROFILE\AppData\Local\Microsoft/Edge/User Data/Default/History"
    'edge_bookmarks'    = "$env:USERPROFILE\AppData\Local\Microsoft\Edge\User Data\Default\Bookmarks"
    'firefox_history'   = "$Env:USERPROFILE\AppData\Roaming\Mozilla\Firefox\Profiles\*.default-release\places.sqlite"
    'opera_history'     = "$Env:USERPROFILE\AppData\Roaming\Opera Software\Opera GX Stable\History"
    'opera_bookmarks'   = "$Env:USERPROFILE\AppData\Roaming\Opera Software\Opera GX Stable\Bookmarks"
}
$Browsers = @('chrome', 'edge', 'firefox', 'opera')
$DataValues = @('history', 'bookmarks')
$outpath = "$env:temp\Browsers.txt"
foreach ($Browser in $Browsers) {
    foreach ($DataValue in $DataValues) {
        $PathKey = "${Browser}_${DataValue}"
        $Path = $Paths[$PathKey]

        $Value = Get-Content -Path $Path | Select-String -AllMatches $Expression | % {($_.Matches).Value} | Sort -Unique

        $Value | ForEach-Object {
            [PSCustomObject]@{
                Browser  = $Browser
                DataType = $DataValue
                Content = $_
            }
        } | Out-File -FilePath $outpath -Append
    }
}
$Value = Get-Content -Path $outpath
$Value = ($Value | Out-String)

# Saved WiFi Network Info
$outssid = ''
$a=0
$ws=(netsh wlan show profiles) -replace ".*:\s+"
foreach($s in $ws){
    if($a -gt 1 -And $s -NotMatch " policy " -And $s -ne "User profiles" -And $s -NotMatch "-----" -And $s -NotMatch "<None>" -And $s.length -gt 5){
        $ssid=$s.Trim()
        if($s -Match ":"){
            $ssid=$s.Split(":")[1].Trim()
            }
        $pw=(netsh wlan show profiles name=$ssid key=clear)
        $pass="None"
        foreach($p in $pw){
            if($p -Match "Key Content"){
            $pass=$p.Split(":")[1].Trim()
            $outssid+="SSID: $ssid | Password: $pass`n-----------------------`n"
            }
        }
    }
    $a++
}

# GPS Location Info
Add-Type -AssemblyName System.Device
$GeoWatcher = New-Object System.Device.Location.GeoCoordinateWatcher
$GeoWatcher.Start()
while (($GeoWatcher.Status -ne 'Ready') -and ($GeoWatcher.Permission -ne 'Denied')) {
	Sleep -M 100
}  
if ($GeoWatcher.Permission -eq 'Denied'){
    $GPS = "Location Services Off"
}
else{
	$GL = $GeoWatcher.Position.Location | Select Latitude,Longitude
	$GL = $GL -split " "
	$Lat = $GL[0].Substring(11) -replace ".$"
	$Lon = $GL[1].Substring(10) -replace ".$"
    $GPS = "LAT = $Lat LONG = $Lon"
}


$infomessage = "
==================================================================================================================================
      _________               __                           .__        _____                            __  .__               
     /   _____/__.__. _______/  |_  ____   _____           |__| _____/ ____\___________  _____ _____ _/  |_|__| ____   ____  
     \_____  <   |  |/  ___/\   __\/ __ \ /     \   ______ |  |/    \   __\/  _ \_  __ \/     \\__  \\   __\  |/  _ \ /    \ 
     /        \___  |\___ \  |  | \  ___/|  Y Y  \ /_____/ |  |   |  \  | (  <_> )  | \/  Y Y  \/ __ \|  | |  (  <_> )   |  \
    /_______  / ____/____  > |__|  \___  >__|_|  /         |__|___|  /__|  \____/|__|  |__|_|  (____  /__| |__|\____/|___|  /
            \/\/         \/            \/      \/                  \/                        \/     \/                    \/ 
==================================================================================================================================
User Information
----------------------------------------------------------------------------------------------------------------------------------
Current User          : $env:USERNAME
Email Address         : $email
Language              : $systemLanguage
Keyboard Layout       : $keyboardLayoutID
Other Accounts        : $users
Current OS            : $OSString
Build ID              : $ver
Architechture         : $OSArch
Screen Size           : $screensize
Location              : $GPS

==================================================================================================================================
Hardware Information
----------------------------------------------------------------------------------------------------------------------------------
Processor             : $processor 
Memory                : $RamInfo
Gpu                   : $gpu

Storage
----------------------------------------
$Hddinfo
$DiskHealth

Current System Metrics
----------------------------------------
$PMcpu
$PMmu
$PMdio
$PMnio

==================================================================================================================================
Network Information
----------------------------------------------------------------------------------------------------------------------------------
Public IP Address     : $computerPubIP

Saved WiFi Networks
----------------------------------------
$outssid

Nearby Wifi Networks
----------------------------------------
$Wifi
"


$infomessage2 = "
==================================================================================================================================
History Information
----------------------------------------------------------------------------------------------------------------------------------
Clipboard Contents
---------------------------------------
$clipboard

Browser History
----------------------------------------
$Value

Powershell History
---------------------------------------
$pshistory

==================================================================================================================================
Recent File Changes Information
----------------------------------------------------------------------------------------------------------------------------------
$RecentFiles

==================================================================================================================================
USB Information
----------------------------------------------------------------------------------------------------------------------------------
$usbdevices

==================================================================================================================================
Software Information
----------------------------------------------------------------------------------------------------------------------------------
$software

==================================================================================================================================
Running Services Information
----------------------------------------------------------------------------------------------------------------------------------
$service

==================================================================================================================================
Current Processes Information
----------------------------------------------------------------------------------------------------------------------------------
$process

=================================================================================================================================="

$outpath = "$env:USERPROFILE/Desktop/systeminfo.txt"

$infomessage | Out-File -FilePath $outpath -Encoding ASCII -Append
$infomessage2 | Out-File -FilePath $outpath -Encoding ASCII -Append
sleep 2

& $outpath

sleep 5
rm -Path $outpath