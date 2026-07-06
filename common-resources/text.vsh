#version 330

#CreateConstant

#moj_import <fog.glsl>
#moj_import <sample_lightmap.glsl>

#if SHADER_VERSION >= 2
#moj_import <dynamictransforms.glsl>
#moj_import <projection.glsl>
#moj_import <globals.glsl>
out float sphericalVertexDistance;
out float cylindricalVertexDistance;
#else
uniform mat4 ProjMat;
uniform mat4 ModelViewMat;
uniform int FogShape;
out float vertexDistance;
uniform vec2 ScreenSize;
uniform float GameTime;
#endif

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;

uniform sampler2D Sampler0;
uniform sampler2D Sampler2;

uniform vec3 ChunkOffset;

out vec4 vertexColor;
out vec2 texCoord0;

out float applyColor;

bool range(float t, float m1, float m2) {
    return t >= m1 && t <= m2;
}

bool range(vec2 t, vec2 m1, vec2 m2) {
    return range(t.x, m1.x, m2.x) && range(t.y, m1.y, m2.y);
}

bool range(vec3 t, vec3 m1, vec3 m2) {
    return range(t.x, m1.x, m2.x) && range(t.y, m1.y, m2.y) && range(t.z, m1.z, m2.z);
}

bool checkElement(float z) {
    if (z == 0) return true; //<=1.20.4 vanilla
    else if (z == 1000) return true; //>=1.20.5 vanilla
    else if (z == -90) return true; //<=1.20.4 forge
    else if (z == 2800) return true; //neoforge
    return false;
}

float fogDistance(vec3 pos, int shape) {
    if (shape == 0) {
        return length(pos);
    } else {
        float distXZ = length(pos.xz);
        float distY = abs(pos.y);
        return max(distXZ, distY);
    }
}

// ============================================================
// BTC MINIMAP — constants (injected via shader.yml at reload)
// ============================================================
#ifdef IS_GUI
// Do not modify this line.
const vec2 MINIMAP_UV_OFFSETS[4] = vec2[](vec2(-0.5), vec2(-0.5, 0.5), vec2(0.5), vec2(0.5, -0.5));
const vec2 MINIMAP_POSITIONS[4]  = vec2[](vec2(0.), vec2(0., 1.), vec2(1.), vec2(1., 0.));
const vec2 TOP    = vec2(0.);
const vec2 RIGHT  = vec2(-1., 0.);
const vec2 LEFT   = vec2(0.);
const vec2 BOTTOM = vec2(0., -1.);

// --- Configurable via shader.yml ---
// Texture size in pixels (must NOT be 256x256 or 64x64)
const ivec2 MINIMAP_TEX_SIZE = ivec2(MINIMAP_TEX_SIZE_X, MINIMAP_TEX_SIZE_Y);
// Display size in GUI pixels
const float MINIMAP_SIZE = float(MINIMAP_DISPLAY_SIZE);
// Padding from corner in GUI pixels
const vec2 MINIMAP_PADDING = vec2(float(MINIMAP_PADDING_X), float(MINIMAP_PADDING_Y));
// Corner alignment (TOP+LEFT = top-left, etc.)
const vec2 MINIMAP_ALIGN = vec2(MINIMAP_ALIGN_X, MINIMAP_ALIGN_Y);
// Center block coordinates of the minimap texture
const ivec2 MINIMAP_CENTER = ivec2(MINIMAP_CENTER_X, MINIMAP_CENTER_Z);
// Region in blocks the minimap shows
const float MINIMAP_SIZE_IN_BLOCKS = float(MINIMAP_BLOCKS_VISIBLE);
// Blocks per pixel (< 1 zooms in)
const float MINIMAP_BLOCKS_PER_PIXEL = MINIMAP_BLOCKS_PER_PX;
// Frame thickness in GUI pixels (0 = no frame)
const float MINIMAP_FRAME_SIZE = float(MINIMAP_FRAME_PX);
// Circular cutout (true = circle, false = square)
const bool MINIMAP_CIRCULAR = bool(MINIMAP_IS_CIRCULAR);
#endif
// ============================================================

#GenerateOtherDefinedMethod

