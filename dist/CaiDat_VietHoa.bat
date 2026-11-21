@echo off
setlocal EnableDelayedExpansion
chcp 65001 >nul 2>&1
title CAI DAT VA GO BO VIET HOA MARK OF THE DEEP - By Diiexe

if /i not "%~1"=="--no-elevate" (
    net session >nul 2>&1
    if errorlevel 1 (
        echo [THONG BAO] Dang mo bang quyen Administrator...
        powershell -NoProfile -Command "Start-Process cmd.exe -ArgumentList '/c \"\"%~f0\"\"' -Verb RunAs"
        exit /b 0
    )
)

cd /d "%~dp0"

:MENU
set "PAK_FILE="
if exist "%~dp0pakchunk0-VietHoa_P.pak" set "PAK_FILE=%~dp0pakchunk0-VietHoa_P.pak"
if exist "%~dp0dist\pakchunk0-VietHoa_P.pak" set "PAK_FILE=%~dp0dist\pakchunk0-VietHoa_P.pak"
if exist "%~dp0..\dist\pakchunk0-VietHoa_P.pak" set "PAK_FILE=%~dp0..\dist\pakchunk0-VietHoa_P.pak"

cls
echo ========================================================================
echo             CAI DAT VA GO VIET HOA GAME: MARK OF THE DEEP
echo               Phien ban ho tro: v2.3.6 (UE5)  ^|  Ban dich: v1.0.0
echo            Thuc hien boi: Diiexe (https://github.com/diiexe)
echo   [MIEN PHI 100%%] Neu ban phai tra tien mua ban dich nay la bi lua dao
echo ========================================================================
echo.
echo   1. Cai dat ban Viet Hoa vao game
echo   2. Go bo Viet Hoa (Khoi phuc game goc sach)
echo   0. Thoat
echo.
echo ========================================================================
set "CHOICE="
set /p "CHOICE=Nhap lua chon cua ban (1, 2, 0) [Mac dinh la 1]: "

if not defined CHOICE set "CHOICE=1"
if "!CHOICE!"=="0" exit /b 0
if "!CHOICE!"=="1" goto CHON_CAI_DAT
if "!CHOICE!"=="2" goto CHON_GO_BO
goto MENU

:CHON_CAI_DAT
call :DETECT_GAME
if "!USER_CANCEL!"=="1" goto MENU
goto DO_INSTALL

:CHON_GO_BO
call :DETECT_GAME
if "!USER_CANCEL!"=="1" goto MENU
goto DO_UNINSTALL

:DETECT_GAME
set "USER_CANCEL=0"
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
    echo.
    echo ------------------------------------------------------------------------
    echo [OK] Da tu dong tim thay thu muc game Paks tai:
    echo      !DETECTED_PATH!
    echo ------------------------------------------------------------------------
    echo - Nhan Enter de dung thu muc nay.
    echo - Hoac nhap 'M' / dan luon duong dan thu muc khac vao day.
    echo - Hoac nhap '0' de quay lai Menu.
    set "AUTO_CONFIRM="
    set /p "AUTO_CONFIRM=> "
    if not defined AUTO_CONFIRM (
        set "PAKS_DIR=!DETECTED_PATH!"
        exit /b 0
    )
    if "!AUTO_CONFIRM!"=="0" (
        set "USER_CANCEL=1"
        exit /b 0
    )
    if /i not "!AUTO_CONFIRM!"=="M" (
        set "RAW_PATH=!AUTO_CONFIRM!"
        goto VALIDATE_RAW_PATH
    )
)

:MANUAL_INPUT
echo.
echo ========================================================================
echo Dan duong dan thu muc game Mark of the Deep vao day roi nhan Enter:
echo (Vi du: D:\Epic\MarkoftheDeepFLAf5)
echo Hoac nhap '0' de quay lai Menu.
echo ========================================================================
set "RAW_PATH="
set /p "RAW_PATH=Duong dan: "

if not defined RAW_PATH goto MANUAL_INPUT
if "!RAW_PATH!"=="0" (
    set "USER_CANCEL=1"
    exit /b 0
)

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
    echo.
    echo ========================================================================
    echo [LOI] Khong tim thay thu muc Content\Paks cua Mark of the Deep tai:
    echo       !CLEAN_PATH!
    echo Vui long kiem tra lai duong dan thu muc game.
    echo ========================================================================
    echo.
    pause
    goto MANUAL_INPUT
)
exit /b 0

