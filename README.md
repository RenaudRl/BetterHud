# BetterHud — BTC Fork

Fork de **[BetterHud](https://github.com/toxicity188/BetterHud)** (toxicity188), adapté au serveur **BornToCraft** — Paper / Folia **26.2** (Java 25).

## Nos ajouts / correctifs BTC
- **Détection BTC-CORE** via la classe d'API publique `com.infernalsuite.asp.api.BTCCoreAPI`.
- **Backoff MSPT du HUD** — sous forte charge, l'update du HUD est différé (jusqu'à 8 ticks) via la façade `dev.btc.core.api.BTCCoreAPI`. Dégradation gracieuse : aucun effet hors BTC-CORE.
- **Minimap GPU (shader)** auto-centrée via `CameraBlockPos` (zéro packet de position carte) + API de markers.
- **Core shaders intégrés** : chat bar remover, hide sidebar numbers, simplified glowing, wavy water, custom particles.

## Build
```bash
./gradlew :dist:build          # jar : dist/build/libs/dist-<version>.jar
```
Java 25 (Eclipse Adoptium) requis.

---
Base upstream : `toxicity188/BetterHud` · cible Minecraft **26.2**
