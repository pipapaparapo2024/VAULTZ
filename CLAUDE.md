# Claude Code — Site Workspace

## Структура проекта

Этот workspace — контейнер для нескольких сайтов. Каждый сайт живёт в своей папке.

**Правило папок:**
- Клон сайта → `<project-name>/` (`kebab-case`, латиница)
- Все ассеты — **локально в проекте**, структура `assets/` повторяет оригинал

**Текущие проекты:**

| Папка | Описание |
|-------|----------|
| `meridian/` | Cinder Meridian — cinematic WebGL landing |
| `lumora/` | Lumora — design studio landing (Lenis, liquid hero reveal) |
| `3dsvg/` | VectoLift — SVG → 3D editor (Three.js) |
| `kael/` | KAEL — creative studio, multi-section, infinite marquee |
| `aevos/` | Прямой клон abhishekjha.me — оригинальный JS/CSS бандл, все ассеты локально |

---

## ПРАВИЛО №1 — ПРЯМОЕ КОПИРОВАНИЕ (главный метод)

**Клонировать сайт = скачать оригинальный код, а не писать похожий с нуля.**

### Порядок действий при клонировании:

#### Шаг 1 — Анализ через Chrome MCP
```
1. Открыть сайт в Chrome MCP
2. Подождать полной загрузки (5–8 секунд)
3. Сделать скриншоты всех секций (прокрутить через window.scrollTo)
4. Получить список всех ассетов:
   document.querySelectorAll('img,video,source').map(el=>el.src||el.dataset.src)
5. Получить список CSS и JS файлов:
   Array.from(document.styleSheets).map(s=>s.href)
   Array.from(document.scripts).map(s=>s.src)
6. Получить HTML структуру:
   document.getElementById('smooth-wrapper')?.innerHTML (или body.innerHTML)
```

#### Шаг 2 — Скачать исходный HTML
```powershell
$html = Invoke-WebRequest "https://example.com/" -UseBasicParsing
$html.Content | Out-File "project/source.html" -Encoding utf8
```

#### Шаг 3 — Скачать CSS и JS бандлы
```powershell
# CSS
$css = Invoke-WebRequest "https://example.com/assets/main-XXXX.css" -UseBasicParsing
$css.Content | Out-File "project/assets/main-XXXX.css" -Encoding utf8

# JS (может быть 500KB–2MB)
$js = Invoke-WebRequest "https://example.com/assets/main-XXXX.js" -UseBasicParsing
$js.Content | Out-File "project/assets/main-XXXX.js" -Encoding utf8
```

#### Шаг 4 — Скачать ВСЕ ассеты массово
```powershell
$wc = New-Object System.Net.WebClient
foreach ($url in $assetUrls) {
  $local = "project/" + ($url -replace "https://example.com/", "")
  $wc.DownloadFile($url, $local)
}
```
Скачивать: изображения, шрифты, видео, GLB/GLTF, HDR-карты, SVG, GIF, WebP, аудио, Lottie JSON.

#### Шаг 5 — Создать index.html с локальными путями
- Взять оригинальный HTML (source.html)
- Заменить все `https://example.com/` → `./`
- Убрать `crossorigin` с `<link>` и `<script>` тегов (блокирует на localhost)
- Убрать трекеры (Google Analytics, Cloudflare beacon)
- Заменить email-обфускацию Cloudflare на реальные email

#### Шаг 6 — Патч JS бандла от защиты домена
Многие сайты используют **Fortify** или аналогичные модули защиты от копирования:
```powershell
# Найти защиту
grep -o ".\{100\}blankOnViolation.\{100\}" "assets/main-XXXX.js"

# Нейтрализовать — сделать функцию возвращаться сразу
$content = $content.Replace(
  'function(t={}){if(window.__FORTIFY_INSTALLED__)return;const e=[]',
  'function(t={}){window.__FORTIFY_INSTALLED__=!0;return;const e=[]'
)

# ИЛИ отключить все флаги защиты
$content = $content -replace 'blankOnViolation:!0', 'blankOnViolation:!1'
$content = $content -replace 'addHiddenCSSWatermark:!0', 'addHiddenCSSWatermark:!1'
$content = $content -replace 'addDOMWatermark:!0', 'addDOMWatermark:!1'
$content = $content -replace 'tripwire:!0', 'tripwire:!1'
```

#### Шаг 7 — Проверить и скачать недостающие ассеты
После первого запуска проверить консоль на 404:
```
preview_network → filter: failed
```
Скачать все недостающие файлы. Типичные пропуски:
- GLB/GLTF модели (`Flower2.glb`, `scene.gltf + scene.bin`)
- HDR среды (`pretoria_gardens_1k.hdr`)
- Видеофайлы (`video.mp4`, `flower.mp4`)
- Анимированные SVG (`motif-anim.svg`)
- Шрифты нестандартные (PPPlayground, PPEditorial, Product)

