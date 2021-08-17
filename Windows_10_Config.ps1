##### Script von Nico Dutschka und Lukas Vieweg#####
### getestet unter Windows 10 Pro | Version 1909 | Build 18363.592 ###

###Entferne Kacheln aus Startmenue und Bereinige Taskleiste
<#
$usernameyn = Read-Host -Prompt 'Soll ein Benutzer hinzugefügt werden? ( Y / N )'
$usernameyn.ToLower()
$yes = "y"
if ($usernameyn = $yes){
    $usernamename = Read-Host -Prompt 'Wie soll der Benutzer heissen?'
    #Neuen Benutzer anlegen
    New-LocalUser -Name $usernamename -Description "Schulung DD" -NoPassword
    Add-LocalGroupMember -Group "Users" -Member $usernamename
}
else{}
$errorsilent.ToLower() = Read-Host -Prompt 'Sollen Fehler angezeigt werden? ( Y / N )'
if ($errorsilent = "y"){
    $ErrorActionPreference = "SilentlyContinue"
}
#>
write-host
"
---------------------------------------------------------------------------------
///////       ///////*   //////.      .///////////*             ///////         
///////     ///////*     //////.    /////////////////,         *////////        
///////   *///////       //////.   //////.      //////,       *//////////       
/////// .///////         //////.   //////*                   ,/////.//////      
//////////////           //////.    ///////////.            ./////,  //////     
///////////////          //////.       /////////////       ./////*   ,/////*    
////////////////         //////.             *////////     //////     //////*   
///////.  *//////*       //////.  //////.       ///////   ///////////////////,  
///////     ///////      //////.  .//////*     ,//////,  /////////////////////. 
///////      *///////    //////.    /////////////////   ///////          //////.
*******        *******   ******         .*//////*.     *******           ,******
----------------------------------------------------------------------------------
"
sleep -seconds 5

write-host

"
------------------------------------------------------------------------
`n
Startlayout.xml wird abgelegt und Rechte vom KISA Ordner werden geaendert
`n
------------------------------------------------------------------------
"

new-item -path "c:\Windows" -name "KISA" -itemType directory

#StartLayout-XML lokal ablegen
new-item -path "c:\Windows\KISA" -name "Desktop" -itemType directory 
copy-item -path (join-path $psscriptroot "StartLayout.xml") -destination C:\Windows\KISA\Desktop

#remove-item -path "c:\KISA\Install\Startlayout.xml"
#Installation eines Zusatzmodules zum leichteren Verwalten von NTFS Rechten
#Install-Module NTFSSecurity -force
#Get-NTFS-Access -Account 'Vordefiniert\Benutzer' -Path C:\KISA -ExcludeInherited | Remove-NTFSAccess
#Add-NTFSAccess -Account 'Vordefniert\Benutzer' -Path C:\KISA -AccessRight Read

#Function Set-WallPaper($Value)
#{
# Set-ItemProperty -path 'HKCU:\Control Panel\Desktop\' -name wallpaper -value $value
# rundll32.exe user32.dll, UpdatePerUserSystemParameters 1, True
#}
#Set-WallPaper -value "C:\Test.png"

sleep -seconds 5

write-host

"
---------------------------------------------------------
`n
Beginne mit Bereinigung von Desktop und setze Startlayout
`n
---------------------------------------------------------
"

sleep -seconds 5

#neuen Schl�ssel "Explorer" anlegen
new-item hklm:\software\policies\microsoft\windows\Explorer
#Start-Layout f�r alle Nutzer festlegen
new-itemproperty -type dword -path "hklm:\software\policies\microsoft\windows\explorer" -name LockedStartLayout -value 1
#Pfad f�r StartLayout festlegen
new-itemproperty -type ExpandString -path "hklm:\software\policies\microsoft\windows\explorer" -name StartLayoutFile -value "c:\Windows\KISA\Desktop\StartLayout.xml"

sleep -seconds 3

###Entferne Desktop-Links

remove-item -path "c:\users\*\desktop\Microsoft Edge.lnk"
new-itemproperty -type dword -path hklm:\software\microsoft\windows\currentversion\explorer -name DisableEdgeDesktopShortcutCreation -value 1

sleep -seconds 3

###Programme deinstallieren

