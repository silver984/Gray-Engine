@echo off
echo.
echo --- OPTIONS ---
echo [1] lime build windows
echo [2] lime test windows
echo.

set /p choice=Enter your choice: 

if "%choice%"=="1" (
    echo haxelib run lime build windows
    echo.
    haxelib run lime build windows
) else if "%choice%"=="2" (
    echo haxelib run lime test windows
    echo.
    haxelib run lime test windows
) else (
    echo Invalid choice.
    echo.
)

pause