@echo off

:: Created by Jack Daniels
:: Version 1.3 Pre-Release

echo Author: Jack Daniels
echo Version: 1.3 Pre-Release
echo WARNING: Use of this script is at your own risk.
echo Please report any issues on the GitHub page: https://github.com/jackdaniels552/r6lagfix.

for /f %%i in ('powershell [System.Environment]::ProcessorCount') do set numProcessors=%%i
echo Number of processors on the system: %numProcessors%
set /p confirm=Please confirm (yes/no): 

if /i "%confirm%" NEQ "yes" (
  if /i "%confirm%" NEQ "y" (
    echo Please report this on the GitHub page: https://github.com/jackdaniels552/r6lagfix
    goto end
  )
)

:loop
echo Running the script...

powershell -Command "$rainbowSix = Get-Process | Where-Object { $_.ProcessName -eq 'RainbowSix' -or $_.ProcessName -eq 'RainbowSix_Vulkan' }; if ($rainbowSix) { foreach ($process in $rainbowSix) { $process.ProcessorAffinity = [int]([Math]::Pow(2, %numProcessors% - 1) - 1) } } else { Write-Host 'Neither RainbowSix nor RainbowSix_Vulkan processes were detected.'; break }"

timeout /t 600

set /p stop=Do you want to stop the script? (yes/no): 
if /i "%stop%" == "yes" (
  if /i "%stop%" == "y" (
    echo Stopping the script...
    goto end
  )
) else (
  if /i "%stop%" == "no" (
    if /i "%stop%" == "n" (
      goto loop
    )
  )
)

:end
echo The script has been stopped.
pause