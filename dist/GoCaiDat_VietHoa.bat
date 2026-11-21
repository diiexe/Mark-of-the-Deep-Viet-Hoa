@echo off
setlocal EnableDelayedExpansion
chcp 65001 >nul 2>&1
title GO CAI DAT VIET HOA MARK OF THE DEEP - By Diiexe

if /i not "%~1"=="--no-elevate" (
    net session >nul 2>&1
    if errorlevel 1 (
        echo [THONG BAO] Dang mo bang quyen Administrator...
        powershell -NoProfile -Command "Start-Process cmd.exe -ArgumentList '/c \"\"%~f0\"\"' -Verb RunAs"
        exit /b 0
    )
)

cd /d "%~dp0"

echo ========================================================================
echo             GO CAI DAT VIET HOA GAME: MARK OF THE DEEP
echo                   Khoi phuc game ve ban goc sach
echo            Thuc hien boi: Diiexe (https://github.com/diiexe)
echo   [MIEN PHI 100%%] Neu ban phai tra tien mua ban dich nay la bi lua dao
echo ========================================================================
echo.

set "PAKS_DIR="
set "DETECTED_PATH="

for %%P in (
    "D:\Epic\MarkoftheDeepFLAf5"
    "C:\Program Files\Epic Games\MarkoftheDeepFLAf5"
    "D:\Epic Games\MarkoftheDeepFLAf5"
    "C:\Program Files\Epic Games\MarkOfTheDeep"
    "D:\Epic Games\MarkOfTheDeep"
    "E:\Epic Games\MarkOfTheDeep"
    "D:\Epic\MarkOfTheDeep"
    "C:\Program Files (x86)\Steam\steamapps\common\Mark of the Deep"
    "D:\SteamLibrary\steamapps\common\Mark of the Deep"
    "E:\SteamLibrary\steamapps\common\Mark of the Deep"
    "%~dp0.."
    "%~dp0"
) do (
    if not defined DETECTED_PATH (
        if exist "%%~P\MarkOfTheDeep\Content\Paks" set "DETECTED_PATH=%%~P\MarkOfTheDeep\Content\Paks"
        if not defined DETECTED_PATH (
            if exist "%%~P\Content\Paks" set "DETECTED_PATH=%%~P\Content\Paks"
        )
    )
)

if defined DETECTED_PATH (
    echo [OK] Da tim thay thu muc game Paks tai: !DETECTED_PATH!
    echo - Nhan Enter de go bo ngay.
    echo - Hoac nhap 'M' / dan luon duong dan thu muc khac vao day:
    set "AUTO_CONFIRM="
    set /p "AUTO_CONFIRM=> "
    if not defined AUTO_CONFIRM (
        set "PAKS_DIR=!DETECTED_PATH!"
        goto DO_UNINSTALL
    )
    if /i not "!AUTO_CONFIRM!"=="M" (
        set "RAW_PATH=!AUTO_CONFIRM!"
        goto VALIDATE_RAW_PATH
    )
)

:MANUAL_INPUT
echo.
echo Dan duong dan thu muc game Mark of the Deep vao day roi nhan Enter:
echo (Vi du: D:\Epic\MarkoftheDeepFLAf5)
set "RAW_PATH="
set /p "RAW_PATH=Duong dan: "
if not defined RAW_PATH goto MANUAL_INPUT

:VALIDATE_RAW_PATH
set "CLEAN_PATH="
set "PARENT_DIR="
for /f "tokens=* delims=" %%A in ("!RAW_PATH!") do (
    set "CLEAN_PATH=%%~A"
    set "PARENT_DIR=%%~dpA"
)
if not defined CLEAN_PATH goto MANUAL_INPUT
if "!CLEAN_PATH:~-1!"=="\" set "CLEAN_PATH=!CLEAN_PATH:~0,-1!"
if defined PARENT_DIR (
    if "!PARENT_DIR:~-1!"=="\" set "PARENT_DIR=!PARENT_DIR:~0,-1!"
)

set "PAKS_DIR="
if exist "!CLEAN_PATH!\MarkOfTheDeep\Content\Paks" set "PAKS_DIR=!CLEAN_PATH!\MarkOfTheDeep\Content\Paks"
if not defined PAKS_DIR (
    if exist "!CLEAN_PATH!\Content\Paks" set "PAKS_DIR=!CLEAN_PATH!\Content\Paks"
)
if not defined PAKS_DIR (
    if exist "!CLEAN_PATH!\pakchunk0-Windows.pak" set "PAKS_DIR=!CLEAN_PATH!"
)
if not defined PAKS_DIR (
    if defined PARENT_DIR (
        if exist "!PARENT_DIR!\MarkOfTheDeep\Content\Paks" set "PAKS_DIR=!PARENT_DIR!\MarkOfTheDeep\Content\Paks"
        if not defined PAKS_DIR (
            if exist "!PARENT_DIR!\Content\Paks" set "PAKS_DIR=!PARENT_DIR!\Content\Paks"
        )
    )
)

if not defined PAKS_DIR (
    echo [LOI] Khong tim thay thu muc game hop le tai: !CLEAN_PATH!
    pause
    goto MANUAL_INPUT
)

:DO_UNINSTALL
echo.
echo Dang go bo Viet Hoa tai: !PAKS_DIR!

del /f /q "!PAKS_DIR!\.perm_test.tmp" >nul 2>&1
echo test > "!PAKS_DIR!\.perm_test.tmp" 2>nul
if not exist "!PAKS_DIR!\.perm_test.tmp" (
    echo [LOI] Khong co quyen ghi vao thu muc game. Hay chay bang Run as Administrator.
    pause
    exit /b 1
)
del /f /q "!PAKS_DIR!\.perm_test.tmp" >nul 2>&1

set "MODS_DIR=!PAKS_DIR!\~mods"
set "REMOVED=0"

if exist "!MODS_DIR!\pakchunk0-VietHoa_P.pak" (
    del /f /q "!MODS_DIR!\pakchunk0-VietHoa_P.pak" >nul 2>&1
    if exist "!MODS_DIR!\pakchunk0-VietHoa_P.pak" goto UNINSTALL_FAIL
    set "REMOVED=1"
)

if exist "!PAKS_DIR!\pakchunk0-VietHoa_P.pak" (
    del /f /q "!PAKS_DIR!\pakchunk0-VietHoa_P.pak" >nul 2>&1
    if exist "!PAKS_DIR!\pakchunk0-VietHoa_P.pak" goto UNINSTALL_FAIL
    set "REMOVED=1"
)

if exist "!MODS_DIR!" rd "!MODS_DIR!" 2>nul

echo.
if "!REMOVED!"=="1" goto UNINSTALL_SUCCESS
goto UNINSTALL_NOT_FOUND

:UNINSTALL_SUCCESS
echo ========================================================================
echo   [OK] DA GO BO BAN VIET HOA THANH CONG
echo   Tep mod da duoc xoa. Game da tro ve nguyen ban 100%% goc.
echo ========================================================================
goto UNINSTALL_END

:UNINSTALL_NOT_FOUND
echo ========================================================================
echo [THONG BAO] Khong tim thay tep mod trong game nay.
echo ========================================================================
goto UNINSTALL_END

:UNINSTALL_FAIL
echo ========================================================================
echo [LOI] Khong the xoa tep mod. Hay dam bao game dang TAT hoan toan.
echo ========================================================================
goto UNINSTALL_END

:UNINSTALL_END
echo.
pause
exit /b 0