#Microsoft To Do
get-appxpackage *Microsoft.Todos* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *microsoft.todos* | remove-appxprovisionedpackage -online | where DisplayName -like *microsoft.todos*
write-host "Microsoft Todos entfernt"
sleep -seconds 1
#Xing
get-appxpackage *Xing* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *xing* | remove-appxprovisionedpackage -online | where DisplayName -like *xing*
write-host "Xing entfernt"
sleep -seconds 1
#Candy Crush Friends
get-appxpackage *CandyCrushFriends* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *candycrushfriends* | remove-appxprovisionedpackage -online | where DisplayName -like *candycrushfriends*
write-host "Candy Crush entfernt"
sleep -seconds 1
#Farm Heroes Saga
get-appxpackage *FarmHeroesSaga* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *farmheroessaga* | remove-appxprovisionedpackage -online | where DisplayName -like *farmheroessaga*
write-host "Farm Heroes Saga entfernt"
sleep -seconds 1
#Solitair
get-appxpackage *MicrosoftSolitaireCollection* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *microsoftsolitairecollection* | remove-appxprovisionedpackage -online | where DisplayName -like *microsoftsolitairecollection*
write-host "Solitair entfernt"
sleep -seconds 1
#Alarm & Uhr
get-appxpackage *WindowsAlarms* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *windowsalarms* | remove-appxprovisionedpackage -online | where DisplayName -like *windowsalarms*
write-host "Alarm und Uhr entfernt"
sleep -seconds 1
#Desktop-Apps
get-appxpackage *DesktopAppInstaller* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *desktopappinstaller* | remove-appxprovisionedpackage -online | where DisplayName -like *desktopappinstaller*
write-host "Desktop App Installer entfernt"
sleep -seconds 1
#Ausschneiden
get-appxpackage *ScreenSketch* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *screensketch* | remove-appxprovisionedpackage -online | where DisplayName -like *screensketch*
write-host "Ausschneiden entfernt"
sleep -seconds 1
#Feedback-Hub
get-appxpackage *WindowsFeedbackHub* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *windowsfeedbackhub* | remove-appxprovisionedpackage -online | where DisplayName -like *windowsfeedbackhub*
write-host "Feedback-Hub entfernt"
sleep -seconds 1
#Groove-Musik
get-appxpackage *ZuneMusic* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *zunemusic* | remove-appxprovisionedpackage -online | where DisplayName -like *zunemusic*
write-host "Groove-Musik entfernt"
sleep -seconds 1
#Filme & TV
get-appxpackage *ZuneVideo* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *zunevideo* | remove-appxprovisionedpackage -online | where DisplayName -like *zunevideo*
write-host "ZuneVideo entfernt"
sleep -seconds 1
#Hilfe
get-appxpackage *GetHelp* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *gethelp* | remove-appxprovisionedpackage -online | where DisplayName -like *gethelp*
write-host "Hilfe entfernt"
sleep -seconds 1
#Ihr Smartphone
get-appxpackage *YourPhone* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *yourphone* | remove-appxprovisionedpackage -online | where DisplayName -like *yourphone*
write-host "Smartphone entfernt"
sleep -seconds 1
#Kamera
get-appxpackage *WindowsCamera* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *windowscamera* | remove-appxprovisionedpackage -online | where DisplayName -like *windowscamera*
write-host "Kamera entfernt"
sleep -seconds 1
#Karten
get-appxpackage *WindowsMaps* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *windowsmaps* | remove-appxprovisionedpackage -online | where DisplayName -like *windowsmaps*
write-host "Karten entfernt"
sleep -seconds 1
#Kontakte
get-appxpackage *Microsoft.People* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *Microsoft.people* | remove-appxprovisionedpackage -online | where DisplayName -like *Microsoft.people*
write-host "Kontakte entfernt"
sleep -seconds 1
#Mail und Kalender
get-appxpackage *windowscommunicationsapps* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *windowscommunicationsapp* | remove-appxprovisionedpackage -online | where DisplayName -like *windowscommunicationsapp*
write-host "Mail und Kalender entfernt"
sleep -seconds 1
#Office
get-appxpackage *microsoftofficehub* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *microsoftofficehub* | remove-appxprovisionedpackage -online | where DisplayName -like *microsoftofficehub*
write-host "Office entfernt"
sleep -seconds 1
#Microsoft Store
get-appxpackage *windowsstore* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *windowsstore* | remove-appxprovisionedpackage -online | where DisplayName -like *windowsstore*
write-host "Microsoft Store entfernt"
sleep -seconds 1
#Mixed Reality-Portal
get-appxpackage *mixedreality.portal* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *mixedreality.portal* | remove-appxprovisionedpackage -online | where DisplayName -like *mixedreality.portal*
write-host "Mixe Reality-Portal entfernt"
sleep -seconds 1
#Mixed Reality-Viewer
get-appxpackage *microsoft3dviewer* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *microsoft3dviewer* | remove-appxprovisionedpackage -online | where DisplayName -like *microsoft3dviewer*
write-host "Reality-Viewer entfernt"
sleep -seconds 1
#Nachrichten
get-appxpackage *messaging* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *messaging* | remove-appxprovisionedpackage -online | where DisplayName -like *messaging*
write-host "Nachrichten entfernt"
sleep -seconds 1
#OneNote
get-appxpackage *office.onenote* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *office.onenote* | remove-appxprovisionedpackage -online | where DisplayName -like *office.onenote*
write-host "OneNote entfernt"
sleep -seconds 1
#Paint
get-appxpackage *mspaint* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *mspaint* | remove-appxprovisionedpackage -online | where DisplayName -like *mspaint*
write-host "Paint entfernt"
sleep -seconds 1
#Print 3D
get-appxpackage *print3d* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *print3d* | remove-appxprovisionedpackage -online | where DisplayName -like *print3d*
write-host "Paint 3D entfernt"
sleep -seconds 1
#Skype
get-appxpackage *skypeapp* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *skypeapp* | remove-appxprovisionedpackage -online | where DisplayName -like *skypeapp*
write-host "Skype entfernt"
sleep -seconds 1
#Sprachrekorder
get-appxpackage *windowssoundrecorder* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *windowssoundrecorder* | remove-appxprovisionedpackage -online | where DisplayName -like *windowssoundrecorder*
write-host "Sprachrekorder entfernt"
sleep -seconds 1
#Tipps
get-appxpackage *getstarted* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *getstarted* | remove-appxprovisionedpackage -online | where DisplayName -like *getstarted*
write-host "Tipps entfernt"
sleep -seconds 1
#Wetter
get-appxpackage *bingweather* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *bingweather* | remove-appxprovisionedpackage -online | where DisplayName -like *bingweather*
write-host "Wetter entfernt"
sleep -seconds 1
#Xbox
get-appxpackage *xboxapp* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *xboxapp* | remove-appxprovisionedpackage -online | where DisplayName -like *xboxapp*
write-host "Xbox entfernt"
sleep -seconds 1
#Xbox Game Speech Window
get-appxpackage *xboxspeechtotextoverlay* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *xboxspeechtotextoverlay* | remove-appxprovisionedpackage -online | where DisplayName -like *xboxspeechtotextoverlay*
write-host "Xbox Game Speech Window entfernt"
sleep -seconds 1
#Xbox Live
get-appxpackage *xbox.tcui* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *xbox.tcui* | remove-appxprovisionedpackage -online | where DisplayName -like *xbox.tcui*
write-host "Xbox Live entfernt"
sleep -seconds 1
#Spieleleiste
get-appxpackage *xboxgamingoverlay* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *xboxgamingoverlay* | remove-appxprovisionedpackage -online | where DisplayName -like *xboxgamingoverlay*
write-host "Spieleleiste entfernt"
sleep -seconds 1
#Mobilfunktarife
get-appxpackage *oneconnect* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *oneconnect* | remove-appxprovisionedpackage -online | where DisplayName -like *oneconnect*
write-host "Mobilfunktarife entfernt"
sleep -seconds 1
#Xbox Identity Provider
get-appxpackage *xboxidentityprovider* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *xboxidentityprovider* | remove-appxprovisionedpackage -online | where DisplayName -like *xboxidentityprovider*
write-host "Xbox Identity Provider entfernt"
sleep -seconds 1
#Xbox Game Overlay
get-appxpackage *xboxgameoverlay* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *xboxgameoverlay* | remove-appxprovisionedpackage -online | where DisplayName -like *xboxgameoverlay*
write-host "Game Overlay entfernt"
sleep -seconds 1
#Wallet
get-appxpackage *wallet* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *wallet* | remove-appxprovisionedpackage -online | where DisplayName -like *wallet*
write-host "Wallet entfernt"
sleep -seconds 1
#Store Purchase App
get-appxpackage *storepurchaseapp* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *storepurchaseapp* | remove-appxprovisionedpackage -online | where DisplayName -like *storepurchaseapp*
write-host "Store Purchase App entfernt"
sleep -seconds 1
#Spotify
get-appxpackage *SpotifyAB.SpotifyMusic* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *SpotifyAB.SpotifyMusic* | remove-appxprovisionedpackage -online | where DisplayName -like *SpotifyAB.SpotifyMusic*
write-host "Spotify entfernt"
sleep -seconds 1

