extends AnimatedSprite2D

var center_position: Vector2
var right_offset := Vector2(40, 15)

func _ready() -> void:
	if Globalmovement.has_saved_position:
		center_position = Globalmovement.sprite_position
	else:
		center_position = position
		Globalmovement.sprite_position = center_position
		Globalmovement.has_saved_position = true

	# Instantly position the sprite correctly when the scene loads
	var mouse_offset := get_global_mouse_position() - center_position
	position = center_position + right_offset + mouse_offset / 20.0


func _process(delta: float) -> void:
	var mouse_offset := get_global_mouse_position() - center_position
	var target_position := center_position + right_offset + mouse_offset / 20.0

	# Smooth mouse following
	position = position.lerp(target_position, 5.0 * delta)
