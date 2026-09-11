extends Sprite2D

func _ready() -> void:
	await get_tree().create_timer(1.0).timeout

	var tween := create_tween()
	tween.set_trans(Tween.TRANS_EXPO)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position:y", 175.0, 2.0)
