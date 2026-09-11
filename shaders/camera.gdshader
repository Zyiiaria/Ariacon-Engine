shader_type canvas_item;

uniform float change_interval = 0.01;
uniform float flash_darkness : hint_range(0.0, 1.0) = 0.0;

uniform float scanline_strength : hint_range(0.0, 1.0) = 0.25;
uniform float scanline_count : hint_range(50.0, 1000.0) = 400.0;
uniform float curvature : hint_range(0.0, 0.2) = 0.04;
uniform float rgb_shift : hint_range(0.0, 0.01) = 0.0005;
uniform float vignette_strength : hint_range(0.0, 1.0) = 0.35;
uniform float flicker_strength : hint_range(0.0, 0.2) = 0.03;
uniform float noise_strength : hint_range(0.0, 0.1) = 0.015;

float random(float x) {
    return fract(sin(x * 12.9898) * 43758.5453);
}

vec2 crt_curve(vec2 uv) {
    vec2 centered = uv - 0.5;

    float curve_amount = dot(centered, centered);

    centered *= 1.0 + curve_amount * curvature * 4.0;

    return centered + 0.5;
}

void fragment() {
    vec2 uv = crt_curve(UV);

    if (uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0 || uv.y > 1.0) {
        COLOR = vec4(0.0, 0.0, 0.0, 1.0);
    } else {
        float step_time = floor(TIME / change_interval);

        float pixel_amount = floor(random(step_time) * 25.0) + 350.0;

        vec2 pixel_uv = floor(uv * pixel_amount) / pixel_amount;

        float shifted_uv = rgb_shift;

        float red = texture(
            TEXTURE,
            vec2(pixel_uv.x + shifted_uv, pixel_uv.y)
        ).r;

        float green = texture(
            TEXTURE,
            pixel_uv
        ).g;

        float blue = texture(
            TEXTURE,
            vec2(pixel_uv.x - shifted_uv, pixel_uv.y)
        ).b;

        vec3 tex = vec3(red, green, blue);

        float scanline = sin(uv.y * scanline_count * 3.14159);
        scanline = 1.0 - (scanline * scanline_strength);

        float flicker = 1.0 + sin(TIME * 20.0) * flicker_strength;

        vec2 vignette_uv = uv - 0.5;
        float vignette = 1.0 - dot(vignette_uv, vignette_uv) * vignette_strength * 2.0;
        vignette = clamp(vignette, 0.0, 1.0);

        float noise = random(
            floor(uv.y * scanline_count) + floor(TIME * 60.0)
        );

        noise = (noise - 0.5) * noise_strength;

        tex *= scanline;
        tex *= flicker;
        tex *= vignette;
        tex += noise;

        tex *= 1.0 - flash_darkness;

        COLOR = vec4(tex, 1.0);
    }
}