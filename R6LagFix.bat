@echo off
color 0a

echo --------------Rainbow Six Siege Lag fix----------------
echo.
echo -------------Version 1.0--------------
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

if %option%==1 (
  :loop1
  timeout /t 600
  PowerShell "$Process = Get-Process RainbowSix_Vulkan; $Process.ProcessorAffinity=8"
  timeout /t 1
  PowerShell "$Process = Get-Process RainbowSix_Vulkan; $Process.ProcessorAffinity=15"
  goto loop1
)

if %option%==2 (
  :loop2
  timeout /t 600
  PowerShell "$Process = Get-Process RainbowSix; $Process.ProcessorAffinity=8"
  timeout /t 1
  PowerShell "$Process = Get-Process RainbowSix; $Process.ProcessorAffinity=15"
  goto loop2
)

if %option%==3 (
  :check_process
  if exist "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" (
    PowerShell "$Process = Get-Process RainbowSix_Vulkan; if ($Process -ne $null) {$Process.ProcessorAffinity=8; Start-Sleep -s 1; $Process.ProcessorAffinity=15; goto check_process}"
    PowerShell "$Process = Get-Process RainbowSix; if ($Process -ne $null) {$Process.ProcessorAffinity=8; Start-Sleep -s 1; $Process.ProcessorAffinity=15; goto check_process}"
  ) else (
    echo PowerShell not found. Exiting...
    pause
    exit
  )
)

echo --------------Invalid option entered. Restarting script--------------
goto confirm