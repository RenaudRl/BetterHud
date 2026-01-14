package kr.toxicity.hud.api.version;

import org.jetbrains.annotations.NotNull;

import java.util.Comparator;

/**
 * Minecraft version.
 * @param first title
 * @param second main update
 * @param third minor update
 */
public record MinecraftVersion(int first, int second, int third) implements Comparable<MinecraftVersion> {
    /**
     * Comparator
     */
    private static final Comparator<MinecraftVersion> COMPARATOR = Comparator.comparing(MinecraftVersion::first)
            .thenComparing(MinecraftVersion::second)
            .thenComparing(MinecraftVersion::third);

    @Override
    public int compareTo(@NotNull MinecraftVersion o) {
        return COMPARATOR.compare(this, o);
    }

    /**
     * 1.21.11
     */
    public static final MinecraftVersion V1_21_11 = new MinecraftVersion(1, 21, 11);

    /**
     * Latest
     */
    public static final MinecraftVersion LATEST = V1_21_11;

    /**
     * Parses version from string
     * @param version version like "1.21.11"
     */
    public MinecraftVersion(@NotNull String version) {
        this(version.split("\\."));
    }
    /**
     * Parses version from a string array
     * @param version version array like ["1", "21", "11"]
     */
    public MinecraftVersion(@NotNull String[] version) {
        this(
                version.length > 0 ? Integer.parseInt(version[0]) : 0,
                version.length > 1 ? Integer.parseInt(version[1]) : 0,
                version.length > 2 ? Integer.parseInt(version[2]) : 0
        );
    }

    @Override
    public @NotNull String toString() {
        return first + "." + second + "." + third;
    }
}