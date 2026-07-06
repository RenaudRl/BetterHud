package kr.toxicity.hud.api.minimap;

import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

/**
 * Represents a marker on the minimap.
 */
public interface MinimapMarker {
    /**
     * Gets the X world coordinate of the marker.
     * @return X coordinate
     */
    int getX();

    /**
     * Gets the Z world coordinate of the marker.
     * @return Z coordinate
     */
    int getZ();

    /**
     * Gets the type of the marker.
     * @return marker type
     */
    @NotNull MarkerType getType();

    /**
     * Gets the ARGB color of the marker.
     * @return ARGB color
     */
    int getColor();

    /**
     * Gets the custom texture icon key (optional).
     * @return icon key or null
     */
    @Nullable String getIcon();

    /**
     * Gets the label of the marker (optional).
     * @return label or null
     */
    @Nullable String getLabel();

    /**
     * Creates a new builder for a MinimapMarker.
     * @param x X coordinate
     * @param z Z coordinate
     * @return new builder
     */
    static @NotNull Builder builder(int x, int z) {
        return new Builder(x, z);
    }

    /**
     * Builder for MinimapMarker.
     */
    class Builder {
        private final int x;
        private final int z;
        private MarkerType type = MarkerType.WAYPOINT;
        private int color = 0xFFFFFFFF;
        private String icon = null;
        private String label = null;

        Builder(int x, int z) {
            this.x = x;
            this.z = z;
        }

        public @NotNull Builder type(@NotNull MarkerType type) {
            this.type = type;
            return this;
        }

        public @NotNull Builder color(int color) {
            this.color = color;
            return this;
        }

        public @NotNull Builder icon(@Nullable String icon) {
            this.icon = icon;
            return this;
        }

        public @NotNull Builder label(@Nullable String label) {
            this.label = label;
            return this;
        }

        public @NotNull MinimapMarker build() {
            return new MinimapMarker() {
                @Override
                public int getX() {
                    return x;
                }

                @Override
                public int getZ() {
                    return z;
                }

                @Override
                public @NotNull MarkerType getType() {
                    return type;
                }

                @Override
                public int getColor() {
                    return color;
                }

                @Override
                public @Nullable String getIcon() {
                    return icon;
                }

                @Override
                public @Nullable String getLabel() {
                    return label;
                }
            };
        }
    }
}