write-host "------------------------------------------------------------"

#Microsoft To Do
get-appxpackage *Microsoft.Todos* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *microsoft.todos* | remove-appxprovisionedpackage -online | where DisplayName -like *microsoft.todos*
write-host "Microsoft Todos entfernt"
sleep -seconds 1
#Xing
get-appxpackage *Xing* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *xing* | remove-appxprovisionedpackage -online | where DisplayName -like *xing*
write-host "Xing entfernt"
sleep -seconds 1
#Candy Crush Friends
get-appxpackage *CandyCrushFriends* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *candycrushfriends* | remove-appxprovisionedpackage -online | where DisplayName -like *candycrushfriends*
write-host "Candy Crush entfernt"
sleep -seconds 1
#Farm Heroes Saga
get-appxpackage *FarmHeroesSaga* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *farmheroessaga* | remove-appxprovisionedpackage -online | where DisplayName -like *farmheroessaga*
write-host "Farm Heroes Saga entfernt"
sleep -seconds 1
#Solitair
get-appxpackage *MicrosoftSolitaireCollection* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *microsoftsolitairecollection* | remove-appxprovisionedpackage -online | where DisplayName -like *microsoftsolitairecollection*
write-host "Solitair entfernt"
sleep -seconds 1
#Alarm & Uhr
get-appxpackage *WindowsAlarms* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *windowsalarms* | remove-appxprovisionedpackage -online | where DisplayName -like *windowsalarms*
write-host "Alarm und Uhr entfernt"
sleep -seconds 1
#Desktop-Apps
get-appxpackage *DesktopAppInstaller* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *desktopappinstaller* | remove-appxprovisionedpackage -online | where DisplayName -like *desktopappinstaller*
write-host "Desktop App Installer entfernt"
sleep -seconds 1
#Ausschneiden
get-appxpackage *ScreenSketch* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *screensketch* | remove-appxprovisionedpackage -online | where DisplayName -like *screensketch*
write-host "Ausschneiden entfernt"
sleep -seconds 1
#Feedback-Hub
get-appxpackage *WindowsFeedbackHub* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *windowsfeedbackhub* | remove-appxprovisionedpackage -online | where DisplayName -like *windowsfeedbackhub*
write-host "Feedback-Hub entfernt"
sleep -seconds 1
#Groove-Musik
get-appxpackage *ZuneMusic* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *zunemusic* | remove-appxprovisionedpackage -online | where DisplayName -like *zunemusic*
write-host "Groove-Musik entfernt"
sleep -seconds 1
#Filme & TV
get-appxpackage *ZuneVideo* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *zunevideo* | remove-appxprovisionedpackage -online | where DisplayName -like *zunevideo*
write-host "ZuneVideo entfernt"
sleep -seconds 1
#Hilfe
get-appxpackage *GetHelp* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *gethelp* | remove-appxprovisionedpackage -online | where DisplayName -like *gethelp*
write-host "Hilfe entfernt"
sleep -seconds 1
#Ihr Smartphone
get-appxpackage *YourPhone* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *yourphone* | remove-appxprovisionedpackage -online | where DisplayName -like *yourphone*
write-host "Smartphone entfernt"
sleep -seconds 1
#Kamera
get-appxpackage *WindowsCamera* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *windowscamera* | remove-appxprovisionedpackage -online | where DisplayName -like *windowscamera*
write-host "Kamera entfernt"
sleep -seconds 1
#Karten
get-appxpackage *WindowsMaps* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *windowsmaps* | remove-appxprovisionedpackage -online | where DisplayName -like *windowsmaps*
write-host "Karten entfernt"
sleep -seconds 1
#Kontakte
get-appxpackage *Microsoft.People* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *Microsoft.people* | remove-appxprovisionedpackage -online | where DisplayName -like *Microsoft.people*
write-host "Kontakte entfernt"
sleep -seconds 1
#Mail und Kalender
get-appxpackage *windowscommunicationsapps* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *windowscommunicationsapp* | remove-appxprovisionedpackage -online | where DisplayName -like *windowscommunicationsapp*
write-host "Mail und Kalender entfernt"
sleep -seconds 1
#Office
get-appxpackage *microsoftofficehub* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *microsoftofficehub* | remove-appxprovisionedpackage -online | where DisplayName -like *microsoftofficehub*
write-host "Office entfernt"
sleep -seconds 1
#Microsoft Store
get-appxpackage *windowsstore* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *windowsstore* | remove-appxprovisionedpackage -online | where DisplayName -like *windowsstore*
write-host "Microsoft Store entfernt"
sleep -seconds 1
#Mixed Reality-Portal
get-appxpackage *mixedreality.portal* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *mixedreality.portal* | remove-appxprovisionedpackage -online | where DisplayName -like *mixedreality.portal*
write-host "Mixe Reality-Portal entfernt"
sleep -seconds 1
#Mixed Reality-Viewer
get-appxpackage *microsoft3dviewer* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *microsoft3dviewer* | remove-appxprovisionedpackage -online | where DisplayName -like *microsoft3dviewer*
write-host "Reality-Viewer entfernt"
sleep -seconds 1
#Nachrichten
get-appxpackage *messaging* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *messaging* | remove-appxprovisionedpackage -online | where DisplayName -like *messaging*
write-host "Nachrichten entfernt"
sleep -seconds 1
#OneNote
get-appxpackage *office.onenote* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *office.onenote* | remove-appxprovisionedpackage -online | where DisplayName -like *office.onenote*
write-host "OneNote entfernt"
sleep -seconds 1
#Paint
get-appxpackage *mspaint* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *mspaint* | remove-appxprovisionedpackage -online | where DisplayName -like *mspaint*
write-host "Paint entfernt"
sleep -seconds 1
#Print 3D
get-appxpackage *print3d* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *print3d* | remove-appxprovisionedpackage -online | where DisplayName -like *print3d*
write-host "Paint 3D entfernt"
sleep -seconds 1
#Skype
get-appxpackage *skypeapp* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *skypeapp* | remove-appxprovisionedpackage -online | where DisplayName -like *skypeapp*
write-host "Skype entfernt"
sleep -seconds 1
#Sprachrekorder
get-appxpackage *windowssoundrecorder* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *windowssoundrecorder* | remove-appxprovisionedpackage -online | where DisplayName -like *windowssoundrecorder*
write-host "Sprachrekorder entfernt"
sleep -seconds 1
#Tipps
get-appxpackage *getstarted* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *getstarted* | remove-appxprovisionedpackage -online | where DisplayName -like *getstarted*
write-host "Tipps entfernt"
sleep -seconds 1
#Wetter
get-appxpackage *bingweather* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *bingweather* | remove-appxprovisionedpackage -online | where DisplayName -like *bingweather*
write-host "Wetter entfernt"
sleep -seconds 1
#Xbox
get-appxpackage *xboxapp* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *xboxapp* | remove-appxprovisionedpackage -online | where DisplayName -like *xboxapp*
write-host "Xbox entfernt"
sleep -seconds 1
#Xbox Game Speech Window
get-appxpackage *xboxspeechtotextoverlay* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *xboxspeechtotextoverlay* | remove-appxprovisionedpackage -online | where DisplayName -like *xboxspeechtotextoverlay*
write-host "Xbox Game Speech Window entfernt"
sleep -seconds 1
#Xbox Live
get-appxpackage *xbox.tcui* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *xbox.tcui* | remove-appxprovisionedpackage -online | where DisplayName -like *xbox.tcui*
write-host "Xbox Live entfernt"
sleep -seconds 1
#Spieleleiste
get-appxpackage *xboxgamingoverlay* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *xboxgamingoverlay* | remove-appxprovisionedpackage -online | where DisplayName -like *xboxgamingoverlay*
write-host "Spieleleiste entfernt"
sleep -seconds 1
#Mobilfunktarife
get-appxpackage *oneconnect* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *oneconnect* | remove-appxprovisionedpackage -online | where DisplayName -like *oneconnect*
write-host "Mobilfunktarife entfernt"
sleep -seconds 1
#Xbox Identity Provider
get-appxpackage *xboxidentityprovider* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *xboxidentityprovider* | remove-appxprovisionedpackage -online | where DisplayName -like *xboxidentityprovider*
write-host "Xbox Identity Provider entfernt"
sleep -seconds 1
#Xbox Game Overlay
get-appxpackage *xboxgameoverlay* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *xboxgameoverlay* | remove-appxprovisionedpackage -online | where DisplayName -like *xboxgameoverlay*
write-host "Game Overlay entfernt"
sleep -seconds 1
#Wallet
get-appxpackage *wallet* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *wallet* | remove-appxprovisionedpackage -online | where DisplayName -like *wallet*
write-host "Wallet entfernt"
sleep -seconds 1
#Store Purchase App
get-appxpackage *storepurchaseapp* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *storepurchaseapp* | remove-appxprovisionedpackage -online | where DisplayName -like *storepurchaseapp*
write-host "Store Purchase App entfernt"
sleep -seconds 1
#Spotify
get-appxpackage *SpotifyAB.SpotifyMusic* | remove-appxpackage -allusers
get-appxprovisionedpackage -online | where DisplayName -like *SpotifyAB.SpotifyMusic* | remove-appxprovisionedpackage -online | where DisplayName -like *SpotifyAB.SpotifyMusic*
write-host "Spotify entfernt"
sleep -seconds 1

