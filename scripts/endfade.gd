extends ColorRect

@export var fade_duration: float = 1.0

func _ready() -> void:
	self.color.a = 1.0
	
	var tween := create_tween()
	tween.tween_property(self, "color:a", 0.0, fade_duration)
