@ECHO OFF
REM Batch file to install NVAPISpy
if /i "%SAFEBOOT_OPTION%"=="MINIMAL" (echo We're in Safe Mode!) else (goto safemodeerror)
echo Checking if nvAPISpy Folder Exists.
if exist C:\nvAPISpy\ (echo nvAPISpy folder exists, moving on to file modification.) else (echo nvAPISpy folder does not exist. Creating it now. 
mkdir C:\nvAPISpy)
echo Grabbing GPU Hardware Info.
wmic/output:C:\nvAPISpy\GPUHardwareInfo.txt path win32_VideoController get Name, AdapterRAM, PNPDeviceID
echo Checking if nvAPI files have already been modified.
if exist C:\Windows\SysWOW64\nvapi_orig.dll (echo NVAPI files have already been modified. Exiting. 
goto exit)
if exist CC:\Windows\System32\nvapi64_orig.dll (echo NVAPI files have already been modified. Exiting. 
goto exit)
echo nvAPI files have not been modified. Proceeding with modification.
echo.
echo.
echo Checking if failsafe backups exist
if exist C:\NvAPISpy\nvapi_backup.dll goto skip_backup
if exist C:\NvAPISpy\nvapi64_backup.dll goto skip_backup
echo.
echo Backing up original files to C:\NvAPISpy
copy C:\Windows\SysWOW64\nvapi.dll C:\NvAPISpy\nvapi_backup.dll
copy C:\Windows\System32\nvapi64.dll C:\NvAPISpy\nvapi64_backup.dll
:skip_backup

echo.
echo Renaming original NVAPI files.
rename C:\Windows\SysWOW64\nvapi.dll nvapi_orig.dll
rename C:\Windows\System32\nvapi64.dll nvapi64_orig.dll

echo.
echo Original files have been renamed, copying NVApiSpy files in
copy "%~dp0\nvapi.dll" C:\Windows\SysWOW64\nvapi.dll
copy "%~dp0\nvapi64.dll" C:\Windows\System32\nvapi64.dll

echo.
echo Install completed, please run Step 3 to reboot in non-safemode
goto exit

:safemodeerror
echo Please ensure you are running Windows in Safe Mode.
echo Rerun Step 1 - Enter Safemode.
pause

:exit
echo exiting
pause
