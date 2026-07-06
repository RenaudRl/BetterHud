---
description: Perform a deep technical audit of any new feature or fix.
---

1. **Check Threads**: Scan new code for Bukkit Schedulers or `Thread.sleep`. Replace with `RegionScheduler`, `EntityScheduler`, or Kotlin Coroutines.
2. **Scan Locations/Entities**: Ensure all Location/Entity accesses are within the correct region context. Validate against `folia api.txt`.
3. **Audit Shaders**: If new colors/triggers are used, verify they match the `Text_Effects_Wiki.md` standards.
4. **MSPT-Zero Validation**: 
    - Review hot paths (`PlayerMoveEvent`, `HudUpdateTask`). 
    - Ensure zero-allocation (avoid `new`, use primitive collections).
    - Check for N+1 database queries or blocking I/O.
5. **Asset Check**: Ensure any new textures in `images/` have a corresponding `.yml` config (Sequence/Spritesheet).
6. **Diamond Quality**: Verify that the UI looks premium (Glassmorphism, vibrant colors, no placeholders).
7. **NMS Guard**: If NMS is used, verify it's the "Only Way" and properly abstracted/version-guarded.

