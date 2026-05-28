uniform float amount;

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    vec4 pixel = Texel(texture, texture_coords) * color;
    float luma = dot(pixel.rgb, vec3(0.299, 0.587, 0.114));
    vec3 gray = vec3(luma);
    vec3 slate_blue = vec3(luma * 0.4, luma * 0.45, luma * 0.6);
    vec3 target_color = mix(slate_blue, gray, luma);
    pixel.rgb = mix(pixel.rgb, target_color, amount);
    return pixel;
}

