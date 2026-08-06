uniform float amount; // 0.0 = full color, 1.0 = pitch black & grey

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    // 1. Grab the clean texture pixel
    vec4 pixel = Texel(texture, texture_coords) * color;
    
    // 2. THE LUA CLASS SIGNAL CHECK:
    // If the incoming draw color alpha is exactly 0.99, Lua is telling us 
    // "Hey, this is a Textbox! Protect it!"
    if (color.a > 0.98 && color.a < 0.995) {
        // Fix the alpha back to 1.0 so it doesn't look faint, and bypass darkness math
        pixel.a = 1.0; 
        return pixel; 
    }

    // 3. Safe-clamp the incoming amount so values over 1.0 don't break the math
    float t = clamp(amount, 0.0, 1.0);
    
    // 4. Extract pure human-eye brightness (Greyscale)
    float luma = dot(pixel.rgb, vec3(0.299, 0.587, 0.114));
    vec3 gray = vec3(luma);
    
    // 5. Mix original color with pure gray
    vec3 desaturated = mix(pixel.rgb, gray, t);
    
    // 6. CRUSH THE LIGHT: Everything without the secret payload fades completely
    pixel.rgb = desaturated * (1.0 - t);
    
    return pixel;
}
