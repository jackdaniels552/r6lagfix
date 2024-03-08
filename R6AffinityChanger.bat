@echo off

:: Created by Jack Daniels
:: Version 1.7

echo Author: Jack Daniels
echo Version: 1.7 
echo WARNING: Use of this script is at your own risk.
echo NOTICE: CLOSE THIS WINDOW TO STOP THE SCRIPT!
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

powershell -Command "$rainbowSix = Get-Process | Where-Object { $_.ProcessName -eq 'RainbowSix' -or $_.ProcessName -eq 'RainbowSix_Vulkan' }; if ($rainbowSix) { foreach ($process in $rainbowSix) { $process.ProcessorAffinity = 1 } } else { Write-Host 'Neither RainbowSix nor RainbowSix_Vulkan processes were detected.'; break }"
powershell -Command "$rainbowSix = Get-Process | Where-Object { $_.ProcessName -eq 'RainbowSix' -or $_.ProcessName -eq 'RainbowSix_Vulkan' }; if ($rainbowSix) { foreach ($process in $rainbowSix) { $process.ProcessorAffinity = [IntPtr]::new([Math]::Pow(2, %numProcessors%) - 1) } } else { Write-Host 'Neither RainbowSix nor RainbowSix_Vulkan processes were detected.'; break }"

timeout /t 600

goto loop

:end
echo The script has been stopped.
pause
