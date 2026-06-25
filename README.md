# Meridian

Cinematic scroll-driven landing page — **Cinder Meridian Atelier**. A bronze sculpture on a black stage, editorial typography, and motion tied to scroll.

**Live:** [pipapaparapo2024.github.io/meridian](https://pipapaparapo2024.github.io/meridian/)

## Preview

Single-page experience: 360° camera orbit around a WebGL bronze horse, liquid-metal background shader (bronze → sapphire), forge sparks, per-letter title animations, and a stories-style scroll progress bar.

## Stack

- **HTML / CSS / JavaScript** — one file, no build step
- **Three.js** r0.160 (CDN via importmap)
- **Google Fonts** — Italiana, Outfit
- **Remote assets** — GLB model and editorial image from CDN

## Project structure

```
meridian/
  index.html          # entire site (markup, styles, WebGL logic)
.github/workflows/
  pages.yml           # GitHub Pages deploy from meridian/
```

## Local development

GitHub Pages needs HTTP (not `file://`) for ES modules and GLB loading.

```bash
cd meridian
npx serve -p 3456
```

Open [http://localhost:3456](http://localhost:3456)

## Deployment (GitHub Pages)

The site lives in `meridian/`, not the repo root. Publishing uses **GitHub Actions**:

1. Push to `main`
2. Workflow copies `meridian/` → Pages artifact
3. Repo **Settings → Pages → Source: GitHub Actions**

## Features

| Area | Details |
|------|---------|
| Scroll | 900vh page height; scroll drives camera, shader palette, slides |
| WebGL | Bronze horse GLB, chiaroscuro lighting, 450 additive spark particles |
| Shader | Full-screen liquid wave background on camera plane |
| UI | Fixed header, 4 editorial slides, 5-column grid, custom cursor |
| Motion | Lerp-smoothed scroll; per-character blur-up titles |
| Polish | Film grain overlay, nav active states, cursor hover ring, `prefers-reduced-motion`, focus-visible |

## License

Personal / portfolio project. Third-party assets (Three.js, fonts, remote GLB/PNG) remain under their respective licenses.
