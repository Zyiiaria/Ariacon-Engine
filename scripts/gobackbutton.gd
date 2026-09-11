extends TouchScreenButton

@onready var hover_control: Control = $selectWindow


func _ready() -> void:
	hover_control.mouse_entered.connect(_on_mouse_entered)
	hover_control.mouse_exited.connect(_on_mouse_exited)
	$gobackButton.hide()

func _on_mouse_entered() -> void:
	self_modulate = Color(1.2, 1.2, 1.2, 1.0)


func _on_mouse_exited() -> void:
	self_modulate = Color.WHITE
