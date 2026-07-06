---
description: Automatically bump the plugin version in build.gradle.kts.
---

1. **Locate Version**: Find `version = "..."` in `build.gradle.kts`.
2. **Determine Bump**: Default to `0.0.1` increment unless specified as `0.1.0`.
3. **Apply Change**: Update the file with the new version string.
4. **Sync README**: Ensure the latest version is mentioned in the `README.md` if applicable.
5. **Notify**: State the new version clearly in the results.
