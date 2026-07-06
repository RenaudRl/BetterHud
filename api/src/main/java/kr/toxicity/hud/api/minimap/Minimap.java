package kr.toxicity.hud.api.minimap;

import kr.toxicity.hud.api.configuration.HudComponentSupplier;
import kr.toxicity.hud.api.configuration.HudObject;
import kr.toxicity.hud.api.player.HudPlayer;
import org.jetbrains.annotations.NotNull;

/**
 * Represents minimap.
 */
public interface Minimap extends HudObject {
    /**
     * Renders minimap for a player.
     * @param player target player
     * @return component supplier
     */
    @NotNull
    HudComponentSupplier<Minimap> render(@NotNull HudPlayer player);
}
