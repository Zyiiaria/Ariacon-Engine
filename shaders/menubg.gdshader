shader_type canvas_item;

uniform float brightness : hint_range(-100.0, 0.0) = 0.0;

void fragment() {
    vec4 tex = texture(TEXTURE, UV);

    float brightness_normalized = brightness / 100.0;

    tex.rgb += brightness_normalized;

    COLOR = tex;
}