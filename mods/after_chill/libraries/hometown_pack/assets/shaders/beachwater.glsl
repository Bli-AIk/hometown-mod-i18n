uniform float time;
uniform vec2 texture_dim;
uniform vec2 do_dim;
uniform int thickness;

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords) {
    vec2 chunk = vec2(
        floor(texture_coords.x * texture_dim.x / float(thickness)) * float(thickness),
        floor(texture_coords.y * texture_dim.y / float(thickness)) * float(thickness)
    );

    if (do_dim.x > 0.0)
        texture_coords.x += sin(time + chunk.x / 30.0) * 2.0 / texture_dim.x;

    if (do_dim.y > 0.0)
        texture_coords.y += sin(time + chunk.y / 30.0) * 2.0 / texture_dim.y;

    return Texel(tex, texture_coords) * color;
}