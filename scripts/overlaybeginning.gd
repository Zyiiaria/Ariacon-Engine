extends Sprite2D

func _ready():
	modulate.a = 1.0
	
	await get_tree().create_timer(1.0).timeout
	
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 2.0)