###Erweitere Symbolleiste

#Explorer-Dienst beenden
taskkill.exe /f /Im "explorer.exe" 

sleep -seconds 5

#Symbolleiste erweitern
new-itemproperty -type dword -path hklm:\software\microsoft\windows\currentversion\explorer -name EnableAutoTray -value 0 

sleep -seconds 3

#Explorer-Dienst starten
Start-Process "explorer.exe"

sleep -seconds 5

###Entferne OneDrive

sleep -seconds 30

#OneDrive-Dienst beenden
taskkill.exe /f /im "onedrive.exe"

sleep -seconds 5

#neuen Schl�ssel "OneDrive" anlegen
new-item hklm:\software\policies\microsoft\windows\OneDrive
#OneDrive-Synchronisierung deaktivieren
new-itemproperty -type dword -path hklm:\software\policies\microsoft\windows\OneDrive -name DisableFileSyncNGSC -value 1
#OneDrive-Synchronisierung unter Windows 8.1 deaktivieren
new-itemproperty -type dword -path hklm:\software\policies\microsoft\windows\OneDrive -name DisableFileSync -value 1

#OneDrive "deinstallieren"
c:\windows\syswow64\onedrivesetup.exe /uninstall

sleep -seconds 30

#Registry-Verzeichnis "HKCR" als Netzlaufwerk mappen
new-psdrive -psprovider "registry" -root "HKEY_CLASSES_ROOT" -name "HKCR"
##32 Bit
#neuen Schl�ssel "{018D5C66-4533-4307-9B53-224DE2ED1FE6}" anlegen
new-item "hkcr:\clsid\{018D5C66-4533-4307-9B53-224DE2ED1FE6}"
#OneDrive aus Windows-Explorer entfernen
new-itemproperty -type dword -path "hkcr:\clsid\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -name System.IsPinnedToNameSpaceTree -value 0
##64 Bit
#neuen Schl�ssel "{018D5C66-4533-4307-9B53-224DE2ED1FE6}" anlegen
new-item "hkcr:\wow6432node\clsid\{018D5C66-4533-4307-9B53-224DE2ED1FE6}"
#OneDrive aus Windows-Explorer entfernen
new-itemproperty -type dword -path "hkcr:\wow6432node\clsid\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -name System.IsPinnedToNameSpaceTree -value 0
#gemapptes Netzlaufwerk entmappen
Remove-psdrive "HKCR"

