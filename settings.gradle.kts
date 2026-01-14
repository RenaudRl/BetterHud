pluginManagement {
    repositories {
        mavenCentral()
        gradlePluginPortal()
        maven("https://maven.fabricmc.net/")
    }
}

plugins {
    id("org.gradle.toolchains.foojay-resolver-convention") version "1.0.0"
}

rootProject.name = "BetterHud"

gradle.startParameter.isParallelProjectExecutionEnabled = true

include(
    "api:standard-api",
    "api:bukkit-api",

    "dist",
    "nms:v1_21_R7",

    "scheduler:standard",
    "scheduler:paper",

    "bedrock:geyser",
    "bedrock:floodgate",

    "bootstrap:bukkit"
)