#### Шаг 8 — Перезапустить сервер после каждого патча
```
preview_stop → preview_start
```
CSS и JS кешируются, без перезапуска изменения не применятся.

---

## ПРАВИЛО №2 — Структура папки клона

Папка клона должна полностью зеркалить оригинальный сайт:
```
project/
  index.html          ← отредактированный source.html
  loader.css          ← если есть отдельный CSS для лоадера
  assets/
    main-XXXX.css     ← оригинальный CSS (патченный)
    main-XXXX.js      ← оригинальный JS бандл (патченный)
    modulepreload-*.js
    favicon.svg
    fonts/
      Thunder-BlackLC.ttf
      PPPlayground-Medium.otf
      ...
    images/
      loader/         ← структура точно как на оригинале
      banner/
      about/
      works/
      footer/
      ...
```

**Почему повторять структуру оригинала?**
Потому что JS бандл содержит хардкоженные пути вида `./assets/images/banner/Flower2.glb`.
Если структура папок отличается — 3D объекты, текстуры, HDR не загрузятся.

---

## ПРАВИЛО №3 — Диагностика проблем

| Симптом | Причина | Решение |
|---------|---------|---------|
| Страница пустая/белая | Fortify очищает `documentElement.innerHTML` | Патч JS бандла |
| CSS не загружается | `crossorigin` на `<link>` блокирует на localhost | Убрать `crossorigin` |
| Стили `all: unset !important` | `addHiddenCSSWatermark` активен | Отключить флаг в JS |
| 3D объект не появляется | Не скачан .glb/.gltf файл | Скачать модель |
| Лоадер не завершается | JS не находит нужные элементы/ассеты | Проверить 404 в network |
| `document.styleSheets = []` | Fortify удаляет `<link>` теги из `<head>` | Нейтрализовать Fortify полностью |
| Видео не играет | .mp4 не скачан (большой файл) | Скачать или использовать poster |

---

## АНАЛИЗ ПОСЛЕ КЛОНИРОВАНИЯ — обязательный шаг

После успешного клона **всегда проводить анализ модификации** по следующему чеклисту:

### A) Текст
- [ ] Найти весь текст в `index.html` (innerText всех видимых элементов)
- [ ] Определить язык интерфейса оригинала
- [ ] Оценить: все ли тексты в HTML (хардкод) или генерируются JS?
- [ ] Если тексты в HTML — замена тривиальна (Edit tool)
- [ ] Если тексты генерируются JS бандлом — искать строки в бандле
- [ ] Вердикт: ✅ легко / ⚠️ сложно / ❌ невозможно без ребилда

### B) Шрифты
- [ ] Определить все шрифты (CSS `@font-face` + Google Fonts)
- [ ] Проприетарные шрифты (PP, Klim, Söhne) — заменимы на похожие бесплатные
- [ ] Google Fonts — свободно заменяются
- [ ] Вердикт: назвать конкретные замены

### C) Цвета / палитра
- [ ] Найти CSS переменные (`--color-*`) или хардкод hex в CSS
- [ ] Если CSS переменные — замена одной строкой
- [ ] Если хардкод — потребуется поиск+замена по всему CSS

### D) Изображения
- [ ] Перечислить все картинки по секциям
- [ ] Оценить формат замены: `.webp` требует конвертации, `.png/.jpg` — напрямую
- [ ] Фотографии в `<img>` — легко заменяются
- [ ] Текстуры для 3D (.hdr, .exr) — заменяются на другие HDR
- [ ] Плакаты видео (poster) — заменяются

### E) 3D объекты и WebGL
- [ ] Определить формат модели (`.glb` / `.gltf` / `OBJ` / Three.js процедурный)
- [ ] `.glb` — можно заменить на любую другую .glb модель с сайта Sketchfab/GitHub
- [ ] Проверить: модель анимирована или статичная?
- [ ] Проверить: есть ли кастомный шейдер (замена модели без замены шейдера даст другой вид)
- [ ] Вердикт: ✅ заменяемо (дать ссылки на источники GLB) / ⚠️ частично

### F) Видео
- [ ] Перечислить все видеофайлы
- [ ] Размер (MB) — влияет на скорость загрузки
- [ ] Можно заменить на любое .mp4 нужного формата

### G) SVG иконки и декор
- [ ] Перечислить SVG файлы
- [ ] Анимированные SVG (`motif-anim.svg`) — требуют осторожности
- [ ] Статичные SVG — легко заменяются

---

## Локальный запуск

```powershell
npx serve -p 3458 aevos   # статичный сервер
```

