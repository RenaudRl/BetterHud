#version 150

#moj_import <fog.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;
uniform float GameTime;

in float vertexDistance;
in vec4 vertexColor;
flat in vec4 baseColor;
in vec2 corner;
flat in float isGui;
in vec4 screenPos;
flat in float isShadow;
in vec2 texCoord0;

in vec3 ipos1;
in vec3 ipos2;
in vec3 ipos3;

in vec3 uvpos1;
in vec3 uvpos2;
in vec3 uvpos3;
in vec3 uvpos4;

#define TEXT_EFFECTS_FSH
#moj_import<text_effects.glsl>

int applyTextEffects() { 
    uint r = uint(round(textData.color.r * 255.0));
    uint g = uint(round(textData.color.g * 255.0));
    uint b = uint(round(textData.color.b * 255.0));

    bool layerGlow = false;
    bool layerBg = false;
    bool layerGlitch = false;
    bool layerRainbowOutline = false;

    // Detect Style Categories (G channel)
    // 232 (E8) = Glow + Base
    // 236 (EC) = Background + Base
    // 228 (E4) = Glow + Background + Base
    // 224 (E0) = Glitch + Base
    // 220 (DC) = Rainbow Outline + Base
    if (r == 240) {
        if (g == 232) { layerGlow = true; g = 240; }
        else if (g == 236) { layerBg = true; g = 240; }
        else if (g == 228) { layerGlow = true; layerBg = true; g = 240; }
        else if (g == 224) { layerGlitch = true; g = 240; }
        else if (g == 220) { layerRainbowOutline = true; g = 240; }
    }

    uint vertexColorId = (uint(r/4) << 16) | (uint(g/4) << 8) | (uint(b/4));
    if(textData.isShadow) { vertexColorId = colorId(textData.color.rgb);} 

    switch(vertexColorId) { 
        case 16777215u:
            #moj_import<text_effects_config.glsl>
            break;
    }

    if (layerGlow) apply_layer_glowing();
    if (layerBg) apply_layer_background(vec4(0.0, 0.0, 0.0, 0.5), 2.0);
    if (layerGlitch) apply_layer_glitch(1.0);
    if (layerRainbowOutline) apply_layer_rainbow_outline(0.4);

    return 0;
}

out vec4 fragColor;

void main() {
    textData.isShadow = isShadow > 0.5;
    textData.backColor = vec4(0.0);
    textData.topColor = vec4(0.0);
    textData.doTextureLookup = true;

    if(isGui > 0.5) {
        textData.color = baseColor;

        vec2 ip1 = ipos1.xy / ipos1.z;
        vec2 ip2 = ipos2.xy / ipos2.z;
        vec2 ip3 = ipos3.xy / ipos3.z;
        vec2 innerMin = min(ip1.xy,min(ip2.xy,ip3.xy));
        vec2 innerMax = max(ip1.xy,max(ip2.xy,ip3.xy));
        vec2 innerSize = innerMax - innerMin;
        
        vec2 uvp1 = uvpos1.xy / uvpos1.z;
        vec2 uvp2 = uvpos2.xy / uvpos2.z;
        vec2 uvp3 = uvpos3.xy / uvpos3.z;
        vec2 uvp4 = uvpos4.xy / uvpos4.z;

        //uvp1 = clamp(uvp1, vec2(0.0), vec2(1.0));
        //uvp2 = clamp(uvp2, vec2(0.0), vec2(1.0));
        //uvp3 = clamp(uvp3, vec2(0.0), vec2(1.0));

        vec2 uvMin = min(uvp1.xy,min(uvp2.xy,min(uvp3.xy, uvp4.xy)));
        vec2 uvMax = max(uvp1.xy,max(uvp2.xy,max(uvp3.xy, uvp4.xy)));
        vec2 uvSize = uvMax - uvMin;

        textData.uvMin = uvMin;
        textData.uvMax = uvMax;
        textData.uvCenter = uvMin + 0.25 * uvSize;

        textData.localPosition = ((screenPos.xy - innerMin) / innerSize);
        textData.localPosition.y = 1.0 - textData.localPosition.y;
        textData.uv = textData.localPosition * uvSize + uvMin;

        textData.position = screenPos.xy * uvSize * 256.0 / innerSize;
        textData.characterPosition = 0.5 * (innerMin + innerMax) * uvSize * 256.0 / innerSize;
        if(textData.isShadow) { 
            textData.characterPosition += vec2(-1.0, 1.0);
            textData.position += vec2(-1.0, 1.0);
        }

        applyTextEffects();

        if(uvBoundsCheck(textData.uv, uvMin, uvMax)) textData.doTextureLookup = false;
    }else{
        textData.uv = texCoord0;
        textData.color = vertexColor;
    }
    
    vec4 textureSample = texture(Sampler0, textData.uv);
    if(!textData.doTextureLookup) textureSample = vec4(0.0);

    fragColor = mix(vec4(textData.backColor.rgb, textData.backColor.a * textData.color.a), textureSample * textData.color, textureSample.a);
    fragColor.rgb = mix(fragColor.rgb, textData.topColor.rgb, textData.topColor.a);
    fragColor *= ColorModulator;

    if (fragColor.a < 0.1) {
        discard;
    }
    fragColor = linear_fog(fragColor, vertexDistance, FogStart, FogEnd, FogColor);
}
