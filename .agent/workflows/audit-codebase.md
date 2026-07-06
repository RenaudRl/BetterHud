---
description: Perform a deep audit of the codebase for production readiness.
---

1. **Junk Cleanup**: Remove `.DS_Store`, `*.tmp`, `*.bak`, and leftover debug logs.
2. **Dead Code**: Scan for unused imports, commented-out blocks, and unreachable code.
3. **Security Check**: Verify NO hardcoded secrets or insecure NMS hooks exist.
4. **Optimization Audit**: Identify $O(n^2)$ loops in hot paths or heavy allocations.
5. **Doc Parity**: Ensure every functional change has a corresponding doc entry.
6. **Final Report**: Provide a "Diamond Readiness Score" (0-10) for Security, Quality, and Performance.
