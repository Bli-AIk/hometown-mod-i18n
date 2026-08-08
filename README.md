# Hometown Pack (i18n)

Hometown（光世界）内容包的中文汉化 fork，fork 自
[`sekalisukarumah-boop/deltarune-AC`](https://github.com/sekalisukarumah-boop/deltarune-AC)
（AfterChill 游戏代码，BSD-3-Clause）。

包含 Hometown 光世界全地图（torielhouse / town / school / hospital 等）、暗世界
城堡区（`dark/castletown/...`）、演员与事件，并配套 **简体中文汉化**
（521 条字符串 + 13 个演员名，`lang/` 目录）。

## 安装

把整个目录放进 Kristal 引擎的 `mods/` 文件夹即可（或做成 mod ZIP）：

```bash
git clone --recurse-submodules git@github.com:Bli-AIk/hometown-pack-i18n.git
cp -r hometown-pack-i18n /path/to/kristal/mods/hometown_pack
```

## 开发

```bash
KRISTAL_ROOT=/path/to/kristal just run   # 用本地 Kristal 检出运行（支持 --encounter / --wave 等调试参数）
just test                                 # make test：静态断言 + luajit 语法检查 + 调试工具 dry-run
```

## 汉化

- `lang/en.json` + `lang/zh_hans.json`：521 条全量，键为运行时原文（含真实换行）；
  系统语言为中文时自动生效（`kristalI18n` 配置 `defaultLanguage: "auto"`）
- `lang/names.json`：13 个演员中文名
- 译文信源：[好人汉化组](https://github.com/gm3dr/DeltaruneChinese)
  （gm3dr/DeltaruneChinese 工作区文本，行宽按其标准 ≤19 字/行断行）；
  未命中语料的条目人工翻译并同样按 19 字/行断行，避免触发引擎自动换行
- 机制：`libraries/kristal-i18n`（内联补丁副本）在 `zh_hans` 下对
  `DialogueText/TextChoicebox/SpeechBubble` 等显示路径做原文查表，
  对话/商店/战斗文本零脚本改动自动翻译；`DialogueText` 另有 CJK 断行安全网
  （超长行按标点自动断行），兜底未覆盖文本

## 开发

需要 Git、LÖVE 11.5、`just`、LuaJIT。

```bash
just test            # make test：静态断言 + luajit 语法检查 + 调试工具 dry-run
just run             # 穿过父引擎启动（支持 --encounter / --wave 等调试参数）
just run --encounter # 直接进战斗
just build           # 独立 .love / Windows 包（固定 Kristal v0.10.0）
just build-mod       # 生产 mod ZIP（放入引擎 mods/ 使用）
```

## 许可

- 上游内容按 `LICENSE`（BSD-3-Clause，Copyright (c) 2021 SylviBlossom）
- 各库的署名与许可边界见 [`THIRD_PARTY.md`](THIRD_PARTY.md)
- DELTARUNE 为 Toby Fox 版权，本项目为粉丝重制，与 Toby Fox 无关
