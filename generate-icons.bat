@echo off
setlocal

REM ============================================================
REM  CONFIGURACION - Personaliza estos valores
REM ============================================================
set APP_NAME=Mi App
set APP_SHORT_NAME=App
set THEME_COLOR=#ffffff
set BG_COLOR=#ffffff
set OUTDIR=icons
REM ============================================================

REM Verificar dependencias
where sharp >nul 2>&1
if errorlevel 1 (
    echo Error: 'sharp' no esta instalado. Ejecuta: npm install -g sharp-cli
    exit /b 1
)
where png-to-ico >nul 2>&1
if errorlevel 1 (
    echo Error: 'png-to-ico' no esta instalado. Ejecuta: npm install -g png-to-ico
    exit /b 1
)

REM Detectar archivo logo automaticamente
if "%~1" neq "" (
    set INPUT=%~1
) else (
    if exist logo.svg (
        set INPUT=logo.svg
    ) else if exist logo.png (
        set INPUT=logo.png
    ) else if exist logo.jpg (
        set INPUT=logo.jpg
    ) else if exist logo.jpeg (
        set INPUT=logo.jpeg
    ) else (
        echo Error: No se encontro ningun archivo logo.^{svg,png,jpg,jpeg^}
        echo Uso: generate-icons.bat [archivo]
        exit /b 1
    )
)

if not exist %INPUT% (
    echo Error: El archivo '%INPUT%' no existe.
    exit /b 1
)

if not exist %OUTDIR% mkdir %OUTDIR%

echo Generando iconos desde %INPUT%...

REM Favicons PNG
call sharp -i %INPUT% -o %OUTDIR%/favicon-16x16.png resize 16 16
call sharp -i %INPUT% -o %OUTDIR%/favicon-32x32.png resize 32 32
call sharp -i %INPUT% -o %OUTDIR%/favicon-48x48.png resize 48 48

REM Apple Touch Icons
call sharp -i %INPUT% -o %OUTDIR%/apple-touch-icon.png resize 180 180
call sharp -i %INPUT% -o %OUTDIR%/apple-touch-icon-57x57.png resize 57 57
call sharp -i %INPUT% -o %OUTDIR%/apple-touch-icon-60x60.png resize 60 60
call sharp -i %INPUT% -o %OUTDIR%/apple-touch-icon-72x72.png resize 72 72
call sharp -i %INPUT% -o %OUTDIR%/apple-touch-icon-76x76.png resize 76 76
call sharp -i %INPUT% -o %OUTDIR%/apple-touch-icon-96x96.png resize 96 96
call sharp -i %INPUT% -o %OUTDIR%/apple-touch-icon-114x114.png resize 114 114
call sharp -i %INPUT% -o %OUTDIR%/apple-touch-icon-120x120.png resize 120 120
call sharp -i %INPUT% -o %OUTDIR%/apple-touch-icon-144x144.png resize 144 144
call sharp -i %INPUT% -o %OUTDIR%/apple-touch-icon-152x152.png resize 152 152
call sharp -i %INPUT% -o %OUTDIR%/apple-touch-icon-180x180.png resize 180 180

REM Android Chrome Icons
call sharp -i %INPUT% -o %OUTDIR%/android-chrome-192x192.png resize 192 192
call sharp -i %INPUT% -o %OUTDIR%/android-chrome-384x384.png resize 384 384
call sharp -i %INPUT% -o %OUTDIR%/android-chrome-512x512.png resize 512 512

REM Microsoft Tile
call sharp -i %INPUT% -o %OUTDIR%/mstile-150x150.png resize 150 150

REM Iconos Maskable (safe zone: contenido al 80%, padding 10%% por lado)
echo Generando iconos maskable...
call sharp -i %INPUT% -o %OUTDIR%/maskable-icon-192x192.png resize 154 154 --fit contain extend 19 19 19 19 --background "%BG_COLOR%"
call sharp -i %INPUT% -o %OUTDIR%/maskable-icon-512x512.png resize 410 410 --fit contain extend 51 51 51 51 --background "%BG_COLOR%"

REM Generar favicon.ico
echo Generando favicon.ico...
call png-to-ico %OUTDIR%/favicon-16x16.png %OUTDIR%/favicon-32x32.png %OUTDIR%/favicon-48x48.png > %OUTDIR%/favicon.ico

REM Generar browserconfig.xml
echo Generando browserconfig.xml...
(
    echo ^<?xml version="1.0" encoding="utf-8"?^>
    echo ^<browserconfig^>
    echo   ^<msapplication^>
    echo     ^<tile^>
    echo       ^<square150x150logo src="/icons/mstile-150x150.png"/^>
    echo       ^<TileColor^>%THEME_COLOR%^</TileColor^>
    echo     ^</tile^>
    echo   ^</msapplication^>
    echo ^</browserconfig^>
) > %OUTDIR%/browserconfig.xml

REM Generar manifest.json
echo Generando manifest.json...
powershell -NoProfile -Command ^
    "$icons = @(" ^
    "  @{src='/icons/android-chrome-192x192.png';sizes='192x192';type='image/png';purpose='any'}," ^
    "  @{src='/icons/android-chrome-384x384.png';sizes='384x384';type='image/png';purpose='any'}," ^
    "  @{src='/icons/android-chrome-512x512.png';sizes='512x512';type='image/png';purpose='any'}," ^
    "  @{src='/icons/maskable-icon-192x192.png';sizes='192x192';type='image/png';purpose='maskable'}," ^
    "  @{src='/icons/maskable-icon-512x512.png';sizes='512x512';type='image/png';purpose='maskable'}" ^
    ");" ^
    "$m = [ordered]@{" ^
    "  name='%APP_NAME%';" ^
    "  short_name='%APP_SHORT_NAME%';" ^
    "  start_url='/';" ^
    "  display='standalone';" ^
    "  theme_color='%THEME_COLOR%';" ^
    "  background_color='%BG_COLOR%';" ^
    "  icons=$icons" ^
    "};" ^
    "$m | ConvertTo-Json -Depth 3 | Set-Content -Encoding UTF8 '%OUTDIR%\manifest.json'"

echo.
echo [OK] Iconos generados en /%OUTDIR%
echo      Archivos adicionales: manifest.json, browserconfig.xml

endlocal
