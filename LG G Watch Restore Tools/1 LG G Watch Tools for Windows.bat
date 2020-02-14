::visit Rootjunky.com

::Set our Window Title
@title LG G Watch Tool

::Set our default parameters
@echo off
color 0b



:menuLOOP

	call:header
	::Print our header
	::call:header
	
	::Load up our menu selections
	echo.--------------------------------------------------------------------------------
	for /f "tokens=1,2,* delims=_ " %%A in ('"C:/Windows/system32/findstr.exe /b /c:":menu_" "%~f0""') do echo.  %%B  %%C
	
	call:printstatus

	set choice=
	echo.&set /p choice= Please make a selection or hit ENTER to exit: ||GOTO:EOF
	echo.&call:menu_%choice%
	
GOTO:menuLOOP

:menu_1    ADB & Fastboot Driver Install                 
cls
color 0b
echo.--------------------------------------------------------------------------------
echo[*] This option will run a program to get your adb drivers
echo[*] installed for your LG G watch exit program when done
echo.--------------------------------------------------------------------------------
echo.
for /f "tokens=1,2,* delims=_ " %%A in ('"C:/Windows/system32/findstr.exe /b /c:":driver_" "%~f0""') do echo.  %%B  %%C
	set choice=
	echo.&set /p choice= Please make a selection then hit ENTER:
	echo.&call:driver_%choice%
color 0b	
cls
GOTO:EOF

:driver_1  universal driver install
cls
color 0b
echo.--------------------------------------------------------------------------------
echo [*] press any key to start adb driver install
pause >nul
echo.--------------------------------------------------------------------------------
UniversalAdbDriverSetup.msi
echo.--------------------------------------------------------------------------------
echo [*] Before continuing, ensure USB debugging is enabled
echo [*] (device settings/about click on build number 10 times
echo [*] back to settings/developer options enable usb debugging) 
echo [*] connect G Watch via USB charging dock to the computer
echo [*] MAKES SURE YOUR ANTI VERUS IS OFF. 
echo.--------------------------------------------------------------------------------
echo [*] After drivers are installed wait 2 minutes then press any key 
echo [*] to Reboot into bootloader to install fastboot drivers
echo.--------------------------------------------------------------------------------
pause >nul
adb reboot bootloader
echo.--------------------------------------------------------------------------------
echo [*] please wait for drivers to install. give it 2 minutes
echo [*] recommend running the ADB driver test after this install
echo [*] some times a computer reboot is required to finish the driver install
echo.--------------------------------------------------------------------------------
pause >nul
echo [*] RootJunky OUT
fastboot.exe reboot
adb kill-server
	
	set choice=
	echo.&set /p choice= hit ENTER to return to start: ||GOTO:EOF
	echo.&call:bootsubmenu_%choice%
color 0b	
cls	
GOTO:EOF

:driver_2  ADB & Fastboot Driver Test
cls
color 0b
echo [*] Press any key to check if your drivers are installed
echo [*] correctly. 
echo.--------------------------------------------------------------------------------
pause > nul
echo.--------------------------------------------------------------------------------
echo [*] Is there a device listed under list of devices attached?
echo [*] IF no then exit tool and reboot computer and run the driver  
echo [*] install option again then recheck
ehco [*] If yes then continue test
echo [*] press any key to continue
echo.--------------------------------------------------------------------------------
adb devices
pause > nul
adb reboot bootloader
echo.--------------------------------------------------------------------------------
echo [*] press any key to check fastboot drivers
pause > nul
echo.--------------------------------------------------------------------------------
echo [*] If you see a number with Fastboot after it your drivers are good
echo [*] IF no then reboot computer and run the driver install option 
echo.--------------------------------------------------------------------------------
timeout 4 > nul
fastboot.exe devices
echo [*] press any key to reboot device
echo.--------------------------------------------------------------------------------
pause > nul
fastboot.exe reboot
adb kill-server
echo [*] RootJunky OUT
	set choice=
	echo.&set /p choice= hit ENTER to return to start: ||GOTO:EOF
	echo.&call:bootsubmenu_%choice%
color 0b	
cls	
GOTO:EOF


:menu_2 Unlock G Watch Bootloader       (this will factory reset your device)
cls
color 0b
echo.--------------------------------------------------------------------------------
echo [*] Simple LG G Watch Tool
echo [*] Windows Version
echo [*] Created by RootJunky.com
echo.--------------------------------------------------------------------------------
echo [*] Before continuing, ensure USB debugging is enabled,
echo [*] (device settings/about then click on build number 10 times
echo [*] back to settings/developer options enable usb debugging) 
echo [*] have the Universal drivers installed and your G Watch
echo [*] connected via USB charging dock to the computer
echo [*] WARNING THIS WILL FACTORY RESET YOUR DEVICE
echo.--------------------------------------------------------------------------------
echo [*] Press any key to unlock your watch bootloader...
pause > nul
echo [*] Waiting for device...
adb wait-for-device
echo [*] Device found.
adb reboot bootloader
echo.--------------------------------------------------------------------------------
echo [*] on the next screen you see the unlock No. press the little
echo [*] arrow at the bottom of screen to yes then press the circle
echo [*] when its done you will be back in boot menu
echo [*] and it will say unlocked. 
echo.--------------------------------------------------------------------------------
echo [*] Press any key to start
pause >nul
fastboot.exe oem unlock
echo.--------------------------------------------------------------------------------
echo [*] First boot will take up to 10 minutes and boot twice.
echo.--------------------------------------------------------------------------------
echo [*] press any key to reboot the device once unlocked.
pause > nul
fastboot.exe reboot
adb kill-server
echo [*] RootJunky OUT
	set choice=
	echo.&set /p choice= hit ENTER to return to start: ||GOTO:EOF
	echo.&call:extrasubmenu_%choice%