void main() {
    vec3 pos = Position;
    vec2 ui = ceil(2 / vec2(ProjMat[0][0], -ProjMat[1][1]));
    vec2 uiScreen = ui / ScreenSize;
    vec3 color = Color.xyz;
    applyColor = 0;
    vertexColor = Color;
    if (pos.y >= ui.y && ProjMat[3].x == -1) {
        int bit = int(pos.y) >> HEIGHT_BIT;

        if (((bit >> MAX_BIT) & 1) == 1) {

            int id = bit - (1 << MAX_BIT);

            pos.x -= 0.5 * ui.x;
            pos.y -= (bit << HEIGHT_BIT) + ADD_OFFSET + DEFAULT_OFFSET;

            float xGui = 0;
            float yGui = 0;
            float layer = 0;
            float opacity = 1;
            bool outline = false;
            int property = 0;

            switch (id) {
                #CreateLayout
            }

#if SHADER_VERSION < 1
            vertexColor = (checkElement(pos.z) && !outline) ? vec4(0) : Color * vec4(1, 1, 1, opacity);
#else
            vertexColor = Color * vec4(1, 1, 1, opacity);
#endif

            //Wave
            if ((property & 1) > 0) {
                pos.y += 4 * sin((GameTime * 1200 + pos.x / ui.x) * 3.1415 * 2);
            }
            //Rainbow
            if ((property & 2) > 0) {
                int hash = int(pos.x) * int(pos.y);
                float time = GameTime * 1200;
                hash = 31 * (hash + int(vertexColor.x + time));
                float r = float(hash % 224 + 32) / 255;
                hash = 31 * (hash + int(vertexColor.y + time));
                float g = float(hash % 224 + 32) / 255;
                hash = 31 * (hash + int(vertexColor.z + time));
                float b = float(hash % 224 + 32) / 255;
                float maxValue = max(max(r, g), b);
                vertexColor = vec4(pow(r / maxValue, 3), pow(g / maxValue, 3), pow(b / maxValue, 3), vertexColor.w);
            }
            //Tiny rainbow
            if ((property & 4) > 0) {
                int hash = int(pos.x) * int(pos.y);
                float time = GameTime * 1200;
                hash = 31 * (hash + int(vertexColor.x + time));
                float r = vertexColor.x + float(hash % 64) / 255;
                hash = 31 * (hash + int(vertexColor.y + time));
                float g = vertexColor.y + float(hash % 64) / 255;
                hash = 31 * (hash + int(vertexColor.z + time));
                float b = vertexColor.z + float(hash % 64) / 255;
                vertexColor = vec4(r, g, b, vertexColor.w);
            }

            pos.x += xGui;
            pos.y += yGui;
            pos.z += layer;

        }
    } else {
//HideExp        vec3 exp = vec3(128.0, 255.0, 32.0);
//HideExp        if (ProjMat[3].x == -1 && range(pos.y, ui.y - 60, ui.y - 20) && range(pos.x, ui.x / 2 - 60, ui.x / 2 + 60) && (range(color, exp / 256, exp / 254) || color == vec3(0))) {
//HideExp            vertexColor = vec4(0);
//HideExp        }
    }
#if !defined(IS_GUI) && !defined(IS_SEE_THROUGH)
    vertexColor *= sample_lightmap(Sampler2, UV2);
#endif

    #GenerateOtherMainMethod

#if SHADER_VERSION >= 2
    sphericalVertexDistance = fog_spherical_distance(pos);
    cylindricalVertexDistance = fog_cylindrical_distance(pos);
#else
    vertexDistance = fogDistance(pos, FogShape);
#endif

    texCoord0 = UV0;
    gl_Position = ProjMat * ModelViewMat * vec4(pos, 1.0);

    // ============================================================
    // BTC MINIMAP — shader rendering
    // Detects the minimap texture by its size and renders it
    // in GUI space using the player's camera position.
    // ============================================================
#ifdef IS_GUI
    if (textureSize(Sampler0, 0).rg == MINIMAP_TEX_SIZE) {
        // GUI pixel-space position
        vec2 vertPos = MINIMAP_SIZE * (MINIMAP_ALIGN + MINIMAP_POSITIONS[gl_VertexID & 3])
                     + (MINIMAP_PADDING * sign(MINIMAP_ALIGN + 0.5));

        // Convert to clip space and apply corner alignment
        gl_Position = ProjMat * ModelViewMat * vec4(vertPos, 0., 1.)
                    + vec4(vec2(-2., 2.) * MINIMAP_ALIGN, 0., 0.);

        // UV: center on player's block position via CameraBlockPos (from globals.glsl)
        texCoord0 = (
            0.5 * vec2(MINIMAP_TEX_SIZE)
            + MINIMAP_BLOCKS_PER_PIXEL * (
                vec2(CameraBlockPos.xz) - vec2(CameraOffset.xz) - vec2(MINIMAP_CENTER)
                + MINIMAP_UV_OFFSETS[gl_VertexID & 3] * MINIMAP_SIZE_IN_BLOCKS
            )
        ) / vec2(MINIMAP_TEX_SIZE);
    }
#endif
    // ============================================================
}
