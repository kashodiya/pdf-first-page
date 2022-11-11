@echo off
set logFile=convert.bat
set sourceFolder=%~1
set targetFolder=%~2
 
echo Checking source folder...
if not exist "%sourceFolder%" (
    echo Error: Please make sure that "%sourceFolder%" exist.
    exit /b
)
 
echo Checking target folder...
if not exist "%targetFolder%" (
    echo Error: Please make sure that "%targetFolder%" exist.
    exit /b
)
for /F %%i in ('dir /b /a "%targetFolder%"') do (
    echo Error: Make sure that "%targetFolder%" is empty.
    exit /b
)
 
echo Creating target sub-folders...
@REM del /Q /S "%targetFolder%\*"
xcopy "%sourceFolder%" "%targetFolder%" /t /e /-Y
 
echo Reading files from: %sourceFolder%
 
echo @REM This file was generated on: %date% %time% > %logFile%
echo @REM Replace all "XX_%sourceFolder%" with "%targetFolder%" >> %logFile%
echo @REM Source directory = %sourceFolder%  >> %logFile%
echo @REM Target directory = %targetFolder%  >> %logFile%
 
@REM for /f "delims=" %%a IN ('dir /b /s "%sourceFolder%\*.pdf"') do echo copy "%%a" "XX_%%a-page-1.pdf"   >> %logFile%
 
setlocal ENABLEDELAYEDEXPANSION
 
for /f "delims=" %%a IN ('dir /b /s "%sourceFolder%\*.pdf"') do (
    set str="XX_%%a-page-1.pdf"
    set find1=XX_%sourceFolder%
    @REM echo Replacing "%find1%" in "%str%" with "%targetFolder%"
    call set target=%%str:XX=11%%
    echo copy "%%a" "XX_%%a-page-1.pdf" >> %logFile%
    @REM echo copy "%%a" "%target%" XXX >> %logFile%
)
 
 
@REM echo @rem This is just to empty > convert.bat
@REM powershell -Command "(gc %logFile%) -replace 'XX_%sourceFolder%', '%targetFolder%' | Out-File -encoding ASCII convert.bat"
 
 
echo Command file generated: %logFile%
echo.
echo ============
echo Instructions
echo ============
echo Open "%logFile%" in a text editor.
echo Replace all "XX_%sourceFolder%" with "%targetFolder%".
echo Save the file.
echo Execute the batch file: %logFile%
echo.
 
 
 
 
 