color 0b	
cls
GOTO:EOF


:menu_3 ReLock G Watch Bootloader              (unlocked bootloader required)
cls
color 0b	
echo.--------------------------------------------------------------------------------
echo [*] Before continuing, ensure USB debugging is enabled,
echo [*] (device settings/about then click on build number 10 times
echo [*] back to settings/developer options enable usb debugging) 
echo [*] have the Universal drivers installed and your G Watch
echo [*] connected via USB charging dock to the computer
echo.--------------------------------------------------------------------------------
echo [*] Press any key to Relock your watch bootloader...
pause > nul
echo [*] Waiting for device...
adb wait-for-device
echo [*] Device found.
adb reboot bootloader
fastboot.exe oem lock
echo.--------------------------------------------------------------------------------
echo [*] First boot will take up to 5 minutes
echo.--------------------------------------------------------------------------------
echo [*] press any key to reboot the device once locked.
pause > nul
fastboot.exe reboot
adb kill-server
echo [*] RootJunky OUT
	set choice=
	echo.&set /p choice= hit ENTER to return to start: ||GOTO:EOF
	echo.&call:extrasubmenu_%choice%
color 0b	
cls
GOTO:EOF


:menu_4    Flash just stock wear recovery         (unlocked bootloader required)
cls
color 0b
echo.--------------------------------------------------------------------------------
echo [*] Before continuing, ensure USB debugging is enabled
echo [*] This will flash stock recovery to your
echo [*] device from fastboot then reboot back to system
echo.--------------------------------------------------------------------------------
echo [*] press any button to continue
pause > nul
echo [*] waiting for device
adb wait-for-device
echo [*] device found
adb reboot bootloader
fastboot.exe flash recovery 48Precovery.img
fastboot.exe reboot
adb kill-server
echo [*] RootJunky OUT
	set choice=
	echo.&set /p choice= hit ENTER to return to start: ||GOTO:EOF
	echo.&call:bootsubmenu_%choice%
color 0b	
cls	
GOTO:EOF


:menu_5    Flash Just Stock wear boot image       (unlocked bootloader required)
cls
color 0b
echo.--------------------------------------------------------------------------------
echo [*] Before continuing, ensure your device is in bootloader
echo [*] mode. to Get into bootloader mode you have to press a pen
echo [*] into the back reset button and wait for the device to restart.
echo [*] as soon as you see the LG logo press both the top left and 
echo [*] bottom right corners of the screen repeatedly while still holding
echo [*] the reset button and the bootloader screen will pop up.
echo [*] release the pen holding the reset button and you are in bootloader.
echo.--------------------------------------------------------------------------------
echo [*] now place the watch on the charging dock and connect the dock to
echo [*] your computer and let the devices install
echo.--------------------------------------------------------------------------------
echo [*] Press any key to flash boot image to your G watch 
pause > nul
fastboot.exe flash boot 48Pboot.img
fastboot.exe reboot
adb kill-server
echo [*] RootJunky OUT
	set choice=
	echo.&set /p choice= hit ENTER to return to start: ||GOTO:EOF
	echo.&call:bootsubmenu_%choice%
color 0b	
cls	
GOTO:EOF


:menu_6    Restore your G watch to stock          (unlocked bootloader required)
cls
color 0b
echo.--------------------------------------------------------------------------------
echo [*] WARNING I have never used this to Update to Lollipop from Kitkat
echo [*] you can try it but if it fails to boot after 10 minutes 
echo [*] then you will need to use tool version 8 to restore our device. 
echo.--------------------------------------------------------------------------------
echo [*] Restore G watch to stock to fix a brick or just return to stock
echo [*] After restore runs you will boot to recovery where you can either 
echo [*] reboot the device or do a factory reset
echo [*] Before continuing, ensure your LG G Watch is in
echo [*] "Fastboot" mode and connected via USB with the drivers installed.
echo.--------------------------------------------------------------------------------
echo [*] To Get into bootloader mode you have to press a pen
echo [*] into the back reset button and wait for the device to restart.
echo [*] as soon as you see the LG logo press both the top left and 
echo [*] bottom right corners of the screen repeatedly while still holding
echo [*] the reset button and the bootloader screen will pop up.
echo [*] release the pen holding the reset button and you are in bootloader.
echo.--------------------------------------------------------------------------------
echo [*] Another option to enter bootloader mode is to open a command
echo [*] window and type adb reboot bootloader. only if the device is on.
echo.--------------------------------------------------------------------------------
echo [*] press any key to continue
pause > nul
fastboot.exe devices
fastboot.exe flash system 48Psystem.img
fastboot.exe flash boot 48Pboot.img
fastboot.exe flash recovery 48Precovery.img
echo.--------------------------------------------------------------------------------
echo [*] Press the arrow bottom right to scroll to recovery
echo [*] then the circle to boot recovery to factory reset
echo [*] in recovery you will see a android guy on his back
echo [*] press the top left and bottom right of screen again
echo [*] to enter recovery menu. now scroll up and down and swipe
echo [*] right to select. when done in recovery just reboot.
echo.--------------------------------------------------------------------------------
echo [*] If you dont want to factory reset just press the circle button
echo [*] I recommend fastory resetting device at this time.
echo.--------------------------------------------------------------------------------
echo [*] this is a pre ROOTED System.img so you should also have root now :-)
adb kill-server
echo [*] RootJunky OUT
	set choice=
	echo.&set /p choice= hit ENTER to return to start: ||GOTO:EOF
	echo.&call:bootsubmenu_%choice%
