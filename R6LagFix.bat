@echo off
color 0a

echo --------------Rainbow Six Siege Lag fix----------------
echo.
echo -------------Version 1.2--------------
echo.
echo -------------By Jack Daniels--------------
echo.

:confirm
echo -------------Have you edited the processor value in this script to match your CPU?--------------
echo.
echo -------------If not, edit now and run the script again. If yes, press any key to continue--------------
pause >nul

:choose
echo.
echo --------------Choose an option--------------
echo.
echo --------------1. Manual - RainbowSix_Vulkan--------------
echo --------------2. Manual - RainbowSix--------------
echo --------------3. Automatic--------------
echo.

set /p option=Enter option number:

:: Option 1 - Manual with RainbowSix_Vulkan process
if %option%==1 (
:loop1
timeout /t 600
PowerShell "$Process = Get-Process RainbowSix_Vulkan; $Process.ProcessorAffinity=8"
timeout /t 1
PowerShell "$Process = Get-Process RainbowSix_Vulkan; $Process.ProcessorAffinity=15"
goto loop1
)

:: Option 2 - Manual with RainbowSix process
if %option%==2 (
:loop2
timeout /t 600
PowerShell "$Process = Get-Process RainbowSix; $Process.ProcessorAffinity=8"
timeout /t 1
PowerShell "$Process = Get-Process RainbowSix; $Process.ProcessorAffinity=15"
goto loop2
)

:: Option 3 - Automatic
if %option%==3 (
  :check_process
  if exist "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" (
    :process_vulkan
    PowerShell "$Process = Get-Process RainbowSix_Vulkan; if ($Process -ne $null) {$Process.ProcessorAffinity=8; Start-Sleep -s 1; $Process.ProcessorAffinity=15}"
    goto process_rainbow
  ) else (
    echo PowerShell not found. Exiting...
    pause
    exit
  )
  :process_rainbow
  PowerShell "$Process = Get-Process RainbowSix; if ($Process -ne $null) {$Process.ProcessorAffinity=8; Start-Sleep -s 1; $Process.ProcessorAffinity=15}"
  
  :ask_continue
  echo Do you want to continue checking for both processes? (Y/N)
  set /p answer=
  if /I %answer% NEQ Y (
    exit
  ) else (
    goto check_process
  )
)

:: Invalid option entered
echo --------------Invalid option entered. Restarting script--------------
goto confirm