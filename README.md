# SVG/PNG to Icons Generator

Script para generar todos los iconos necesarios para tu web/PWA a partir de un logo (SVG, PNG, JPG o JPEG).

## Iconos generados

| Archivo | Tamano | Uso |
|---------|--------|-----|
| `favicon.ico` | 16/32/48 | Favicon clasico multi-resolucion |
| `favicon-16x16.png` | 16x16 | Favicon navegador |
| `favicon-32x32.png` | 32x32 | Favicon navegador |
| `favicon-48x48.png` | 48x48 | Favicon navegador |
| `apple-touch-icon.png` | 180x180 | iOS home screen (default) |
| `apple-touch-icon-57x57.png` | 57x57 | iPhone sin Retina |
| `apple-touch-icon-60x60.png` | 60x60 | iPhone iOS 7+ |
| `apple-touch-icon-72x72.png` | 72x72 | iPad sin Retina |
| `apple-touch-icon-76x76.png` | 76x76 | iPad iOS 7+ |
| `apple-touch-icon-96x96.png` | 96x96 | Google TV |
| `apple-touch-icon-114x114.png` | 114x114 | iPhone Retina iOS 6 |
| `apple-touch-icon-120x120.png` | 120x120 | iPhone Retina iOS 7+ |
| `apple-touch-icon-144x144.png` | 144x144 | iPad Retina iOS 6 |
| `apple-touch-icon-152x152.png` | 152x152 | iPad Retina iOS 7+ |
| `apple-touch-icon-180x180.png` | 180x180 | iPhone 6 Plus |
| `android-chrome-192x192.png` | 192x192 | Android/PWA |
| `android-chrome-384x384.png` | 384x384 | Android/PWA |
| `android-chrome-512x512.png` | 512x512 | Android/PWA splash |
| `maskable-icon-192x192.png` | 192x192 | PWA maskable (safe zone 80%) |
| `maskable-icon-512x512.png` | 512x512 | PWA maskable (safe zone 80%) |
| `mstile-150x150.png` | 150x150 | Windows tiles |
| `browserconfig.xml` | - | Config Microsoft (auto-generado) |
| `manifest.json` | - | Web App Manifest PWA (auto-generado) |

## Requisitos

- [Node.js](https://nodejs.org/) instalado

## Instalacion

```bash
npm install -g sharp-cli png-to-ico
```

## Configuracion

Edita las variables al inicio de cada script antes de ejecutar:

```
APP_NAME      = Nombre completo de la app
APP_SHORT_NAME = Nombre corto (max ~12 caracteres)
THEME_COLOR   = Color del navegador/barra de estado (#ffffff)
BG_COLOR      = Color de fondo del splash screen (#ffffff)
```

## Estructura del proyecto

```
proyecto/
├── logo.png                 # Tu logo (svg, png, jpg o jpeg)
├── generate-icons.sh        # Script para Linux/Mac
├── generate-icons.bat       # Script para Windows
├── README.md
└── icons/                   # Carpeta de salida (auto-generada)
    ├── favicon.ico
    ├── favicon-16x16.png
    ├── favicon-32x32.png
    ├── favicon-48x48.png
    ├── apple-touch-icon.png
    ├── apple-touch-icon-*.png
    ├── android-chrome-192x192.png
    ├── android-chrome-384x384.png
    ├── android-chrome-512x512.png
    ├── maskable-icon-192x192.png
    ├── maskable-icon-512x512.png
    ├── mstile-150x150.png
    ├── browserconfig.xml
    └── manifest.json
```

## Uso

### Linux / Mac

```bash
# Dar permisos (solo la primera vez)
chmod +x generate-icons.sh

# Detecta logo.{svg,png,jpg,jpeg} automaticamente
./generate-icons.sh

# O especifica el archivo
./generate-icons.sh mi-logo.png
```

### Windows

```cmd
# Detecta logo.{svg,png,jpg,jpeg} automaticamente
generate-icons.bat

# O especifica el archivo
generate-icons.bat mi-logo.png
```

## Integracion en HTML

Agrega estas lineas en el `<head>` de tu HTML:

```html
<!-- Favicon -->
<link rel="icon" href="/icons/favicon.ico" sizes="any">
<link rel="icon" type="image/png" sizes="16x16" href="/icons/favicon-16x16.png">
<link rel="icon" type="image/png" sizes="32x32" href="/icons/favicon-32x32.png">

<!-- Apple Touch Icons -->
<link rel="apple-touch-icon" href="/icons/apple-touch-icon.png">
<link rel="apple-touch-icon" sizes="120x120" href="/icons/apple-touch-icon-120x120.png">
<link rel="apple-touch-icon" sizes="152x152" href="/icons/apple-touch-icon-152x152.png">
<link rel="apple-touch-icon" sizes="180x180" href="/icons/apple-touch-icon-180x180.png">

<!-- PWA Manifest -->
<link rel="manifest" href="/icons/manifest.json">

<!-- Android/PWA theme -->
<meta name="theme-color" content="#ffffff">

<!-- Microsoft -->
<meta name="msapplication-TileImage" content="/icons/mstile-150x150.png">
<meta name="msapplication-TileColor" content="#ffffff">
<meta name="msapplication-config" content="/icons/browserconfig.xml">
```

## manifest.json generado

El script genera automaticamente un `manifest.json` completo con iconos `any` y `maskable`:

```json
{
  "name": "Mi App",
  "short_name": "App",
  "start_url": "/",
  "display": "standalone",
  "theme_color": "#ffffff",
  "background_color": "#ffffff",
  "icons": [
    { "src": "/icons/android-chrome-192x192.png", "sizes": "192x192", "type": "image/png", "purpose": "any" },
    { "src": "/icons/android-chrome-384x384.png", "sizes": "384x384", "type": "image/png", "purpose": "any" },
    { "src": "/icons/android-chrome-512x512.png", "sizes": "512x512", "type": "image/png", "purpose": "any" },
    { "src": "/icons/maskable-icon-192x192.png",  "sizes": "192x192", "type": "image/png", "purpose": "maskable" },
    { "src": "/icons/maskable-icon-512x512.png",  "sizes": "512x512", "type": "image/png", "purpose": "maskable" }
  ]
}
```

> Los iconos **maskable** tienen un padding del 10% en cada lado para respetar el "safe zone"
> de launchers adaptativos en Android.

## Licencia

MIT
