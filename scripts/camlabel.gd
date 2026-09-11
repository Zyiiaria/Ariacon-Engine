extends Label

@onready var camera_bg: AnimatedSprite2D = get_node("../camerabg")

func _ready() -> void:
	add_theme_font_override("font", load("res://fonts/LCDSolid.ttf"))
	add_theme_font_size_override("font_size", 75)
	horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	size.x = get_viewport_rect().size.x
	position.x = 0
	position.y = 35
	update_camera_number()

func _process(_delta: float) -> void:
	size.x = get_viewport_rect().size.x
	update_camera_number()

func update_camera_number() -> void:
	var camera_number := camera_bg.frame + 1
	text = "CAM %d" % camera_number
