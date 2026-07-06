package kr.toxicity.hud.manager

import kr.toxicity.hud.api.manager.MinimapManager
import kr.toxicity.hud.api.minimap.Minimap
import kr.toxicity.hud.api.minimap.MinimapMarker
import kr.toxicity.hud.api.player.HudPlayer
import kr.toxicity.hud.api.plugin.ReloadInfo
import kr.toxicity.hud.minimap.MinimapImpl
import kr.toxicity.hud.minimap.MinimapType
import kr.toxicity.hud.resource.GlobalResource
import kr.toxicity.hud.util.DATA_FOLDER
import kr.toxicity.hud.util.forEachAllYaml
import kr.toxicity.hud.util.ifNull
import java.io.File
import java.util.*
import java.util.concurrent.ConcurrentHashMap

object MinimapManagerImpl : BetterHudManager, MinimapManager {

    override val managerName: String = "Minimap"
    override val supportExternalPacks: Boolean = false

    private val minimapMap = ConcurrentHashMap<String, MinimapImpl>()
    private val playerMarkers = ConcurrentHashMap<UUID, ConcurrentHashMap<String, MinimapMarker>>()

    override fun start() {
    }

    override fun getMinimap(name: String): Minimap? = minimapMap[name]
    override fun getAllNames(): Set<String> = Collections.unmodifiableSet(minimapMap.keys)
    override fun getAllMinimaps(): Set<Minimap> = Collections.unmodifiableSet(minimapMap.values.toSet())

    override fun addMarker(player: HudPlayer, markerId: String, marker: MinimapMarker) {
        playerMarkers.computeIfAbsent(player.uuid()) { ConcurrentHashMap() }[markerId] = marker
    }

    override fun removeMarker(player: HudPlayer, markerId: String) {
        playerMarkers[player.uuid()]?.remove(markerId)
    }

    override fun clearMarkers(player: HudPlayer) {
        playerMarkers.remove(player.uuid())
    }

    override fun getMarkers(player: HudPlayer): Map<String, MinimapMarker> {
        return Collections.unmodifiableMap(playerMarkers[player.uuid()] ?: emptyMap())
    }

    override fun reload(workingDirectory: File, info: ReloadInfo, resource: GlobalResource) {
        minimapMap.clear()
        
        val folder = File(DATA_FOLDER, "minimaps")
        if (!folder.exists()) folder.mkdirs()

        folder.forEachAllYaml(info.sender) { file, s, yamlObject ->
            runCatching {
                minimapMap[s] = MinimapType.valueOf(
                    yamlObject.getString("type", "SHADER").uppercase()
                ).builder(resource, folder, s, yamlObject)
            }.onFailure { e ->
                info.sender.warn("Unable to load minimap $s in ${file.name}")
                info.sender.warn(e.message ?: e.javaClass.name)
            }
        }
    }

    override fun end() {
        minimapMap.clear()
        playerMarkers.clear()
    }
}
