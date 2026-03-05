#!/bin/bash

# ============================================================
#  CONFIGURACION - Personaliza estos valores
# ============================================================
APP_NAME="Mi App"
APP_SHORT_NAME="App"
THEME_COLOR="#ffffff"
BG_COLOR="#ffffff"
OUTDIR="icons"
# ============================================================

# Verificar dependencias
check_deps() {
    for cmd in sharp png-to-ico; do
        if ! command -v "$cmd" &>/dev/null; then
            echo "Error: '$cmd' no esta instalado. Ejecuta: npm install -g sharp-cli png-to-ico"
            exit 1
        fi
    done
}

# Encontrar archivo logo
find_logo() {
    if [ -n "$1" ]; then
        [ -f "$1" ] && echo "$1" && return 0
        echo "Error: El archivo '$1' no existe." >&2
        return 1
    fi

    for ext in svg png jpg jpeg; do
        [ -f "logo.$ext" ] && echo "logo.$ext" && return 0
    done

    echo "Error: No se encontro ningun archivo logo.{svg,png,jpg,jpeg}" >&2
    return 1
}

# Validar extension del archivo
validate_extension() {
    local ext
    ext=$(echo "${1##*.}" | tr '[:upper:]' '[:lower:]')
    case "$ext" in
        svg|png|jpg|jpeg) return 0 ;;
        *) echo "Error: Extension '$ext' no soportada. Use svg, png, jpg o jpeg." >&2; return 1 ;;
    esac
}

check_deps
INPUT=$(find_logo "$1") || exit 1
validate_extension "$INPUT" || exit 1

mkdir -p "$OUTDIR"

echo "Generando iconos desde $INPUT..."

# Favicons PNG
sharp -i "$INPUT" -o "$OUTDIR/favicon-16x16.png" resize 16 16
sharp -i "$INPUT" -o "$OUTDIR/favicon-32x32.png" resize 32 32
sharp -i "$INPUT" -o "$OUTDIR/favicon-48x48.png" resize 48 48

# Apple Touch Icons
sharp -i "$INPUT" -o "$OUTDIR/apple-touch-icon.png" resize 180 180
sharp -i "$INPUT" -o "$OUTDIR/apple-touch-icon-57x57.png" resize 57 57
sharp -i "$INPUT" -o "$OUTDIR/apple-touch-icon-60x60.png" resize 60 60
sharp -i "$INPUT" -o "$OUTDIR/apple-touch-icon-72x72.png" resize 72 72
sharp -i "$INPUT" -o "$OUTDIR/apple-touch-icon-76x76.png" resize 76 76
sharp -i "$INPUT" -o "$OUTDIR/apple-touch-icon-96x96.png" resize 96 96
sharp -i "$INPUT" -o "$OUTDIR/apple-touch-icon-114x114.png" resize 114 114
sharp -i "$INPUT" -o "$OUTDIR/apple-touch-icon-120x120.png" resize 120 120
sharp -i "$INPUT" -o "$OUTDIR/apple-touch-icon-144x144.png" resize 144 144
sharp -i "$INPUT" -o "$OUTDIR/apple-touch-icon-152x152.png" resize 152 152
sharp -i "$INPUT" -o "$OUTDIR/apple-touch-icon-180x180.png" resize 180 180

# Android Chrome Icons
sharp -i "$INPUT" -o "$OUTDIR/android-chrome-192x192.png" resize 192 192
sharp -i "$INPUT" -o "$OUTDIR/android-chrome-384x384.png" resize 384 384
sharp -i "$INPUT" -o "$OUTDIR/android-chrome-512x512.png" resize 512 512

# Microsoft Tile
sharp -i "$INPUT" -o "$OUTDIR/mstile-150x150.png" resize 150 150

# Iconos Maskable (safe zone: contenido al 80%, padding 10% por lado)
echo "Generando iconos maskable..."
sharp -i "$INPUT" -o "$OUTDIR/maskable-icon-192x192.png" resize 154 154 --fit contain extend 19 19 19 19 --background "$BG_COLOR"
sharp -i "$INPUT" -o "$OUTDIR/maskable-icon-512x512.png" resize 410 410 --fit contain extend 51 51 51 51 --background "$BG_COLOR"

# Generar favicon.ico
echo "Generando favicon.ico..."
png-to-ico "$OUTDIR/favicon-16x16.png" "$OUTDIR/favicon-32x32.png" "$OUTDIR/favicon-48x48.png" > "$OUTDIR/favicon.ico"

# Generar browserconfig.xml
echo "Generando browserconfig.xml..."
cat > "$OUTDIR/browserconfig.xml" <<EOF
<?xml version="1.0" encoding="utf-8"?>
<browserconfig>
  <msapplication>
    <tile>
      <square150x150logo src="/icons/mstile-150x150.png"/>
      <TileColor>${THEME_COLOR}</TileColor>
    </tile>
  </msapplication>
</browserconfig>
EOF

# Generar manifest.json
echo "Generando manifest.json..."
cat > "$OUTDIR/manifest.json" <<EOF
{
  "name": "${APP_NAME}",
  "short_name": "${APP_SHORT_NAME}",
  "start_url": "/",
  "display": "standalone",
  "theme_color": "${THEME_COLOR}",
  "background_color": "${BG_COLOR}",
  "icons": [
    { "src": "/icons/android-chrome-192x192.png", "sizes": "192x192", "type": "image/png", "purpose": "any" },
    { "src": "/icons/android-chrome-384x384.png", "sizes": "384x384", "type": "image/png", "purpose": "any" },
    { "src": "/icons/android-chrome-512x512.png", "sizes": "512x512", "type": "image/png", "purpose": "any" },
    { "src": "/icons/maskable-icon-192x192.png",  "sizes": "192x192", "type": "image/png", "purpose": "maskable" },
    { "src": "/icons/maskable-icon-512x512.png",  "sizes": "512x512", "type": "image/png", "purpose": "maskable" }
  ]
}
EOF

echo ""
echo "✔ Iconos generados en /$OUTDIR"
echo "  Archivos adicionales: manifest.json, browserconfig.xml"