color 0b	
cls	
GOTO:EOF


:menu_7    Root your G Watch NOT WORKING LOLLIPOP (unlocked bootloader required)
cls
color 0b
echo.--------------------------------------------------------------------------------
echo [*] Big thanks to Jcase for Modded boot image
echo [*] Make sure USB Debugging is enabled on your watch
echo [*] this will boot a root boot img and reboot 
echo [*] your device like normal
echo.--------------------------------------------------------------------------------
echo [*] press any key to start
pause > nul
echo [*]
echo [*] waiting for device
adb wait-for-device...
adb reboot bootloader
fastboot.exe boot LGGW-rootboot.img
echo.--------------------------------------------------------------------------------
echo [*] to test root on your watch open a commadn window 
echo [*] type = adb shell
echo [*] type = su
echo [*] if it returns
echo [*] root@dory # 
echo [*] then you have root access
echo.--------------------------------------------------------------------------------
adb kill-server
echo [*] Press any key to finish this script. ROOTJUNKY OUT

	set choice=
	echo.&set /p choice= hit ENTER to return to start: ||GOTO:EOF
	echo.&call:bootsubmenu_%choice%
cls	
GOTO:EOF


:menu_8    Flash TWRP recovery                    (unlocked bootloader required)
cls
color 0b
echo.--------------------------------------------------------------------------------
echo [*] This will flash Team win / TWRP recovery
echo [*] to your device from fastboot. 
echo.--------------------------------------------------------------------------------
echo [*] Press any button to continue
pause > nul
echo [*] waiting for device
adb wait-for-device
echo [*] device found
adb reboot bootloader
fastboot.exe flash recovery openrecovery-twrp-2.8.1.0-dory.img
echo.--------------------------------------------------------------------------------
echo [*] your device is on the boot menu screen now scoll to Recovery
echo [*] with arrow buttons and select with circle to boot to recovery
echo.--------------------------------------------------------------------------------
echo [*] Thats it TWRP recovery is now installed on your G Watch
echo.--------------------------------------------------------------------------------
adb kill-server
echo [*] RootJunky OUT
	set choice=
	echo.&set /p choice= hit ENTER to return to start: ||GOTO:EOF
	echo.&call:bootsubmenu_%choice%
color 0b	
cls	
GOTO:EOF


:menu_9    Install Reboot Recovery App            (root required)
cls
color 0b
echo.--------------------------------------------------------------------------------
echo [*] Press any button to install app on your G Watch
echo.--------------------------------------------------------------------------------
pause > nul
echo [*] waiting for device
adb wait-for-device
echo [*] device found
adb install awr.apk
adb kill-server
echo.--------------------------------------------------------------------------------
echo [*] App installed go to settings them start to use app
echo.--------------------------------------------------------------------------------
echo [*] RootJunky OUT
	set choice=
	echo.&set /p choice= hit ENTER to return to start: ||GOTO:EOF
	echo.&call:bootsubmenu_%choice%
color 0b	
cls	
GOTO:EOF

:header  
cls        
color 0e
echo.[////////////////////////////      //////////            //////////////////////]                                                                           
echo.[///////////////////////////  ///   //////////////  ///////////////////////////]                                                                            
echo.[//////////////////////////  ////  //////////////  ////////////////////////////]                                                                    
echo.[/////////////////////////  //   ///////////////  /////////////////////////////]                                       
echo.[////////////////////////  ////  /////////  ///  //////////////////////////////]                                  
echo.[///////////////////////  //////  /////////    ////////////////////////////////]    
echo.                                 RootJunky.com
echo.			    LG G Watch Tool V9 LWX48P
echo.			  Huge thanks to Jcase for root
echo.--------------------------------------------------------------------------------
adb kill-server
adb start-server
echo.--------------------------------------------------------------------------------
adb devices
timeout 5 > nul
fastboot devices
timeout 5 > nul
cls	
color 0b
GOTO:EOF

:printstatus
echo.
echo. Time to unlock the Beast
echo.--------------------------------------------------------------------------------
GOTO:EOF

