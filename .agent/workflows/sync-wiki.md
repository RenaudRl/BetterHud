---
description: Synchronize documentation with existing HUD layouts and shader triggers.
---

1. **Scan Layouts**: List all folders in `layouts/` of BetterHud.
2. **Scan Shaders**: Find any new HEX color constants added to the `TextEFFECTS` shader file.
3. **Map Images**: Verify that every `SEQUENCE` or `SPRITESHEET` in `images/` is registered.
4. **Update Wikis**:
    - Update `Docs/ResourcePackWiki.md` for new layouts.
    - Update `Docs/Text_Effects_Wiki.md` for new RGB triggers.
    - Update `Docs/Animation_Wiki.md` if spritesheet frame-ticks changed.
5. **README Sync**: Ensure all new features or config nodes are reflected in `README.md`.
6. **Verify Links**: Ensure all new files are linked in the `README.md` or `Docs/`.

