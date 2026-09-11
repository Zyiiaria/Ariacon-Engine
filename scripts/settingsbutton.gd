extends TouchScreenButton

@onready var hover_control: Control = $selectWindow


func _ready() -> void:
	hover_control.mouse_entered.connect(_on_mouse_entered)
	hover_control.mouse_exited.connect(_on_mouse_exited)

	await get_tree().create_timer(1.8).timeout

	var tween := create_tween()
	tween.set_trans(Tween.TRANS_EXPO)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position:y", 925.0, 2.0)


func _on_mouse_entered() -> void:
	self_modulate = Color(1.2, 1.2, 1.2, 1.0)


func _on_mouse_exited() -> void:
	self_modulate = Color.WHITE
