uniform vec4 night_tint;

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    vec4 pixel = Texel(texture, texture_coords) * color;

    if (pixel.a < 0.01)
        discard;

    // 1. Calculate how bright the original pixel is (luminance)
    float brightness = dot(pixel.rgb, vec3(0.2126, 0.7152, 0.0722));

    // 2. Multiply by our night tint
    vec3 night_rgb = pixel.rgb * night_tint.rgb;

    // 3. Crisp Midnight Shadow Math:
    // Instead of adding flat color everywhere, we multiply the deep blue color tint 
    // BY the existing brightness. This ensures true black spaces stay perfectly black,
    // while midtones smoothly sink into a deep blue-purple nighttime hue!
    night_rgb = mix(night_rgb, night_rgb * vec3(0.4, 0.45, 0.7), (1.0 - brightness));

    return vec4(night_rgb, pixel.a);
}
