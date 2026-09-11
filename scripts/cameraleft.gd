extends TouchScreenButton

@onready var camerabg: AnimatedSprite2D = $"../camerabg"

var camera_switch_sound: AudioStreamPlayer
var brightness_tween: Tween

func _ready() -> void:
	camera_switch_sound = AudioStreamPlayer.new()
	camera_switch_sound.stream = load("res://sounds/camera_switch.wav")
	add_child(camera_switch_sound)

	var material := camerabg.material as ShaderMaterial
	if material:
		material.set_shader_parameter("flash_brightness", 0.0)

func _pressed() -> void:
	camera_switch_sound.play()

	var frame_count := camerabg.sprite_frames.get_frame_count(camerabg.animation)

	if frame_count > 0:
		camerabg.frame = posmod(camerabg.frame - 1, frame_count)

	flash_camera()

func flash_camera() -> void:
	var material := camerabg.material as ShaderMaterial

	if material == null:
		push_warning("camerabg does not have a ShaderMaterial.")
		return

	if brightness_tween:
		brightness_tween.kill()

	material.set_shader_parameter("flash_darkness", 1.0)

	brightness_tween = create_tween()
	brightness_tween.set_trans(Tween.TRANS_EXPO)
	brightness_tween.set_ease(Tween.EASE_OUT)

	brightness_tween.tween_method(
		func(value: float):
			material.set_shader_parameter("flash_darkness", value),
		1.0,
		0.0,
		0.5
	)

func _on_mouse_entered() -> void:
	self_modulate = Color(1.2, 1.2, 1.2, 1.0)

func _on_mouse_exited() -> void:
	self_modulate = Color.WHITE