#Symbol aus Startmen� entfernen
remove-item -path "c:\users\*\appdata\roaming\microsoft\windows\start menu\programs\OneDrive.lnk"

sleep -seconds 3

#Besitzrechte der OneDriveSetup.exe �bernehmen
takeown /f c:\windows\syswow64\onedrivesetup.exe
#der Gruppe "Administratoren" Vollzugriff auf die Exe geben
icacls c:\windows\syswow64\onedrivesetup.exe /grant Administratoren:f
#OneDriveSetup.exe l�schen
remove-item c:\windows\syswow64\onedrivesetup.exe

sleep -seconds 3

###Entferne Login-Animation bei Erstanmeldung eines neuen Benutzers

#Erstanmeldungs-Bildschirm entfernen
set-itemproperty -type dword -path "hklm:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -name EnableFirstLogonAnimation -value 0

<#

###Deaktiviere das �ffnen der Microsoft Edge Einrichtungswebsite beim ersten �ffnen des Browsers

#neuen Schl�ssel "MicrosoftEdge" anlegen
new-item hklm:\software\policies\microsoft\MicrosoftEdge
#neuen Schl�ssel "Main" anlegen
new-item hklm:\software\policies\microsoft\MicrosoftEdge\Main
#Einrichtungswebsite entfernen
new-itemproperty -type dword -path "hklm:\software\policies\microsoft\MicrosoftEdge\Main" -name PreventFirstRunPage -value 1

#>

sleep -seconds 3

###Deaktiviere Cortana

new-item "hklm:\software\policies\microsoft\windows\Windows Search"
#"Cortana zulassen" deaktivieren
new-itemproperty -type dword -path "hklm:\software\policies\microsoft\windows\Windows Search" -name AllowCortana -value 0
#Cortana auf Sperrbildschirm deaktivieren
new-itemproperty -type dword -path "hklm:\software\policies\microsoft\windows\Windows Search" -name AllowCortanaAboveLock -value 0
#Cortana-Websuche deaktivieren
new-itemproperty -type dword -path "hklm:\software\policies\microsoft\windows\Windows Search" -name DisableWebSearch -value 1
#Cortana die Nutzung von Positionsdaten verbieten
new-itemproperty -type dword -path "hklm:\software\policies\microsoft\windows\Windows Search" -name AllowSearchToUseLocation -value 0
#Anzeige von Suchergebnissen aus dem Web verbieten
new-itemproperty -type dword -path "hklm:\software\policies\microsoft\windows\Windows Search" -name ConnectedSearchUseWeb -value 0
#Suche in der Cloud deaktivieren 
new-itemproperty -type dword -path "hklm:\software\policies\microsoft\windows\Windows Search" -name AllowCloudSearch -value 0 
#Herunterladen und Aktualisieren der Spracherkennung deaktivieren
new-itemproperty -type dword -path "hklm:\software\microsoft\speech_onecore\preferences" -name ModelDownloadAllowed -value 0 

sleep -seconds 5

###Deaktiviere �berwachung des Nutzerverhaltens

#Nutzung von Diagnosedaten verbieten
set-itemproperty -type dword -path "hklm:\software\microsoft\windows\currentversion\privacy" -name TailoredExperiencesWithDiagnosticDataEnabled -value 0 
#Telemetrie deaktivieren 1/3
set-itemproperty -type dword -path "hklm:\software\policies\microsoft\windows\datacollection" -name AllowTelemetry -value 0 
#Telemetrie deaktivieren 2/3
set-itemproperty -type dword -path "hklm:\software\microsoft\windows\currentversion\policies\datacollection" -name AllowTelemetry -value 0 
#neuen Schl�ssel "appcompat" anlegen
new-item hklm:\software\policies\microsoft\windows\appcompat
#Telemetrie deaktivieren 3/3
new-itemproperty -type dword -path "hklm:\software\policies\microsoft\windows\appcompat" -name AITEnable -value 0
#####set-itemproperty -type dword -path "hklm:\software\policies\microsoft\windows\appcompat" -name AITEnable -value 0 

sleep -seconds 5

###Deaktiviere Ortungsdienste

