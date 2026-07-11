package kr.toxicity.hud.util

import java.lang.reflect.Method

/**
 * BTC-CORE performance integration hook (P10 — MSPT backoff).
 *
 * Resolves [dev.btc.core.api.BTCCoreAPI.getCurrentMspt] via reflection so that
 * BetterHud does not need a compile-time dependency on BTC-CORE. The lookup is
 * cached inside an immutable [ApRef] holder published through a `lazy` delegate,
 * so the hot path performs a single `val` read and a reflective invoke per call —
 * no allocation, no thread-blocking, Folia-safe.
 *
 * If BTC-CORE is unavailable the helpers degrade gracefully to "MSPT = 0", so
 * callers observe the original BetterHud behaviour exactly.
 */
object BtcMsptBackoff {

    /**
     * Immutable snapshot of the resolved BTCCoreAPI references. Published safely
     * behind a `by lazy` delegate (Kotlin's lazy defaults to `LazyThreadSafetyMode.SYNCHRONIZED`).
     */
    private data class ApiRef(
        val instance: Any?,
        val getCurrentMspt: Method?
    )

    private val api: ApiRef by lazy {
        runCatching {
            val apiClass = Class.forName("dev.btc.core.api.BTCCoreAPI")
            val instance = apiClass.getMethod("instance").invoke(null)
            val currentMspt = runCatching { apiClass.getMethod("getCurrentMspt") }.getOrNull()
            ApiRef(instance, currentMspt)
        }.getOrDefault(ApiRef(null, null))
    }

    /**
     * MSPT threshold (ms/tick) above which the HUD update task starts backing off.
     * A healthy 20-TickTPS server runs at <=50ms; we begin throttling before
     * crossing that line so we never amplify lag.
     */
    const val MSPT_THRESHOLD: Double = 40.0

    /**
     * Maximum number of timer ticks we will skip between two effective HUD
     * updates, even under severe server pressure. Keeps the HUD responsive.
     */
    const val MAX_SKIP: Int = 8

    /**
     * Returns the current server MSPT (millis per tick), or `0.0` when
     * BTCCoreAPI is unavailable or the lookup fails.
     */
    fun currentMspt(): Double {
        val ref = api
        val inst = ref.instance ?: return 0.0
        val method = ref.getCurrentMspt ?: return 0.0
        return runCatching {
            (method.invoke(inst) as? Number)?.toDouble() ?: 0.0
        }.getOrDefault(0.0)
    }

    /**
     * Number of timer ticks to skip between two effective HUD updates, sampled
     * against the latest MSPT reading from BTCCoreAPI. This implements a smooth,
     * lag-aware backoff:
     *
     *   skip = max(0, floor(mspt / MSPT_THRESHOLD) - 1) clamped to [0, MAX_SKIP]
     *
     * Returning `0` means "run now"; positive values delay the next update.
     * When BTCCoreAPI is unavailable `mspt` is `0.0`, so this returns `0` and
     * the original behaviour is preserved.
     */
    fun skipTicks(): Int {
        val mspt = currentMspt()
        if (mspt <= MSPT_THRESHOLD) return 0
        return ((mspt / MSPT_THRESHOLD).toInt() - 1).coerceIn(0, MAX_SKIP)
    }
}