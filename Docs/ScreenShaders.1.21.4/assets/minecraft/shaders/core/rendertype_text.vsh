#version 150

#moj_import <fog.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;

uniform sampler2D Sampler0;
uniform sampler2D Sampler2;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform int FogShape;
uniform vec2 ScreenSize;

out float vertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;

out vec2 p1;
out vec2 p2;
out vec2 coord;
flat out int vert;
flat out int p;

void main() {
    vec4 vertex = vec4(Position, 1.0);
    if (Color.xyz == vec3(251, 255, 255) / 255)
    {
        gl_Position = ProjMat * ModelViewMat * vertex;
        vertexColor = vec4(1);
    } else if (Color.xyz == vec3(62, 63, 63) / 255)
    {
        gl_Position = vec4(0);
        return;
    }
    else if (Color.xyz == vec3(255., 254., 253.) / 255.) {
        vertex.xy += 1;
        gl_Position = ProjMat * ModelViewMat * vertex;
    }
    else {
        (gl_Position = ProjMat * ModelViewMat * vertex);
        (vertexColor = Color * texelFetch(Sampler2, UV2 / 16, 0));
    }

    vertexDistance = length((ModelViewMat * vertex).xyz);
    texCoord0 = UV0;
    if(	Position.z == 0.0 && // check if the depth is correct (0 for gui texts)
			gl_Position.x >= 0.94 && gl_Position.y >= -0.35 && // check if the position matches the sidebar
			vertexColor.g == 84.0/255.0 && vertexColor.g == 84.0/255.0 && vertexColor.r == 252.0/255.0 && // check if the color is the sidebar red color
			gl_VertexID <= 3 // check if it's the first character of a string !! if you want two characters removed replace '3' with '7'
		) gl_Position = ProjMat * ModelViewMat * vec4(ScreenSize + 100.0, 0.0, 0.0);

    p1 = p2 = vec2(0);
    vert = gl_VertexID % 4;

    const vec2[4] corners = vec2[4](vec2(0), vec2(0, 1), vec2(1), vec2(1, 0));
    coord = corners[vert];

    if (vert == 0) p1 = UV0 * 256;
    if (vert == 2) p2 = UV0 * 256;

    p = 0;
    

    float alpha = round(texture(Sampler0, UV0).a * 255);

    if (alpha == 252)
        p = 1;
    else if (alpha == 251)
        p = int(round(texture(Sampler0, UV0).b * 255));
    else if (alpha == 5)
        p = 32;

    if (p != 0 && Position.z > 0)
    {   
        texCoord0 = vec2(UV0 - coord * 56 / 256);

        gl_Position.xy = vec2(coord * 2 - 1) * vec2(1, -1);
        gl_Position.zw = vec2(-1, 1);
        vertexColor = Color;
    }
}
