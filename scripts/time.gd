extends Node

const HOUR_DURATION := 60.0
const BLACK_FADE_DURATION := 3.0
const CLOCK_FADE_DURATION := 1.0

var current_hour := 12
var elapsed := 0.0
var timer_started := false
var fading_to_black := false
var fading_clock := false
var game_started_once := false

@onready var clock: Label = $canvaspos/clock
@onready var black: ColorRect = $canvaspos/black


func _ready() -> void:
	clock.add_theme_font_override("font", load("res://fonts/LCDSolid.ttf"))
	clock.add_theme_font_size_override("font_size", 32)

	clock.text = "12 AM"
	clock.modulate.a = 1.0

	clock.anchor_left = 1.0
	clock.anchor_right = 1.0
	clock.anchor_top = 0.0
	clock.anchor_bottom = 0.0

	clock.offset_left = -170.0
	clock.offset_right = -20.0
	clock.offset_top = 20.0
	clock.offset_bottom = 70.0

	clock.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT

	black.color = Color(0.0, 0.0, 0.0, 0.0)
	black.mouse_filter = Control.MOUSE_FILTER_IGNORE
	black.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	black.z_index = 100

	check_scene()


func _process(delta: float) -> void:
	check_scene()

	if not timer_started or fading_to_black:
		return

	elapsed += delta

	if elapsed >= HOUR_DURATION:
		elapsed -= HOUR_DURATION
		advance_hour()


func check_scene() -> void:
	var scene := get_tree().current_scene

	if scene == null:
		return

	var scene_name := scene.name.to_lower()

	if scene_name == "game":
		clock.show()

		if not game_started_once:
			start_timer()
			game_started_once = true

	elif scene_name == "camera":
		clock.show()

		if not timer_started:
			timer_started = true

	elif scene_name == "endnight":
		clock.hide()
		timer_started = false

	else:
		clock.hide()
		timer_started = false


func advance_hour() -> void:
	if current_hour == 12:
		current_hour = 1
	else:
		current_hour += 1

	clock.text = str(current_hour) + " AM"

	if current_hour == 6:
		timer_started = false
		fade_to_black()


func fade_to_black() -> void:
	if fading_to_black:
		return

	fading_to_black = true

	black.color = Color(0.0, 0.0, 0.0, 0.0)
	black.mouse_filter = Control.MOUSE_FILTER_STOP

	var tween := create_tween()
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.set_ease(Tween.EASE_IN_OUT)

	tween.tween_property(
		black,
		"color:a",
		1.0,
		BLACK_FADE_DURATION
	)

	await tween.finished

	black.queue_free()

	await get_tree().process_frame

	get_tree().change_scene_to_file("res://scenes/endnight.tscn")


func fade_clock() -> void:
	if fading_clock:
		return

	fading_clock = true

	var tween := create_tween()

	tween.tween_property(
		clock,
		"modulate:a",
		0.0,
		CLOCK_FADE_DURATION
	)


func start_timer() -> void:
	timer_started = true
	current_hour = 12
	elapsed = 0.0
	fading_to_black = false
	fading_clock = false

	clock.show()
	clock.modulate.a = 1.0
	clock.text = "12 AM"

	black.color = Color(0.0, 0.0, 0.0, 0.0)
	black.mouse_filter = Control.MOUSE_FILTER_IGNORE
