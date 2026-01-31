@echo off
setlocal

set INPUT=logo.svg
set OUTDIR=icons

if not exist %OUTDIR% mkdir %OUTDIR%

echo Generando iconos desde %INPUT%...

REM Favicons PNG
call sharp -i %INPUT% -o %OUTDIR%/favicon-16x16.png resize 16 16
call sharp -i %INPUT% -o %OUTDIR%/favicon-32x32.png resize 32 32
call sharp -i %INPUT% -o %OUTDIR%/favicon-48x48.png resize 48 48

REM Apple Touch Icons (todos los tamanos)
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
call sharp -i %INPUT% -o %OUTDIR%/android-chrome-512x512.png resize 512 512

REM Microsoft Tile
call sharp -i %INPUT% -o %OUTDIR%/mstile-150x150.png resize 150 150

REM Generar favicon.ico
echo Generando favicon.ico...
call png-to-ico %OUTDIR%/favicon-16x16.png %OUTDIR%/favicon-32x32.png %OUTDIR%/favicon-48x48.png > %OUTDIR%/favicon.ico

echo.
echo [OK] Iconos generados en /%OUTDIR%

endlocal
