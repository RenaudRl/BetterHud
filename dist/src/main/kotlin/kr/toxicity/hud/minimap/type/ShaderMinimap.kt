package kr.toxicity.hud.minimap.type

import kr.toxicity.hud.api.component.WidthComponent
import kr.toxicity.hud.api.configuration.HudComponentSupplier
import kr.toxicity.hud.api.configuration.HudObjectType
import kr.toxicity.hud.api.minimap.Minimap
import kr.toxicity.hud.api.player.HudPlayer
import kr.toxicity.hud.api.update.UpdateEvent
import kr.toxicity.hud.api.yaml.YamlObject
import kr.toxicity.hud.location.PixelLocation
import kr.toxicity.hud.manager.ConfigManagerImpl
import kr.toxicity.hud.manager.EncodeManager
import kr.toxicity.hud.minimap.MinimapImpl
import kr.toxicity.hud.pack.PackGenerator
import kr.toxicity.hud.placeholder.PlaceholderSource
import kr.toxicity.hud.resource.GlobalResource
import kr.toxicity.hud.shader.HudShader
import kr.toxicity.hud.shader.RenderScale
import kr.toxicity.hud.shader.ShaderProperty
import kr.toxicity.hud.util.*
import net.kyori.adventure.text.Component
import java.io.File
import com.google.gson.JsonArray

class ShaderMinimap(
    resource: GlobalResource,
    assets: File,
    override val id: String,
    section: YamlObject
) : MinimapImpl, PlaceholderSource by PlaceholderSource.Impl(section) {

    private val encode = "minimap_$id".encodeKey(EncodeManager.EncodeNamespace.FONT)
    private val key = createAdventureKey(encode)
    private val tick = section.getAsLong("tick", 1)
    private val isDefault = ConfigManagerImpl.defaultMinimap.contains(id) || section.getAsBoolean("default", false)

    private val pixel = PixelLocation(section["pixel"]?.asObject().ifNull { "pixel value not set." }) + PixelLocation.hotBarHeight
    private val shader = HudShader(
        kr.toxicity.hud.location.GuiLocation(section["gui"]?.asObject().ifNull { "gui value not set." }),
        RenderScale.fromConfig(pixel, section),
        section.getAsInt("layer", 0),
        section.getShadow("outline"),
        pixel.opacity,
        ShaderProperty.properties(section["properties"]?.asArray())
    )
    private val conditions = section.toConditions(this) build UpdateEvent.EMPTY

    private var center = 0xC0000
    private var array: JsonArray? = JsonArray()

    init {
        // Read the base texture
        val textureFile = File(assets, "minimaps/$id.png")
        if (textureFile.exists()) {
            val image = textureFile.toImage()
            val size = image.width // Assume square

            // Register texture in the pack
            resource.let {
                PackGenerator.addTask(it.textures + "minimap_${id}.png") {
                    image.toByteArray()
                }
            }

            // Register font glyph
            val c = center++.parseChar()
            array?.let { arr ->
                createAscent(shader, pixel.y) { bit ->
                    arr += jsonObjectOf(
                        "type" to "bitmap",
                        "file" to "$NAME_SPACE_ENCODED:minimap_${id}.png",
                        "ascent" to bit,
                        "height" to size,
                        "chars" to jsonArrayOf(c)
                    )
                }
            }
            array?.let {
                PackGenerator.addTask(resource.font + "$encode.json") {
                    jsonObjectOf("providers" to it).toByteArray()
                }
            }
        }
    }

    override fun tick(): Long = tick
    override fun getType(): HudObjectType<*> = HudObjectType.MINIMAP
    override fun isDefault(): Boolean = isDefault
    override fun getName(): String = id

    override fun render(player: HudPlayer): HudComponentSupplier<Minimap> {
        val task = runByTick(tick, { player.tick }) {
            if (!conditions(player)) return@runByTick EMPTY_WIDTH_COMPONENT
            
            // For the shader minimap, we just return the static font character.
            // The shader (text.vsh) will detect the texture size and apply
            // CameraBlockPos translation natively on the client GPU.
            WidthComponent(
                Component.text()
                    .content(0xC0000.parseChar().toString())
                    .font(key),
                section.getAsInt("display-size", 100)
            ).shadow(shader.outline)
        }
        return HudComponentSupplier.of(this) {
            listOf(task())
        }
    }

    override fun equals(other: Any?): Boolean {
        if (this === other) return true
        if (javaClass != other?.javaClass) return false
        other as ShaderMinimap
        return id == other.id
    }

    override fun hashCode(): Int = id.hashCode()
}