#neuen Schl�ssel "locationandsensors" anlegen
new-item hklm:\software\policies\microsoft\windows\locationandsensors
#Ortung deaktivieren 1/2
new-itemproperty -type dword -path "hklm:\software\policies\microsoft\windows\locationandsensors" -name DisableLocation -value 1
#Ortung deaktivieren 2/2
new-itemproperty -type dword -path "hklm:\software\policies\microsoft\windows\locationandsensors" -name DisableWindowsLocationProvider -value 1
#Scriptfunktionen zur Ortung deaktivieren
new-itemproperty -type dword -path "hklm:\software\policies\microsoft\windows\locationandsensors" -name DisableLocationScripting -value 1
#Sensoren f�r Ort und Lage deaktivieren
new-itemproperty -type dword -path "hklm:\software\policies\microsoft\windows\locationandsensors" -name DisableSensors -value 1
#####set-itemproperty -type dword -path "hklm:\software\policies\microsoft\windows\locationandsensors" -name DisableLocation -value 1
#####set-itemproperty -type dword -path "hklm:\software\policies\microsoft\windows\locationandsensors" -name DisableWindowsLocationProvider -value 1
#####set-itemproperty -type dword -path "hklm:\software\policies\microsoft\windows\locationandsensors" -name DisableLocationScripting -value 1
#####set-itemproperty -type dword -path "hklm:\software\policies\microsoft\windows\locationandsensors" -name DisableSensors -value 1
#Windows-Dienst zur Ortung deaktivieren 1/2
set-itemproperty -type dword -path "HKLM:\System\CurrentControlSet\Services\lfsvc\Service\Configuration" -name Status -value 0
#Windows-Dienst zur Ortung deaktivieren 2/2
set-itemproperty -type dword -path "hklm:\software\microsoft\windows nt\currentversion\sensor\overrides\{bfa794e4-f964-4fdb-90f6-51056bfe4b44}" -name SensorPermissionState -value 0

sleep -seconds 5

###Verbessere Privatsph�re

#Werbe-ID deaktivieren und zur�cksetzen
set-itemproperty -type dword -path "hklm:\software\microsoft\windows\currentversion\advertisinginfo" -name Enabled -value 0 
#Teilnahme am Windows-Programm zur Verbesserung der Benutzerfreundlichkeit deaktivieren
set-itemproperty -type dword -path "hklm:\software\microsoft\sqmclient\windows" -name CEIPEnable -value 0 
#Inventory-Collector deaktivieren
new-itemproperty -type dword -path "hklm:\software\policies\microsoft\windows\appcompat" -name DisableInventory -value 1
#####set-itemproperty -type dword -path "hklm:\software\policies\microsoft\windows\appcompat" -name DisableInventory -value 1
#neuen Schl�ssel "messaging" anlegen
new-item hklm:\software\policies\microsoft\windows\messaging
#Sichern von SMS-Nachrichten in der Cloud deaktivieren
new-itemproperty -type dword -path "hklm:\software\policies\microsoft\windows\messaging" -name AllowMessageSync -value 0 
#####set-itemproperty -type dword -path "hklm:\software\policies\microsoft\windows\messaging" -name AllowMessageSync -value 0 
#neuer Schl�ssel "tabletpc" anlegen
new-item hklm:\software\policies\microsoft\windows\tabletpc
#Handschriftdatenweitergabe verhindern
new-itemproperty -type dword -path "hklm:\software\policies\microsoft\windows\tabletpc" -name PreventHandwritingDataSharing -value 1
#####set-itemproperty -type dword -path "hklm:\software\policies\microsoft\windows\tabletpc" -name PreventHandwritingDataSharing -value 1
#neuen Schl�ssel "handwritingerrorreports" anlegen
new-item hklm:\software\policies\microsoft\windows\handwritingerrorreports
#Fehlerberichte bei Handschrifteingabe verhindern
new-itemproperty -type dword -path "hklm:\software\policies\microsoft\windows\handwritingerrorreports" -name PreventHandwritingErrorReports -value 1
#####set-itemproperty -type dword -path "hklm:\software\policies\microsoft\windows\handwritingerrorreports" -name PreventHandwritingErrorReports -value 1
#neuen Schl�ssel "personalization" anlegen 
new-item hklm:\software\policies\microsoft\windows\personalization
#Kamera im Sperrbildschirm deaktivieren
new-itemproperty -type dword -path "hklm:\software\policies\microsoft\windows\personalization" -name NoLockScreenCamera -value 1
#####set-itemproperty -type dword -path "hklm:\software\policies\microsoft\windows\personalization" -name NoLockScreenCamera -value 1
#neuen Schl�ssel "system" anlegen
new-item hklm:\software\microsoft\policymanager\current\device\system
#Experimente mit diesem System durch Microsoft verbieten
new-itemproperty -type dword -path "hklm:\software\microsoft\policymanager\current\device\system" -name AllowExperimentation -value 0 
#####set-itemproperty -type dword -path "hklm:\software\microsoft\policymanager\current\device\system" -name AllowExperimentation -value 0 
#neuen Schl�ssel "bluetooth" anlegen
new-item hklm:\software\microsoft\policymanager\current\device\bluetooth
#Werbung �ber Bluetooth verhindern
new-itemproperty -type dword -path "hklm:\software\microsoft\policymanager\current\device\bluetooth" -name AllowAdvertising -value 0 
#####set-itemproperty -type dword -path "hklm:\software\microsoft\policymanager\current\device\bluetooth" -name AllowAdvertising -value 0 

sleep -seconds 5

###Verbessere Sicherheit

#Schrittaufzeichnung deaktivieren
set-itemproperty -type dword -path "hklm:\software\policies\microsoft\windows\appcompat" -name DisableUAR -value 1
#####set-itemproperty -type dword -path "hklm:\software\policies\microsoft\windows\appcompat" -name DisableUAR -value 1
#Telemetrie deaktivieren 1/3
set-itemproperty -type dword -path "hklm:\system\currentcontrolset\services\diagtrack" -name Start -value 4
#Telemetrie deaktivieren 2/3
set-itemproperty -type dword -path "hklm:\system\currentcontrolset\services\dmwappushservice" -name Start -value 4
#Telemetrie deaktivieren 3/3
set-itemproperty -type dword -path "hklm:\system\currentcontrolset\control\wmi\autologger\autologger-diagtrack-listener" -name Start -value 0

