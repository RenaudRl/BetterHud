<div align="center">  

![-0001-export](https://github.com/toxicity188/BetterHud/assets/114675706/ccbf4bd3-9133-44ee-b277-985eae4349ae)

Welcome to BetterHud (BTC Studio Fork)!

[Github](https://github.com/BTC-Studio/BetterHud)

[![GitHub Release](https://img.shields.io/github/v/release/toxicity188/BetterHud?display_name=release&style=for-the-badge&logo=kotlin)](https://github.com/BTC-Studio/BetterHud/releases)
[![Discord](https://img.shields.io/badge/Discord-%235865F2.svg?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/btc-studio)

</div>

### Multiplatform server-side HUD implementation of Minecraft
This is the **BTC Studio** fork of BetterHud. It implements a server-side HUD with extensive shader optimizations and exclusive RPG features for the BTC ecosystem.

### BTC Studio Exclusive Features
- **GPU-Accelerated Minimap**: A true shader-based minimap that auto-centers via `CameraBlockPos`, completely eliminating server-to-client map position packets. Includes API support for dynamic markers.
- **Integrated Core Shaders**:
  - **Chat Bar Remover**: Removes the vanilla grey/blue chat backgrounds.
  - **Hide Sidebar Numbers**: Removes the red numbers from scoreboards.
  - **Simplified Glowing**: Optimizes the entity glowing outline pipeline.
  - **Wavy Water**: Applies subtle vertex displacement to water blocks.
  - **Custom Particles**: Fixes and enhances particle rendering.
- **BTC-Core Support**: Deep integration with BTC-Core and Typewriter for dynamic quest and dialogue HUD elements.

### Platform
- Bukkit/Paper (with Folia) 1.21.4 (Minecraft 26.2)
- Note: This fork strictly targets Paper 1.21.4+. Older versions and proxies are not supported in this fork.

### Build
Requires Java 25 Eclipse Adoptium.

- Build all available jar: `./gradlew build`
- Build Bukkit plugin: `./gradlew pluginJar`
- Build source code jar: `./gradlew sourcesJar`

### API (BTC Fork)
``` kotlin
repositories {
    mavenLocal() // Or your private maven repo
}

dependencies {
    compileOnly("io.github.toxicity188:BetterHud-bukkit-api:VERSION") //Bukkit api
}
```

### Minimap Usage
To use the minimap, place your base texture at `minimaps/<id>.png` and register it in `minimaps/<id>.yml` with `type: SHADER`.
Markers can be dynamically added via the API:
```java
BetterHud.getInstance().getMinimapManager().addMarker(player, "spawn", MinimapMarker.builder(0, 0).type(MarkerType.SPAWN).build());
```