# SVG to Icons Generator

Script para generar todos los iconos necesarios para tu web/PWA a partir de un solo archivo SVG.

## Iconos generados

| Archivo | Tamano | Uso |
|---------|--------|-----|
| `favicon.ico` | multi | Favicon clasico (16, 32, 48) |
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
| `android-chrome-512x512.png` | 512x512 | Android/PWA splash |
| `mstile-150x150.png` | 150x150 | Windows tiles |
| `browserconfig.xml` | - | Config Microsoft |

## Requisitos

- [Node.js](https://nodejs.org/) instalado

## Instalacion

```bash
npm install -g sharp-cli png-to-ico
```

## Estructura del proyecto

```
proyecto/
├── logo.svg                 # Tu logo en formato SVG
├── generate-icons.sh        # Script para Linux/Mac
├── generate-icons.bat       # Script para Windows
├── README.md
└── icons/                   # Carpeta de salida
    ├── favicon.ico
    ├── favicon-16x16.png
    ├── favicon-32x32.png
    ├── favicon-48x48.png
    ├── apple-touch-icon.png
    ├── apple-touch-icon-57x57.png
    ├── apple-touch-icon-60x60.png
    ├── apple-touch-icon-72x72.png
    ├── apple-touch-icon-76x76.png
    ├── apple-touch-icon-96x96.png
    ├── apple-touch-icon-114x114.png
    ├── apple-touch-icon-120x120.png
    ├── apple-touch-icon-144x144.png
    ├── apple-touch-icon-152x152.png
    ├── apple-touch-icon-180x180.png
    ├── android-chrome-192x192.png
    ├── android-chrome-512x512.png
    ├── mstile-150x150.png
    └── browserconfig.xml
```

## Uso

### Linux / Mac

```bash
# Dar permisos (solo la primera vez)
chmod +x generate-icons.sh

# Ejecutar
./generate-icons.sh
```

### Windows

```cmd
generate-icons.bat
```

## Integracion en HTML

Agrega estas lineas en el `<head>` de tu HTML:

```html
<!-- Favicon -->
<link rel="icon" href="/icons/favicon.ico" sizes="any">
<link rel="icon" type="image/png" sizes="16x16" href="/icons/favicon-16x16.png">
<link rel="icon" type="image/png" sizes="32x32" href="/icons/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="48x48" href="/icons/favicon-48x48.png">

<!-- Apple Touch Icons -->
<link rel="apple-touch-icon" href="/icons/apple-touch-icon.png">
<link rel="apple-touch-icon" sizes="57x57" href="/icons/apple-touch-icon-57x57.png">
<link rel="apple-touch-icon" sizes="60x60" href="/icons/apple-touch-icon-60x60.png">
<link rel="apple-touch-icon" sizes="72x72" href="/icons/apple-touch-icon-72x72.png">
<link rel="apple-touch-icon" sizes="76x76" href="/icons/apple-touch-icon-76x76.png">
<link rel="apple-touch-icon" sizes="96x96" href="/icons/apple-touch-icon-96x96.png">
<link rel="apple-touch-icon" sizes="114x114" href="/icons/apple-touch-icon-114x114.png">
<link rel="apple-touch-icon" sizes="120x120" href="/icons/apple-touch-icon-120x120.png">
<link rel="apple-touch-icon" sizes="144x144" href="/icons/apple-touch-icon-144x144.png">
<link rel="apple-touch-icon" sizes="152x152" href="/icons/apple-touch-icon-152x152.png">
<link rel="apple-touch-icon" sizes="180x180" href="/icons/apple-touch-icon-180x180.png">

<!-- Android/PWA -->
<link rel="icon" type="image/png" sizes="192x192" href="/icons/android-chrome-192x192.png">

<!-- Microsoft -->
<meta name="msapplication-TileImage" content="/icons/mstile-150x150.png">
<meta name="msapplication-TileColor" content="#ffffff">
<meta name="msapplication-config" content="/icons/browserconfig.xml">
```

## Manifest para PWA

Si usas PWA, agrega esto a tu `manifest.json`:

```json
{
  "icons": [
    {
      "src": "/icons/android-chrome-192x192.png",
      "sizes": "192x192",
      "type": "image/png"
    },
    {
      "src": "/icons/android-chrome-512x512.png",
      "sizes": "512x512",
      "type": "image/png"
    }
  ]
}
```

## Personalizacion

Puedes modificar los scripts para agregar mas tamanos o cambiar el color del tile en `browserconfig.xml`.

## Licencia

MIT
