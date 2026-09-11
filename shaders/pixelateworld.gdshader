shader_type canvas_item;

uniform float change_interval = 0.03;

uniform float pinch : hint_range(-2.0, 2.0) = 0.8;
uniform float curvature : hint_range(0.1, 5.0) = 2.0;
uniform float center_x : hint_range(0.0, 1.0) = 0.5;
uniform float center_y : hint_range(0.0, 1.0) = 0.5;

float random(float x) {
    return fract(sin(x * 12.9898) * 43758.5453);
}

void fragment() {
    float step_time = floor(TIME / change_interval);
    float pixel_amount = floor(random(step_time) * 5.0) + 700.0;

    vec2 center = vec2(center_x, center_y);
    vec2 p = UV - center;

    float dist = length(p);

    float falloff = pow(dist, curvature);

    float warp = 1.0 + pinch * falloff;

    p /= warp;

    vec2 uv = p + center;

    vec2 pixel_uv = floor(uv * pixel_amount) / pixel_amount;

    COLOR = texture(TEXTURE, pixel_uv);
}