sleep -seconds 5

###Weitere Einstellungen

#neuen Schl�ssel "CloudContent" anlegen
new-item hklm:\software\policies\microsoft\windows\CloudContent
#Windows-Tipps deaktivieren
new-itemproperty -type dword -path "hklm:\software\policies\microsoft\windows\CloudContent" -name DisableSoftLanding -value 1
#Microsoft-Anwenderfeatures daktivieren
new-itemproperty -type dword -path "hklm:\software\policies\microsoft\windows\CloudContent" -name DisableWindowsConsumerFeatures -value 1
#�bermittlung des Ger�tenamens an Microsoft verhindern
set-itemproperty -type dword -path "hklm:\software\policies\microsoft\windows\datacollection" -name AllowDeviceNameInTelemetry -value 0 
#neuen Schl�ssel "Messenger" anlegen
new-item hklm:\software\policies\microsoft\Messenger
#neuen Schl�ssel "Client" anlegen
new-item hklm:\software\policies\microsoft\Messenger\Client
#Programm zur Benutzerfreundlichkeit deaktivieren
set-itemproperty -type dword -path "hklm:\software\policies\microsoft\messenger\client" -name CEIP -value 2
#Upload von Benutzeraktivit�ten verbieten
set-itemproperty -type dword -path "hklm:\software\policies\microsoft\windows\system" -name UploadUserActivities -value 0
#neuen Schl�ssel "AdvertisingInfo" anlegen
new-item hklm:\software\policies\microsoft\windows\AdvertisingInfo
#Werbe-ID deaktivieren
new-itemproperty -type dword -path "hklm:\software\policies\microsoft\windows\AdvertisingInfo" -name DisabledByGroupPolicy -value 1
#Fehler an Windows melden verhindern
new-itemproperty -type dword -path "hklm:\software\microsoft\windows\Windows Error Reporting" -name Disabled -value 1
#FastBoot deaktivieren
set-itemproperty  -type dword -path "hklm:\system\currentcontrolset\control\session manager\power" -name HiberbootEnabled -value 0
#Pr�fen ob Ortungssensoren ausgeschaltet sind; wenn nicht, dann werden Sensoren deaktiviert
$Wert = get-itempropertyvalue -path "hklm:\software\microsoft\windows\currentversion\capabilityaccessmanager\consentstore\location" -name Value
if (-not ($Wert -like "Deny")) {set-itemproperty -path "hklm:\software\microsoft\windows\currentversion\capabilityaccessmanager\consentstore\location" -name Value -value "Deny"}
#Sperrbildschirm deaktivieren
new-itemproperty -type dword -path "hklm:\software\policies\microsoft\windows\personalization" -name NoLockScreen -value 1
#neuen Schl�ssel "PushToInstall" anlegen
new-item "hklm:\software\policies\microsoft\PushToInstall"
#Pushinstallation deaktivieren
new-itemproperty -type dword -path "hklm:\software\policies\microsoft\PushToInstall" -name DisablePushToInstall -value 1
#Zuletzt hinzugef�gte Apps ausblenden
new-itemproperty -type dword -path "hklm:\software\policies\microsoft\Windows\explorer" -name HideRecentlyAddedApps -value 1

sleep -seconds 5

#Explorer-Dienst beenden
taskkill.exe /f /Im "explorer.exe"

sleep -seconds 5

#Explorer-Dienst starten
Start-Process "explorer.exe"

sleep -seconds 10

###Einstellungen f�r Current_User und Default_User

#Struktur f�r Default_User unter HKLM laden
reg load "hklm\Default_User" "C:\users\default\ntuser.dat"

sleep -seconds 3

#Installation von Werbe-Apps verhindern | Current_User
set-itemproperty -type dword -path "hkcu:\software\microsoft\windows\currentversion\contentdeliverymanager" -name PreInstalledAppsEnabled -value 0
set-itemproperty -type dword -path "hkcu:\software\microsoft\windows\currentversion\contentdeliverymanager" -name OemPreInstalledAppsEnabled -value 0
set-itemproperty -type dword -path "hkcu:\software\microsoft\windows\currentversion\contentdeliverymanager" -name SilentInstalledAppsEnabled -value 0
#Installation von Werbe-Apps verhindern | Default_User
set-itemproperty -type dword -path "hklm:\Default_User\software\microsoft\windows\currentversion\contentdeliverymanager" -name PreInstalledAppsEnabled -value 0
set-itemproperty -type dword -path "hklm:\Default_User\software\microsoft\windows\currentversion\contentdeliverymanager" -name OemPreInstalledAppsEnabled -value 0
set-itemproperty -type dword -path "hklm:\Default_User\software\microsoft\windows\currentversion\contentdeliverymanager" -name SilentInstalledAppsEnabled -value 0
#App-Vorschl�ge im Startmen� deaktivieren | Current_User
set-itemproperty -type dword -path "hkcu:\software\microsoft\windows\currentversion\contentdeliverymanager" -name SystemPaneSuggestionsEnabled -value 0
set-itemproperty -type dword -path "hkcu:\software\microsoft\windows\currentversion\contentdeliverymanager" -name SubscribedContent-338388Enabled -value 0
#App-Vorschl�ge im Startmen� deaktivieren | Default_User
set-itemproperty -type dword -path "hklm:\Default_User\software\microsoft\windows\currentversion\contentdeliverymanager" -name SystemPaneSuggestionsEnabled -value 0
set-itemproperty -type dword -path "hklm:\Default_User\software\microsoft\windows\currentversion\contentdeliverymanager" -name SubscribedContent-338388Enabled -value 0
#neuen Schl�ssel "People" anlegen | Current_User
new-item hkcu:\software\microsoft\windows\currentversion\explorer\advanced\People
#Kontakte aus Taskleiste entfernen | Current_User
new-itemproperty -type dword -path "hkcu:\software\microsoft\windows\currentversion\explorer\advanced\people" -name PeopleBand -value 0
#neuen Schl�ssel "People" anlegen | Default_User
new-item hklm:\Default_User\software\microsoft\windows\currentversion\explorer\advanced\People
#Kontakte aus Taskleiste entfernen | Default_User
new-itemproperty -type dword -path "hklm:\Default_User\software\microsoft\windows\currentversion\explorer\advanced\people" -name PeopleBand -value 0
#Taskansicht-Schaltfl�che entfernen | Current_User
set-itemproperty -type dword -path "hkcu:\software\microsoft\windows\currentversion\explorer\advanced" -name ShowTaskViewButton -value 0
#Taskansicht-Schaltfl�che entfernen | Default_User
set-itemproperty -type dword -path "hklm:\Default_User\software\microsoft\windows\currentversion\explorer\advanced" -name ShowTaskViewButton -value 0
#Suchfeld in Taskleiste deaktivieren | Current_User
set-itemproperty -type dword -path "hkcu:\software\microsoft\windows\currentversion\search" -name SearchboxTaskbarMode -value 0
#Suchfeld in Taskleiste deaktivieren | Default_User
set-itemproperty -type dword -path "hklm:\Default_User\software\microsoft\windows\currentversion\search" -name SearchboxTaskbarMode -value 0
#CMD statt Powershell unter Win+X | Current_User
new-itemproperty -type dword -path "hkcu:\software\microsoft\windows\currentversion\explorer\advanced" -name DontUsePowerShellOnWinX -value 1
#CMD statt Powershell unter Win+X | Default_User
new-itemproperty -type dword -path "hklm:\Default_User\software\microsoft\windows\currentversion\explorer\advanced" -name DontUsePowerShellOnWinX -value 1

