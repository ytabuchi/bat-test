@echo off
setlocal enabledelayedexpansion

set NUM=0
:Input
set INPUT=
set /p INPUT="Please input: "
if defined INPUT (
    set STORE[%NUM%]=%INPUT%
    set /a NUM+=1
    goto :Input
)

echo.

if %NUM% equ 0 (
    echo No input.
) else (
    set /a NUM-=1
    for /l %%i in (0, 1, !NUM!) do (
        echo store[%%i] is !STORE[%%i]!
    )
)

