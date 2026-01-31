#!/bin/bash

INPUT="logo.svg"
OUTDIR="icons"

mkdir -p $OUTDIR

echo "Generando iconos desde $INPUT..."

# Favicons PNG
sharp -i $INPUT -o $OUTDIR/favicon-16x16.png resize 16 16
sharp -i $INPUT -o $OUTDIR/favicon-32x32.png resize 32 32
sharp -i $INPUT -o $OUTDIR/favicon-48x48.png resize 48 48

# Apple Touch Icons (todos los tamaños)
sharp -i $INPUT -o $OUTDIR/apple-touch-icon.png resize 180 180
sharp -i $INPUT -o $OUTDIR/apple-touch-icon-57x57.png resize 57 57
sharp -i $INPUT -o $OUTDIR/apple-touch-icon-60x60.png resize 60 60
sharp -i $INPUT -o $OUTDIR/apple-touch-icon-72x72.png resize 72 72
sharp -i $INPUT -o $OUTDIR/apple-touch-icon-76x76.png resize 76 76
sharp -i $INPUT -o $OUTDIR/apple-touch-icon-96x96.png resize 96 96
sharp -i $INPUT -o $OUTDIR/apple-touch-icon-114x114.png resize 114 114
sharp -i $INPUT -o $OUTDIR/apple-touch-icon-120x120.png resize 120 120
sharp -i $INPUT -o $OUTDIR/apple-touch-icon-144x144.png resize 144 144
sharp -i $INPUT -o $OUTDIR/apple-touch-icon-152x152.png resize 152 152
sharp -i $INPUT -o $OUTDIR/apple-touch-icon-180x180.png resize 180 180

# Android Chrome Icons
sharp -i $INPUT -o $OUTDIR/android-chrome-192x192.png resize 192 192
sharp -i $INPUT -o $OUTDIR/android-chrome-512x512.png resize 512 512

# Microsoft Tile (para browserconfig.xml)
sharp -i $INPUT -o $OUTDIR/mstile-150x150.png resize 150 150

# Generar favicon.ico (requiere png-to-ico)
echo "Generando favicon.ico..."
png-to-ico $OUTDIR/favicon-16x16.png $OUTDIR/favicon-32x32.png $OUTDIR/favicon-48x48.png > $OUTDIR/favicon.ico

echo "✔ Iconos generados en /$OUTDIR"