sleep -seconds 3

#Explorer-Dienst beenden
taskkill.exe /f /Im "explorer.exe"

sleep -seconds 5

#Befehl f�r "Garbage Collection" (dieser Befehl versucht gesamten Speicher freizugeben, auf den nicht zugegriffen werden kann)
[gc]::collect()

sleep -seconds 5

#Struktur Default_User entladen
reg unload "hklm\Default_User"

#Explorer-Dienst starten
Start-Process "explorer.exe"

sleep -seconds 5

Start-Process "explorer.exe"

write-host
"
--------------------------------------------------
`n
Bereinigung und Anpassung des Startlayouts beendet
`n
--------------------------------------------------
"

Set-ExecutionPolicy restricted
<#

###Einstellungen f�r User (Nutzer, welche schon einmal angemeldet waren)

#Liste von Namen der Nutzer, welche schon einmal angemeldet waren in $User hinterlegen
$user = get-childitem -path "c:\users" -name -exclude public, $env:username
#f�r jeden der Nutzer ($u steht f�r einzelnen Nutzer in der Liste) seine pers�nliche Struktur unter HKLM laden
foreach ($u in $user) {reg load ("hklm\User_" + $u) ("c:\users\" + $u + "\ntuser.dat")}

##Installation von Werbe-Apps verhindern | User
foreach ($u in $user) {set-itemproperty -type dword -path ("hklm:\User_" + $u + "\software\microsoft\windows\currentversion\contentdeliverymanager") -name PreInstalledAppsEnabled -value 0}
foreach ($u in $user) {set-itemproperty -type dword -path ("hklm:\User_" + $u + "\software\microsoft\windows\currentversion\contentdeliverymanager") -name OemPreInstalledAppsEnabled -value 0}
foreach ($u in $user) {set-itemproperty -type dword -path ("hklm:\User_" + $u + "\software\microsoft\windows\currentversion\contentdeliverymanager") -name SilentInstalledAppsEnabled -value 0}
#App-Vorschl�ge im Startmen� deaktivieren | User
foreach ($u in $user) {set-itemproperty -type dword -path ("hklm:\User_" + $u + "\software\microsoft\windows\currentversion\contentdeliverymanager") -name SystemPaneSuggestionsEnabled -value 0}
foreach ($u in $user) {set-itemproperty -type dword -path ("hklm:\User_" + $u + "\software\microsoft\windows\currentversion\contentdeliverymanager") -name SubscribedContent-338388Enabled -value 0}
#neuen Schl�ssel "People" anlegen | User
foreach ($u in $user) {new-item ("hklm:\User_" + $u + "\software\microsoft\windows\currentversion\explorer\advanced\People")}
#Kontakte aus Taskleiste entfernen | User
foreach ($u in $user) {set-itemproperty -type dword -path ("hklm:\User_" + $u + "\software\microsoft\windows\currentversion\explorer\advanced\people") -name PeopleBand -value 0}
#Taskansicht-Schaltfl�che entfernen | User
foreach ($u in $user) {set-itemproperty -type dword -path ("hklm:\User_" + $u + "\software\microsoft\windows\currentversion\explorer\advanced") -name ShowTaskViewButton -value 0}
#Suchfeld in Taskleiste deaktivieren | User
foreach ($u in $user) {set-itemproperty -type dword -path ("hklm:\User_" + $u + "\software\microsoft\windows\currentversion\search") -name SearchboxTaskbarMode -value 0}
#CMD statt Powershell unter Win+X | User
foreach ($u in $user) {set-itemproperty -type dword -path ("hklm:\User_" + $u + "\software\microsoft\windows\currentversion\explorer\advanced") -name DontUsePowerShellOnWinX -value 1}

sleep -seconds 3

#Explorer-Dienst beenden
taskkill.exe /f /Im "explorer.exe"

sleep -seconds 5

#Befehl f�r "Garbage Collection" (dieser Befehl versucht gesamten Speicher freizugeben, auf den nicht zugegriffen werden kann)
[gc]::collect()

sleep -seconds 5

#f�r jeden der Nutzer seine pers�nliche Struktur unter HKLM entladen
foreach ($u in $user) {reg unload ("hklm\User_" + $u)}

#Explorer-Dienst starten
#>