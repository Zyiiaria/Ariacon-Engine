extends Sprite2D

var original_position: Vector2

func _ready():
	original_position = position
	modulate.a = 0.0

	var tween = create_tween()
	tween.set_trans(Tween.TRANS_EXPO)
	tween.set_ease(Tween.EASE_OUT)

	tween.parallel().tween_property(self, "modulate:a", 1.0, 2.0)
	tween.parallel().tween_method(set_brightness, -100.0, -40.0, 2.0)


func _process(delta):
	var mouse_offset = get_global_mouse_position() - original_position
	var target_position = original_position + mouse_offset / 40

	position = position.lerp(target_position, 2.5 * delta)


func set_brightness(value: float):
	material.set_shader_parameter("brightness", value)