:DO_INSTALL
if not defined PAK_FILE (
    echo.
    echo ========================================================================
    echo [LOI] Khong tim thay tep pakchunk0-VietHoa_P.pak.
    echo       Vui long giai nen day du goi cai dat truoc khi chay script.
    echo ========================================================================
    echo.
    pause
    goto MENU
)

echo.
echo ========================================================================
echo DANG TIEN HANH CAI DAT VAO:
echo !PAKS_DIR!
echo ========================================================================

del /f /q "!PAKS_DIR!\.perm_test.tmp" >nul 2>&1
echo test > "!PAKS_DIR!\.perm_test.tmp" 2>nul
if not exist "!PAKS_DIR!\.perm_test.tmp" (
    echo.
    echo [LOI] Khong co quyen ghi vao thu muc game nay.
    echo Hay nhap chuot phai vao file CaiDat_VietHoa.bat va chon "Run as Administrator".
    echo.
    pause
    goto MENU
)
del /f /q "!PAKS_DIR!\.perm_test.tmp" >nul 2>&1

set "MODS_DIR=!PAKS_DIR!\~mods"
if not exist "!MODS_DIR!" mkdir "!MODS_DIR!"

echo [*] Dang chep tep pakchunk0-VietHoa_P.pak vao thu muc ~mods...
copy /y "!PAK_FILE!" "!MODS_DIR!\pakchunk0-VietHoa_P.pak" >nul
if errorlevel 1 goto INSTALL_FAIL

echo.
echo ========================================================================
echo   [OK] CHUC MUNG - BAN VIET HOA MARK OF THE DEEP DA CAI DAT THANH CONG
echo ========================================================================
echo - Tac gia ban Viet Hoa ^& Bo cong cu: Diiexe (github.com/diiexe)
echo - Ban dich MIEN PHI 100%%. Neu ban phai mua bang tien la bi lua dao.
echo - 2.946 chuoi van ban, hoi thoai va giao dien hoan toan bang Tieng Viet.
echo - Font chu Serif Cardo day du dau Unicode chuan Unreal Engine 5.
echo - 100%% khong sua doi hay ghi de len cac tep goc cua game.
echo - Bay gio ban co the mo game va thuong thuc Tieng Viet.
echo ========================================================================
echo.
pause
exit /b 0

:INSTALL_FAIL
echo.
echo ========================================================================
echo [LOI] Khong the chep tep mod vao thu muc game.
echo Hay dam bao game Mark of the Deep dang TAT hoan toan truoc khi cai dat,
echo va chay file .bat bang quyen "Run as Administrator".
echo ========================================================================
echo.
pause
goto MENU

:DO_UNINSTALL
echo.
echo ========================================================================
echo DANG TIEN HANH GO BO VIET HOA TAI:
echo !PAKS_DIR!
echo ========================================================================

del /f /q "!PAKS_DIR!\.perm_test.tmp" >nul 2>&1
echo test > "!PAKS_DIR!\.perm_test.tmp" 2>nul
if not exist "!PAKS_DIR!\.perm_test.tmp" (
    echo.
    echo [LOI] Khong co quyen ghi vao thu muc game nay.
    echo Hay nhap chuot phai vao file .bat va chon "Run as Administrator".
    echo.
    pause
    goto MENU
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
echo   Tep mod da duoc xoa bo. Game da tro ve nguyen ban 100%% goc sach.
echo ========================================================================
goto UNINSTALL_END

:UNINSTALL_NOT_FOUND
echo ========================================================================
echo [THONG BAO] Khong tim thay tep mod pakchunk0-VietHoa_P.pak trong game nay.
echo Co the game chua tung cai ban Viet Hoa hoac da duoc go bo truoc do.
echo ========================================================================
goto UNINSTALL_END

:UNINSTALL_FAIL
echo ========================================================================
echo [LOI] Khong the xoa tep mod.
echo Hay dam bao game Mark of the Deep dang TAT hoan toan truoc khi go bo.
echo ========================================================================
goto UNINSTALL_END

:UNINSTALL_END
echo.
pause
exit /b 0
