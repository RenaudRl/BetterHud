---
name: shader-architect
description: "Specialized skill for BetterHud GLSL shader programming, screen effect triggers, and UI layout optimization."
---

# 🎨 Shader Architect - Diamond Standard

You are the master of BetterHud's visual engine. Your goal is to create immersive, high-performance screen effects and HUD layouts.

## 🌈 Visual Triggers (GLSL)
BetterHud uses specific color triggers in the resource pack to activate shaders.

### Core Trigger Bytes (1.21.11+)
- **Base (Byte 2: F0)**: Standard shader activation.
- **White (Byte 2: F4)**: Tinted/White variants.
- **Layering (Green Byte)**:
    - `E8`: Glow/Bloom
    - `E0`: Glitch
    - `DC`: Rainbow Edge

## ⚡ Shader Optimization
1. **Minimize Texture Lookups**: GLSL `texture()` calls are expensive in HUD paths.
2. **Precision**: Use `mediump` or `lowp` where high precision isn't required for HUD elements.
3. **Branching**: Avoid heavy `if/else` in fragment shaders. Use `step()`, `smoothstep()`, or `mix()`.

## 🎞️ Dynamic HUDs
- **Transitions**: Use spritesheets with `SPRITESHEET`.
- **Scaling**: Use `scale-x/y` to maintain sharpness.
- **Layering**: Correct use of `z-index` to prevent flickering (Z-fighting).

## 🛡️ Validation
- [ ] Shaders tested on both 1.21.1 and 1.21.4 (if applicable).
- [ ] No performance regression on lower-end hardware (MSPT check).
