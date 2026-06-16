uniform vec4 night_tint;
uniform float saturation; 
uniform float contrast;   

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    vec4 pixel = Texel(texture, texture_coords) * color;

    if (pixel.a < 0.01)
        discard;

    float brightness = dot(pixel.rgb, vec3(0.2126, 0.7152, 0.0722));
    vec3 weather_rgb = pixel.rgb * night_tint.rgb;

    weather_rgb = mix(weather_rgb, weather_rgb * vec3(0.4, 0.45, 0.7), (1.0 - brightness));

    // contrast 
    weather_rgb = (weather_rgb - 0.5) * contrast + 0.5;
    // saturation 
    vec3 gray = vec3(dot(weather_rgb, vec3(0.299, 0.587, 0.114)));
    weather_rgb = mix(gray, weather_rgb, saturation);

    weather_rgb = clamp(weather_rgb, 0.0, 1.0);

    return vec4(weather_rgb, pixel.a);
}