Всегда HTTP, не `file://` — нужен для ES modules, GLB, HDR.

---

## GitHub Pages — деплой

Деплой через **ветку `gh-pages`**:
```powershell
npx gh-pages -d aevos
```
Settings → Pages → gh-pages / root

---

## Кастомные команды

| Команда | Назначение |
|---------|------------|
| `/clone-website` | Прямое копирование сайта (JS+CSS+ассеты с оригинала) |
| `/rebrand-website` | Смена текста, цветов, изображений в клоне |
| `/premium-frontend` | Визуальная полировка нового сайта |
| `/agent-orchestration` | Каталог инструментов для multi-agent workflow |

---

## Источники ассетов — для автономного поиска

Claude может самостоятельно открывать эти сайты через Chrome MCP, выбирать подходящие файлы по контексту и скачивать их через PowerShell WebClient.

### 3D модели (GLB/GLTF)

| Сайт | URL | Авторизация | Примечание |
|------|-----|-------------|------------|
| Meshy.ai | https://www.meshy.ai/ru/tags/glb | ❌ не нужна | AI-генерация + ready GLB |
| Hi3D.ai | https://www.hi3d.ai/explore | ❌ не нужна | AI Image→3D, большой каталог |
| Poly Pizza | https://poly.pizza | ❌ не нужна | Бесплатные lowpoly GLB |
| KhronosGroup Samples | https://github.com/KhronosGroup/glTF-Sample-Models | ❌ не нужна | Официальные тестовые модели |
| Sketchfab | https://sketchfab.com/models?features=downloadable | ✅ нужен | Большой каталог, скачать через кнопку Download |

**Ограничения Chrome MCP:** Большинство 3D-сайтов (Meshy.ai, Hi3D.ai, Sketchfab, Poly Pizza, Coverr, Pexels) заблокированы для навигации через Chrome MCP. Скачивание GLB с этих сайтов нужно делать вручную в браузере, затем пользователь передаёт файл через `@путь` или перетаскивает в папку.

**После получения GLB от пользователя:**
- Файл попадает в `aevos/assets/images/banner/` под оригинальным именем
- Переименовать в нужное: `Rename-Item "старое.glb" "Flower2.glb" -Force`
- JS бандл ищет файл строго по имени из своего кода (`Flower2.glb`)

**Как скачать GLB если прямая ссылка известна:**
```powershell
$wc = New-Object System.Net.WebClient
$wc.DownloadFile("https://example.com/model.glb", "assets/images/banner/Flower2.glb")
```

### Фотографии

| Сайт | URL | Формат | Авторизация |
|------|-----|--------|-------------|
| Pexels | https://www.pexels.com | JPG/WebP | ❌ не нужна |
| Unsplash | https://unsplash.com | JPG | ❌ не нужна |
| Pixabay | https://pixabay.com | JPG/WebP | ❌ не нужна |

**Как скачать с Pexels:** Открыть поиск, найти нужное фото, получить прямую ссылку через `document.querySelector('.photo-item__img').src` и скачать. Pexels даёт прямые `.jpg` URL без авторизации.

### Видео (MP4 для фоновых секций)

| Сайт | URL | Формат | Авторизация |
|------|-----|--------|-------------|
| Pexels Videos | https://www.pexels.com/videos/ | MP4 | ❌ не нужна |
| Coverr | https://coverr.co | MP4 | ❌ не нужна |
| Mixkit | https://mixkit.co/free-stock-video/ | MP4 | ❌ не нужна |

**Стратегия выбора видео:** смотреть на контекст секции (hero, philosophy, works) и подбирать ambient/cinematic видео. Для hero — абстрактные движения, свет. Для секций природы — листья, вода, туман.

### HDR среды (для Three.js / WebGL)

| Сайт | URL | Формат | Примечание |
|------|-----|--------|------------|
| Poly Haven | https://polyhaven.com/hdris | HDR/EXR | Бесплатно, 1K/2K/4K |

**Как скачать:** Открыть страницу нужного HDR, скачать в 1K для скорости.

### Иконки

| Сайт | URL | Формат | Примечание |
|------|-----|--------|------------|
| Icons Club | https://iconsclub.xyz | SVG | Большая коллекция иконок |

### Шрифты

| Сайт | URL | Примечание |
|------|-----|------------|
| Google Fonts | https://fonts.google.com | Прямые CDN ссылки или скачать TTF |
| Fontsource | https://fontsource.org | NPM или прямые файлы |

---

## Агенты и инструменты

- [ruflo](https://github.com/ruvnet/ruflo) — рой агентов
- [claude-squad](https://github.com/smtg-ai/claude-squad) — параллельные агенты в tmux
- [ccusage](https://github.com/ccusage/ccusage) — мониторинг usage
