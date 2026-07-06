package kr.toxicity.hud.minimap

import kr.toxicity.hud.api.yaml.YamlObject
import kr.toxicity.hud.minimap.type.ShaderMinimap
import kr.toxicity.hud.resource.GlobalResource
import java.io.File

enum class MinimapType(
    val builder: (GlobalResource, File, String, YamlObject) -> MinimapImpl
) {
    SHADER({ resource, assets, id, section ->
        ShaderMinimap(resource, assets, id, section)
    })
}
