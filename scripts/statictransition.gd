extends Node

const SOUND_PATH := "res://sounds/camera_sound.wav"
const FADE_DURATION := 0.3
const FLASH_DELAY := 0.05

var has_entered_game := false
var audio_player: AudioStreamPlayer


func _ready() -> void:
	audio_player = AudioStreamPlayer.new()
	audio_player.stream = load(SOUND_PATH)
	audio_player.volume_db = 0.0
	add_child(audio_player)

	get_tree().scene_changed.connect(_on_scene_changed)

	call_deferred("_handle_current_scene")


func _handle_current_scene() -> void:
	var scene := get_tree().current_scene

	if scene == null:
		return

	_handle_scene(scene)


func _on_scene_changed() -> void:
	var scene := get_tree().current_scene

	if scene == null:
		return

	_handle_scene(scene)


func _handle_scene(scene: Node) -> void:
	var scene_path := scene.scene_file_path

	var is_game := scene_path == "res://scenes/game.tscn"
	var is_camera := scene_path == "res://scenes/camera.tscn"

	if not is_game and not is_camera:
		return

	var static_sprite := scene.find_child(
		"static",
		true,
		false
	) as AnimatedSprite2D

	if static_sprite == null:
		push_warning("its not here bro")
		return

	static_sprite.play()
	static_sprite.modulate.a = 0.0

	if is_game and not has_entered_game:
		has_entered_game = true
		return

	_play_effect(static_sprite)


func _play_effect(static_sprite: AnimatedSprite2D) -> void:
	if audio_player.playing:
		audio_player.stop()

	static_sprite.modulate.a = 1.0

	audio_player.play()

	var tween := create_tween()

	tween.tween_interval(FLASH_DELAY)

	tween.tween_property(
		static_sprite,
		"modulate:a",
		0.0,
		FADE_DURATION
	)
