extends Label

func _process(_delta):
	add_theme_font_override("font", load("res://fonts/Comic Sans MS.ttf"))
	add_theme_font_size_override("font_size", 14)
	text = "Ariacon Engine v0.1.0"
	modulate.a = 0.3
