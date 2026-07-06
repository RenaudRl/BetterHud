package kr.toxicity.hud.api.manager;

import kr.toxicity.hud.api.minimap.Minimap;
import kr.toxicity.hud.api.minimap.MinimapMarker;
import kr.toxicity.hud.api.player.HudPlayer;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;
import org.jetbrains.annotations.Unmodifiable;

import java.util.Map;
import java.util.Set;

/**
 * Minimap manager
 */
public interface MinimapManager {
    /**
     * Gets minimap by given name.
     * @param name id.
     * @return minimap or null
     */
    @Nullable
    Minimap getMinimap(@NotNull String name);

    /**
     * Gets all minimap names.
     * @return all names of minimap
     */
    @NotNull @Unmodifiable
    Set<String> getAllNames();

    /**
     * Gets all minimaps.
     * @return all minimaps
     */
    @NotNull @Unmodifiable Set<Minimap> getAllMinimaps();

    /**
     * Adds or updates a marker for a specific player.
     * @param player the player
     * @param markerId the unique identifier for the marker
     * @param marker the marker to add
     */
    void addMarker(@NotNull HudPlayer player, @NotNull String markerId, @NotNull MinimapMarker marker);

    /**
     * Removes a marker for a specific player.
     * @param player the player
     * @param markerId the unique identifier for the marker
     */
    void removeMarker(@NotNull HudPlayer player, @NotNull String markerId);

    /**
     * Clears all markers for a specific player.
     * @param player the player
     */
    void clearMarkers(@NotNull HudPlayer player);

    /**
     * Gets all markers for a specific player.
     * @param player the player
     * @return map of marker IDs to markers
     */
    @NotNull @Unmodifiable
    Map<String, MinimapMarker> getMarkers(@NotNull HudPlayer player);
}
