package kr.toxicity.hud.api.minimap;

/**
 * Represents the type of a minimap marker.
 * Used by the minimap shader to determine which icon to display.
 */
public enum MarkerType {
    /**
     * A generic waypoint or point of interest.
     */
    WAYPOINT,
    /**
     * A player's position.
     */
    PLAYER,
    /**
     * An entity's position (mob, NPC).
     */
    ENTITY,
    /**
     * The world or player's spawn point.
     */
    SPAWN,
    /**
     * A custom user-defined marker.
     */
    CUSTOM
}
