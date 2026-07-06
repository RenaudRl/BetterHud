TEXT_EFFECT(240, 240, 0) {
    override_text_color(rgb(255, 82, 82));
    override_shadow_color(rgb(100, 20, 80));
}

TEXT_EFFECT(240, 240, 4) {
    apply_waving_movement();
    override_text_color(rgb(255, 235, 60));
    override_shadow_color(rgb(150, 60, 30));
}

TEXT_EFFECT(240, 240, 8) {
    apply_iterating_movement();
    override_text_color(rgb(86, 235, 86));
    override_shadow_color(rgb(20, 80, 90));
}

TEXT_EFFECT(240, 240, 12) {
    apply_flipping_movement();
    override_text_color(rgb(74, 222, 209));
    override_shadow_color(rgb(37, 71, 150));
}

TEXT_EFFECT(240, 240, 16) {
    apply_skewing_movement();
    override_text_color(rgb(122, 80, 251));
    override_shadow_color(rgb(40, 40, 140));
}

TEXT_EFFECT(240, 240, 20) {
    override_text_color(rgb(255, 82, 82));
    apply_outline(rgb(100, 20, 80));
}

TEXT_EFFECT(240, 240, 24) {
    apply_gradient(rgb(255, 235, 120), rgb(255, 82, 82));
}

TEXT_EFFECT(240, 240, 28) {
    apply_rainbow();
}

TEXT_EFFECT(240, 240, 32) {
    override_text_color(rgb(255, 255, 255));
    apply_shimmer();
}

TEXT_EFFECT(240, 240, 36) {
    override_text_color(rgb(255, 255, 255));
    apply_chromatic_abberation();
    remove_text_shadow();
}

TEXT_EFFECT(240, 240, 40) {
    apply_metalic(rgb(160, 160, 200));
}

TEXT_EFFECT(240, 240, 44) {
    override_text_color(rgb(255, 20, 20));
    apply_fire();
}

TEXT_EFFECT(240, 240, 48) {
    apply_growing_movement();
    override_text_color(rgb(255, 82, 82));
    override_shadow_color(rgb(100, 20, 80));
}

TEXT_EFFECT(240, 240, 52) {
    override_text_color(rgb(255, 235, 60));
    override_shadow_color(rgb(150, 60, 30));
    apply_fade(rgb(86, 235, 86));
}

TEXT_EFFECT(240, 240, 56) {
    override_text_color(rgb(86, 235, 86));
    override_shadow_color(rgb(20, 80, 90));
    apply_blinking();
}

TEXT_EFFECT(240, 240, 60) {
    override_text_color(rgb(74, 222, 209));
    override_shadow_color(rgb(37, 71, 150));
    apply_glowing();
}

// --- TEXT EFFECTS BLANCS ---
TEXT_EFFECT(240, 244, 0) {
    override_text_color(rgb(255, 255, 255));
    override_shadow_color(rgb(80, 80, 80));
}

TEXT_EFFECT(240, 244, 4) {
    apply_waving_movement();
    override_text_color(rgb(255, 255, 255));
    override_shadow_color(rgb(80, 80, 80));
}

TEXT_EFFECT(240, 244, 8) {
    apply_iterating_movement();
    override_text_color(rgb(255, 255, 255));
    override_shadow_color(rgb(80, 80, 80));
}

TEXT_EFFECT(240, 244, 12) {
    apply_flipping_movement();
    override_text_color(rgb(255, 255, 255));
    override_shadow_color(rgb(80, 80, 80));
}

TEXT_EFFECT(240, 244, 16) {
    apply_skewing_movement();
    override_text_color(rgb(255, 255, 255));
    override_shadow_color(rgb(80, 80, 80));
}

TEXT_EFFECT(240, 244, 20) {
    override_text_color(rgb(255, 255, 255));
    apply_outline(rgb(80, 80, 80));
}

TEXT_EFFECT(240, 244, 24) {
    apply_gradient(rgb(255, 255, 255), rgb(120, 120, 120));
}

TEXT_EFFECT(240, 244, 28) {
    apply_rainbow();
    textData.color.rgb *= rgb(255, 255, 255);
}

TEXT_EFFECT(240, 244, 36) {
    override_text_color(rgb(255, 255, 255));
    apply_chromatic_abberation();
    remove_text_shadow();
}

TEXT_EFFECT(240, 244, 40) {
    apply_metalic(rgb(255, 255, 255));
}

TEXT_EFFECT(240, 244, 44) {
    override_text_color(rgb(255, 255, 255));
    apply_fire();
}

TEXT_EFFECT(240, 244, 48) {
    apply_growing_movement();
    override_text_color(rgb(255, 255, 255));
    override_shadow_color(rgb(80, 80, 80));
}

TEXT_EFFECT(240, 244, 52) {
    override_text_color(rgb(255, 255, 255));
    override_shadow_color(rgb(80, 80, 80));
    apply_fade(rgb(120, 120, 120));
}

TEXT_EFFECT(240, 244, 56) {
    override_text_color(rgb(255, 255, 255));
    override_shadow_color(rgb(80, 80, 80));
    apply_blinking();
}

TEXT_EFFECT(240, 244, 60) {
    override_text_color(rgb(255, 255, 255));
    override_shadow_color(rgb(80, 80, 80));
    apply_glowing();
}

// --- RANK OUTLINES ---
TEXT_EFFECT(240, 248, 0) { // player
    override_text_color(rgb(255, 255, 255));
    apply_outline(rgb(176, 176, 176));
}

TEXT_EFFECT(240, 248, 4) { // copper
    override_text_color(rgb(255, 255, 255));
    apply_outline(rgb(255, 176, 44));
}

TEXT_EFFECT(240, 248, 8) { // emerald
    override_text_color(rgb(255, 255, 255));
    apply_outline(rgb(5, 163, 0));
}

TEXT_EFFECT(240, 248, 12) { // obsidian
    override_text_color(rgb(255, 255, 255));
    apply_outline(rgb(191, 0, 255));
}

TEXT_EFFECT(240, 248, 16) { // helper
    override_text_color(rgb(255, 255, 255));
    apply_outline(rgb(244, 111, 216));
}

TEXT_EFFECT(240, 248, 20) { // staff
    override_text_color(rgb(255, 255, 255));
    apply_outline(rgb(26, 86, 127));
}

TEXT_EFFECT(240, 248, 24) { // owner
    override_text_color(rgb(255, 255, 255));
    apply_outline(rgb(176, 0, 0));
}

// --- RARITY OUTLINES ---
TEXT_EFFECT(240, 248, 28) { // common
    override_text_color(rgb(255, 255, 255));
    apply_outline(rgb(153, 153, 153));
}

TEXT_EFFECT(240, 248, 32) { // uncommon
    override_text_color(rgb(255, 255, 255));
    apply_outline(rgb(255, 242, 0));
}

TEXT_EFFECT(240, 248, 36) { // rare
    override_text_color(rgb(255, 255, 255));
    apply_outline(rgb(0, 217, 0));
}

TEXT_EFFECT(240, 248, 40) { // epic
    override_text_color(rgb(255, 255, 255));
    apply_outline(rgb(0, 145, 217));
}

TEXT_EFFECT(240, 248, 44) { // legendary
    override_text_color(rgb(255, 255, 255));
    apply_outline(rgb(176, 0, 18));
}

TEXT_EFFECT(240, 248, 48) { // mythic
    override_text_color(rgb(255, 255, 255));
    apply_outline(rgb(126, 0, 176));
}
