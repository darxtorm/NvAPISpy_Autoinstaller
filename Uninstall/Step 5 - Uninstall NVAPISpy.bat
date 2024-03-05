@ECHO OFF
REM Batch file to uninstall NVAPISpy
if /i "%SAFEBOOT_OPTION%"=="MINIMAL" (echo We're in Safe Mode!) else (goto safemodeerror)

ECHO Checking if modified NVAPI files are still installed.
if not exist C:\Windows\SysWOW64\nvapi_orig.dll (
	echo Modified NVAPI files do not exist, exiting. 
	goto exit
)
if not exist C:\Windows\System32\nvapi64_orig.dll (
	echo Modified NVAPI files do not exist, exiting. 
	goto exit
)
ECHO Confirmed modified files are still installed.
ECHO.
ECHO.
ECHO Deleting modified NVAPI files.

del C:\Windows\SysWOW64\nvapi.dll
del C:\Windows\System32\nvapi64.dll

ECHO.
ECHO reinstalling original NVAPI files.

rename C:\Windows\SysWOW64\nvapi_orig.dll nvapi.dll 
rename C:\Windows\System32\nvapi64_orig.dll nvapi64.dll

ECHO.
ECHO Uninstall completed, please run Step 6 - Leave Safemode to reboot in non-safemode.
goto exit

:safemodeerror
ECHO Please ensure you are running Windows in Safe Mode.
ECHO Rerun Step 1 - Enter Safemode.
pause

:exit
ECHO exiting
pause