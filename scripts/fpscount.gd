extends Label

func _ready():
	add_theme_font_override("font", load("res://fonts/Comic Sans MS.ttf"))
	add_theme_font_size_override("font_size", 19)
	modulate.a = 0.3

func _process(_delta):
	var fps = Engine.get_frames_per_second()
	var video_memory = Performance.get_monitor(
		Performance.RENDER_VIDEO_MEM_USED
	) / (512.0 * 512.0)

	text = "FPS: %d\nMemory: %.1f MB" % [fps, video_memory]
