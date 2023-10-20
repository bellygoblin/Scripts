Laptop Profile Setup (10/24/2022)

Install these apps for All users
[] \\svr\CDs\Celeris\Agentsetup_Care+Around+the+Block.exe
[] \\svr\CDs\Celeris\Sonic_VPN_client\NetExtender-10.2.302.MSI
[] \\svr\CDs\ConnectWiseControl.ClientSetup.exe
[] \\svr\CDs\wtcma_silentinstall.exe
[] \\svr\CDs\ClassicShellSetup_4_3_1.exe
[x] \\svr\CDs\EXE\7z1600-x64.exe
[x] \\svr\CDs\EXE\Filezilla_Pro_3.39.0_win64-setup.exe
[x] \\svr\CDs\EXE\vlc-3.0.8-win64.exe
[x] \\svr\CDs\EXE\Notepad++\npp.6.7.3.Installer.exe
[x] Install Adobe PDF reader: https://get.adobe.com/reader/
[]   - Set as default app for PDF files
[] Uninstall: CallScape, we use Zoom Phone now

Install Printer clients
\\10.0.0.130 (Xerox printer)
   \\svr\CDs\DRIVERS\Xerox_Driver_for_Windows_10_Setup_6.159.12.1_x64.exe
Other printer clients may be found in \\svr\CDs\DRIVERS


Windows settings
o Turn off sleep while not on battery
o Do nothing when lid closed while not on battery
o Create local admin account (.\admin)
   - Use password: Icor1014
o Make sure csc\it can RDP into the laptop (except for csc\training, which is restricted from RDP)
o Run from command line: xcopy \\svr\cds\utils\*.* c:\utils\*.* /s/d/y/v/c
o Add c:\utils to system path
o Turn on system restore for c: drive
o Turn on bitlocker for c: drive
  o Set password to: seniorcare3
  o Save bitlocker key to \\svr\it\PC_tech\Bitlocker_Keys\xxxx_csc<##>.txt
o Personalization
  o Open a Rainbow theme on \\svr\run\Rainbows.themepack
  o On Colors tab, 
    o click box next to "Start, taskbar, and action center"
    o click box next to "Ttitle bars and window borders"
o Remove distracting settings and extraneous apps
  o Apps
    o Default Apps: 
      o Set Music Player: Windows Media Player
      o Set Photo viewer
        o Run \\svr\CDs\run\photoviewer restore windows 10.reg
        o "Open with always" classic windows "Photoviewer"
      o Video Player
        o VLC media player
    o Turn off Maps
    o Startup
      o Turn off Cortana
      o Turn off Windows Security Notification
      o Turn off Your Phone
    o Gaming
      o Turn everything off, disable xbox services too
    o Privacy
      o Turn everything off except what is necessary
        o Allow apps access to Camera/microphone on, otherwise turn most things off
      o Turn off all background apps

o Taskbar settings
  o Add "Desktop" link
  o Make Search hidden
  o Turn off Show task view button
  o Turn off Show windows ink workspace button
  o Unpin from taskbar: 
    o Microsoft store
    o Mail
  o Pin to taskbar:
    o Chrome
    o MS Edge
    o Windows Explorer
    o Excel
    o Word
    o Snipping Tool
  o Turn system icons off:
    o Input indicator
    o Location
    o Action Center
    o Microphone

Browsers on all PCs
o Google Chrome
  o Import these bookmarks: \\svr\CDs\bookmarks_new_profile.html
  o Set Chrome as default browser
  o Remove distracting settings and extraneous apps
    o Show home button on
    o Show bookmarks bar on
    o Starting page: http://blank.knoxvilleseniorcare.com/
    o On startup open this page: http://blank.knoxvilleseniorcare.com/
    o Open a new page, then Customize, "hide shortcuts"
	o Disable "Reading List", chrome://flags, disable "reading list"
o MS Edge (new based on Chromium)
  o Import All settings from Chrome
  o Remove distracting settings and extraneous apps
    o Continue without signing in
    o Show favourites always
    o Turn off Show vertical tabs button
    o Turn off Show Collections button
    o On startup open page: http://blank.knoxvilleseniorcare.com/
    o Page Layout: 
      o Show quick links off
      o Show Bing searches off
      o Background off
      o Content off

Onedrive
o Setup Onedrive to automatically backup Documents, Pictures, and Desktop
  o Make sure OneDrive is logged on and backing up desktop and documents

o Setup a sync to "Archive - CDs - CDs", so that I can use a copy of \\svr\cds files when they work remote
  o Select "Always keep on this device"
o If a csc\training account, please also add "Operations\Office Staff" teams sync
  o Select "Always keep on this device"
o Open Excel and make sure Office 365 tools are signed into their account




Database users (install apps, I will perform final setup for connection to database)
Install in this order:
\\svr\CDs\EXE\MySQL\0Current\python-3.8.8-amd64.exe
\\svr\CDs\EXE\MySQL\0Current\vstor_redist.exe
\\svr\CDs\EXE\MySQL\0Current\vs_community__1138649447.1607629554.exe
\\svr\CDs\EXE\MySQL\0Current\mysql-installer-community-8.0.23.0.msi
\\svr\CDs\EXE\MySQL\0Current\mysql-for-excel-1.3.8.msi
Add to path: "c:\Program Files\MySQL\MySQL Workbench 8.0"


