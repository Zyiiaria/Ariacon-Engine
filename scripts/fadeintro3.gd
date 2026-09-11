extends Sprite2D

func _ready():
	modulate.a = 0.0
	
	var tween = create_tween()
	tween.tween_interval(8.5)
	tween.tween_property(self, "modulate:a", 1.0, 2.0)
	tween.tween_interval(1.0)
	tween.tween_property(self, "modulate:a", 0.0, 2.0)
