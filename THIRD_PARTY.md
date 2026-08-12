# Third-party notices

## Mod content

- Forked from [`sekalisukarumah-boop/deltarune-AC`](https://github.com/sekalisukarumah-boop/deltarune-AC)
  (AfterChill fangame code, BSD-3-Clause, Copyright (c) 2021 SylviBlossom), keeping the
  Hometown Mod subtree. The upstream `LICENSE` file is
  retained at the repository root.
- Original pack lineage: `hometown_recreation` (distributed via the AfterChill Discord),
  weather-coupled version posted by fluffyboy [DR: AfterChill].
- The dark-world (`dark/castletown/...`) maps and extra face assets come from the
  full Discord release of the pack, which is a superset of the upstream subtree.

## Libraries

- `libraries/weatherlib` — [MrFukuo/WeatherLib](https://github.com/MrFukuo/WeatherLib)
  v1.1.0 by crocokuo. Bundled as a git submodule (pinned commit). **No LICENSE** in the
  upstream repository; referenced as a gitlink rather than vendored.
- `libraries/kristal-i18n` — [Bli-AIk/kristal-i18n](https://github.com/Bli-AIk/kristal-i18n)
  (MIT/Apache-2.0 dual). Vendored inline with a mod-specific extension
  (raw-string dictionary lookup in `localizeStaticTextValue`, gated to `zh_hans`);
  the extension is intentionally not upstreamed.
- `libraries/kristal-object-selector-plus`, `libraries/terminal-cli`, `libraries/kristal-debug-tools`,
  `libraries/virtualkeyboard`, `.emacs`, `.helix` — git submodules of
  [Bli-AIk](https://github.com/Bli-AIk) repositories (template dev toolchain,
  see [thrash-machine](https://github.com/Bli-AIk/thrash-machine)).

## IP notice

This mod is a fan recreation of the Hometown (light world) of
[DELTARUNE](https://deltarune.com/). DELTARUNE is the property of Toby Fox. This
project is not affiliated with or endorsed by Toby Fox.

## 翻译

简体中文译文以[好人汉化组](https://github.com/gm3dr/DeltaruneChinese)
（gm3dr/DeltaruneChinese）的 Deltarune 官方级汉化文本为信源，行宽按其排版标准处理。

sans 对话字体 `assets/fonts/sans.ttf`（方正少儿体，FZSJ-SHAOET）取自该仓库
`workspace/global/font/sans.ttf`，配置对齐其 `fonts.cfg` 的 `fnt_comicsans`
（`char_size` 14）；
方正字体为商业字体，仅按汉化用途随包分发，与上游项目一致。
