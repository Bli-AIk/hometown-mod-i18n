#define MAX_PALETTE_ENTRIES 384

uniform vec4 base_palette[MAX_PALETTE_ENTRIES];
uniform vec4 live_palette[MAX_PALETTE_ENTRIES];
uniform int palette_size;
uniform bool debug;

vec4 ApplyPalette(vec4 inputCol)
{
    vec3 p = inputCol.rgb;

    for (int i = 0; i < palette_size; ++i)
    {
        vec3 base = base_palette[i].rgb;

        vec3 diff = p - base;

        if (abs(diff.r) > 0.001 ||
            abs(diff.g) > 0.001 ||
            abs(diff.b) > 0.001)
            continue;

        if (dot(diff, diff) < 0.000001)
        {
            vec4 outCol = live_palette[i];
            outCol.a = inputCol.a;
            return outCol;
        }
    }

    if (debug)
        return vec4(1.0, 0.0, 0.0, inputCol.a);

    return inputCol;
}

vec4 effect(vec4 drawcolor, Image tex, vec2 texture_coords, vec2 screen_coords)
{
    vec4 pixel = Texel(tex, texture_coords);
    vec4 color = drawcolor * pixel;

    if (color.a < 0.1)
        discard;

    return ApplyPalette(color);
}