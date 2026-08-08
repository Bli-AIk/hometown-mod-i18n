# Hometown Pack (i18n)

[![license](https://img.shields.io/badge/license-BSD--3--Clause-blue)](LICENSE)
<br>
<img src="https://img.shields.io/badge/Lua-2C2D72?style=for-the-badge&logo=lua&logoColor=white" />
<img src="https://img.shields.io/badge/Kristal-FF6B35?style=for-the-badge&logo=love2d&logoColor=white" />

**Hometown Pack（i18n）** — Hometown（光世界）内容包的简体中文汉化 fork，内置
[kristal-i18n](https://github.com/Bli-AIk/kristal-i18n) 多语言本地化库。

| 简体中文 | English |
|---------|---------|
| 简体中文 | [English](./README_en.md) |

## 这是什么

基于 AfterChill 的 [`sekalisukarumah-boop/deltarune-AC`](https://github.com/sekalisukarumah-boop/deltarune-AC)
（BSD-3-Clause）中 `hometown_pack` 子树的中文汉化 fork：

- 完整 Hometown 光世界（torielhouse / town / school / hospital / 图书馆 / 便利店…）+ 暗世界城堡区（`dark/castletown/...`）
- 内置 **kristal-i18n**（MIT/Apache-2.0，[Bli-AIk/kristal-i18n](https://github.com/Bli-AIk/kristal-i18n)）—— Kristal 的多语言本地化库，游戏内可切换 `en` / `zh_hans`
- 资源使用与 kristal-i18n README 所述一致（译文信源：[好人汉化组](https://github.com/gm3dr/DeltaruneChinese) gm3dr/DeltaruneChinese 工作区）

## 做了多少汉化

| 内容 | 数量 | 说明 |
|---|---|---|
| 对话/物品/界面字符串 | **550 条** | `lang/zh_hans.json`，键为运行时原文；行宽按好人组标准 ≤19 字/行 |
| 角色名 | **24 个** | `lang/names.json`，含全名（鲁道夫"鲁迪"假日、艾斯戈尔·逐梦、诺艾尔…），经 `[name:xxx]` 引用 |
| 地图贴图变体 | **20 张** | `assets/sprites/lang/zh_hans/`，招牌/建筑中文贴图（sansstore、医院、学校、Librarby、冰E披萨…） |
| sans 中文字体 | 1 组 | 方正卡通简体（27/24），sans 对话专用 |

**机制**（kristal-i18n）：
- **原文查表**：`zh_hans` 下对 `DialogueText/TextChoicebox/SpeechBubble` 等显示路径做原文→译文查找，对话/商店/战斗文本零脚本改动自动翻译
- **CJK 断行安全网**：超长行按标点自动断行（兜底未覆盖文本）
- **人名引用**：`[name:kris]` 等经 names.json 解析，可配置 `defaultNameLanguage` 独立显示中/英文名
- **贴图/字体语言变体**：`lang/zh_hans/<id>` 约定路径，语言切换即时生效
- **语言切换**：游戏内设置菜单或 F7（`Game:setLanguage("zh_hans")`）

## 安装

把整个目录放进 Kristal 引擎的 `mods/` 文件夹（或做成 mod ZIP）：

```bash
git clone --recurse-submodules git@github.com:Bli-AIk/hometown-pack-i18n.git
cp -r hometown-pack-i18n /path/to/kristal/mods/hometown_pack
```

## 开发

需要 Git、LÖVE 11.5、`just`、LuaJIT。

```bash
just run             # 用本地 Kristal 检出运行（支持 --encounter / --wave 等调试参数）
just install-stock   # 同步到 $KRISTAL_ROOT/mods/（LÖVE 不跟随符号链接）
just test            # make test：静态断言 + luajit 语法检查 + 调试工具 dry-run
```

## 设置家乡镇地图的天气与时间

### 时间（昼夜）

flag `hometown_time`，取值 `day` / `sunset` / `night` / `sunrise`：

```lua
Game:setFlag("hometown_time", "night")     -- 夜晚：夜晚调色板 + 暗幕 + 夜间物件
Game:setFlag("hometown_time", "sunset")    -- 黄昏
Game:setFlag("hometown_time", "day")       -- 白天
```

- 控制器 `scripts/world/controllers/hometowndaynight.lua`：根据 flag 应用
  `BGPaletteFX` 调色板、夜晚暗幕（`HometownNightOverlay`），并按 `day_mode`/
  `night_mode` 隐藏/显示对应物件
- 地图对象属性 `day` / `night` / `sunset` / `sunrise` / `rain`（`true`/`false`）：
  对应时段/天气下该对象才出现（由 `Mod:loadObject` 处理）
- 音乐随时段切换（`Mod:onMapMusic`：town_day / town / forecasted_hometown_night…）

### 天气（weatherlib）

依赖 [MrFukuo/WeatherLib](https://github.com/MrFukuo/WeatherLib)（子模块）：

```lua
Game.stage:setWeather("rain")      -- 下雨
Game.stage:hasWeather("rain")      -- 判断当前天气
Game.stage:setWeather()            -- 清空（晴天）
```

- 天气类型：`rain` / `heavy_rain` / `thunder` / `snow` / `leaf` / `dust` / `fog` / `flipped_rain` / `volcanic` / `hot`
- 与天气联动的系统：`beachwater`（雨时水位上涨）、`leaves` 边框（雨幕叠加层）、
  `Interactable`（`rain_text` 雨天交互文本）、`town_mid` 物件显隐条件
- 进阶：`setWeatherParent` / `setWeatherLayer` / `resetWeather` / `WeatherRegistry`

## 许可

- 上游内容按 `LICENSE`（BSD-3-Clause，Copyright (c) 2021 SylviBlossom）
- kristal-i18n：MIT/Apache-2.0（[Bli-AIk/kristal-i18n](https://github.com/Bli-AIk/kristal-i18n)）
- 各库署名与许可边界见 [`THIRD_PARTY.md`](THIRD_PARTY.md)
- DELTARUNE 为 Toby Fox 版权，本项目为粉丝重制，与 Toby Fox 无关
