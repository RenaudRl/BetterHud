# BetterHud

![Java Version](https://img.shields.io/badge/Java-21-orange)
![Build Status](https://img.shields.io/badge/build-passing-brightgreen)
![Target](https://img.shields.io/badge/Target-Folia%20/%20Paper%20/%20BTC--CORE-blue)

**BetterHud** is a high-performance, strictly optimized fork of **toxicity188's BetterHud**, engineered specifically for the **BTC Studio** infrastructure. This fork drops support for legacy platforms (Spigot, Bukkit, older NMS) to provide native, blazingly fast integration with **Paper** and **Folia**.

> [!WARNING]
> **PLATFORM COMPATIBILITY NOTICE**
> This fork is **STRICTLY** for Paper 1.21.11+ and Folia 1.21.11+. Legacy compatibility layers have been removed to maximize performance. If you are not running modern Paper/Folia, this plugin **will not function**.

---

## 🚀 Key Features in Detail

### ⚡ Concurrency & Threading (Folia Native)
- **Native Folia Support**: Deeply integrated `PaperScheduler` ensures that all tasks (Global & Region-synced) are handled correctly using the region scheduler.
- **Zero-Overhead Logic**: Slashed unnecessary logic checks for non-Folia/non-Paper platforms, resulting in faster tick-to-task execution.

### 🛠️ Core Optimisations & Debloating
- **Java 21 Native**: Leveraging the latest JVM optimizations for maximum throughput and memory efficiency.
- **Legacy Cleanup**: Removed support for legacy NMS versions (1.17 - 1.21.10), Spigot-specific compatibility, and other platforms (Fabric/Velocity).
- **BTC Core Integration**: Native detection of BTC Core platform to enable specialized optimizations.

### 🌍 Deployment & Startup
- **Steamlined Loading**: Faster startup times through reduced library dependencies and compatibility checks.
- **Plug & Play**: Automatic threading context detection for both Paper and Folia environments.

---

## ⚙️ Configuration

BetterHud is optimized out-of-the-box, but stays configurable via `config.yml`.

### Key Settings
| Key | Default | Description |
|-----|---------|-------------|
| `metrics` | `true` | Enables/Disables bStats metrics. |
| `debug` | `false` | Enables debug mode for development. |
| `tick-speed` | `1` | Global tick speed for HUD updates. |
| `pack-type` | `zip` | Resource pack generation type (folder/zip/none). |
| `enable-self-host` | `false` | Enables built-in HTTP server for resource packs. |
| `disable-to-bedrock-player` | `true` | Disables HUD for Bedrock/Geyser players. |

---

## 🛠 Building & Deployment

Requires **Java 21**.

```bash
# Clean and compile the project
./gradlew clean build
```

---

## 🤝 Credits & Inspiration
This project is built upon the innovation of the broader Minecraft development community:
- **[BetterHud](https://github.com/toxicity188/BetterHud)** - The original project by toxicity188.

---

## 📜 License
- **Custom BTC-CORE Patches**: Proprietary to **BTC Studio**.
- **Upstream Source**: Original licenses apply to their respective components from BetterHud (MIT).

---
**Fork maintained by BTCSTUDIO**