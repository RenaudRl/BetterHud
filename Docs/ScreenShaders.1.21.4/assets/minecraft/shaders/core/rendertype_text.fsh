#version 150

#moj_import <fog.glsl>

#define BACKGROUND_COLOR vec4(20, 20, 28, 255) / 255

#define SPIKES_SPEED 2000
#define SPIKES_RADIUS 0.07
#define SPIKES_COUNT 50
#define SPIKES_BLUR 50 //Bigger value -> less blur
#define SPIKES_BLUR_BIAS 0 //Addition to transparrency in blur

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;
uniform float GameTime;

uniform vec2 ScreenSize;

in float vertexDistance;
in vec4 vertexColor;
in vec2 texCoord0;

in vec2 p1;
in vec2 p2;
in vec2 coord;
flat in int vert;
flat in int p;

out vec4 fragColor;

#moj_import <effect_utils.glsl>

void main() {
    vec4 color = texture(Sampler0, texCoord0) * vertexColor * ColorModulator;

    vec2 P1 = round(p1 / (vert == 0 ? 1 - coord.x : 1 - coord.y)); //Right-up corner
    vec2 P2 = round(p2 / (vert == 0 ? coord.y : coord.x)); //Left-down corner

    ivec2 res = ivec2(abs(P1 - P2)); //Resolution of frame
    ivec2 stp = ivec2(min(P1, P2)); //Left-Up corner

    vec4 test = texture(Sampler0, stp / 256.0) * 255;

    if (test.a == 3)
    {
        ivec2 frames = ivec2(res / test.gb);
        vec2 uv = (texCoord0 * 256 - stp) / frames.x;

        if (uv.x > test.y || uv.y > test.z)
            discard;

        int time = int(GameTime * 1000 * test.x) % int(frames.x * frames.y);

        uv = stp + mod(uv, test.yz) + vec2(time % frames.x, time / frames.x % frames.y) * test.yz;
        color = texture(Sampler0, uv / 256.0) * vertexColor * ColorModulator;
    }

    if (p != 0)
    {
        vec2 centerUV = gl_FragCoord.xy / ScreenSize - 0.5;
        float Ratio = ScreenSize.y / ScreenSize.x;
        switch (p)
        {
            case 1:
            {
                
                vec2 uv = mat2_rotate_z(vertexColor.a*4) * (centerUV / vec2(Ratio, 1)) / (1.0001 - vertexColor.a) * 0.2 + 0.5;

                if (clamp(uv, vec2(0), vec2(1)) == uv)
                    color = texture(Sampler0, texCoord0 + uv * 56 / 256);
                else
                    color = BACKGROUND_COLOR;
            }
            break;
            case 2:
            {
                color = vec4(0, 0, 0, clamp(length(centerUV * vec2(0.8, 0.5 / (1 - vertexColor.a))) - 0.6, 0, 1));
            }
            break;
            case 3:
            {
                color = vec4(0);
                
                float angle = (atan(centerUV.y, centerUV.x) / PI / 2 + 0.5) * SPIKES_COUNT;
                float Time = GameTime * SPIKES_SPEED + hash(int(angle)) % 100 * 64.2343;
                int noise = hash(int(angle) + int(Time) * 1000) % 128;
                float s = (abs(fract(angle) - 0.5) * 20 / SPIKES_COUNT - 0.2) * length(centerUV) + SPIKES_RADIUS + (1 - vertexColor.a) * 0.05 + abs(fract(Time) - 0.5) * 0.25;
                if (s < 0)
                {
                    color = vec4(1, 1, 1, clamp(-s * SPIKES_BLUR + SPIKES_BLUR_BIAS, 0, 1));
                    break;
                }
            }
            break;
            case 4:
            {
                vec2 grid = (ivec2(gl_FragCoord.xy / 32) * 32);
                vec2 inGrid = gl_FragCoord.xy - grid - 16;
                float size;

                switch (int(vertexColor.b * 255))
                {
                    case 0:
                        size = grid.x / ScreenSize.x;
                        break;
                    case 1:
                        size = 1 - grid.x / ScreenSize.x;
                        break;
                    case 2:
                        size = grid.y / ScreenSize.y;
                        break;
                    default:
                        size = 1 - grid.y / ScreenSize.y;
                        break;
                }

                size = (size - vertexColor.a * 2 + 1) * 32;

                color = (abs(inGrid.x) + abs(inGrid.y) > size) ? vec4(0, 0, 0, 1) : vec4(0);
            }
            break;
            case 5:
            {
                ivec2 grid = ivec2(gl_FragCoord.xy / 32) * 32;

                color = abs(hash(grid.x ^ hash(grid.y)) % 0x100) + 10 < int(vertexColor.a * (length(grid / ScreenSize.xy - 0.5) * 2 + 1) * 0x100) ? vec4(vertexColor.rgb, 1) : vec4(0);
            }
            case 6:
            {
                float Time = cos(vertexColor.a * PI / 2);
                color = vec4(vertexColor.rgb, (length((gl_FragCoord.xy / ScreenSize - 0.5) / vec2(ScreenSize.y / ScreenSize.x, 1)) + 0.1 - Time) * (1 - Time) * 100);
            }
            break;
            case 7:
            {
                vec2 uv = centerUV / vec2(Ratio, 1);
                color = vec4(0);

                float radius = length(uv);

                if (radius >= 0.05 && radius < 0.08 && vertexColor.a >= 0.99)
                {
                    float angle = fract(-atan(uv.y, uv.x) / PI * 0.5 + 0.5 - GameTime * 1000);
                    color = vec4(1, 1, 1, angle);
                }
            }
            break;
            case 32:
            {
                color = vec4(0);
                color = sampleStain(color, vertexColor, stp, vec2(-0.1, -0.2));
                color = sampleStain(color, vertexColor, stp, vec2(-0.05, 0.2));
                color = sampleStain(color, vertexColor, stp, vec2(0.2, -0.1));
            }
            break;
        }
    }


    if (color.a == 0) {
        discard;
    }
    fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
}
