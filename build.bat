@echo off
echo Build options:
echo [1] lime build windows
echo [2] lime test windows
echo.

set /p choice=Input: 

if "%choice%"=="1" (
    echo Compiling release build...
    echo.
    haxelib run lime build windows
) else if "%choice%"=="2" (
    echo Compiling debug build...
    echo.
    haxelib run lime test windows
) else (
    echo Invalid!
    echo.
)

pause