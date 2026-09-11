extends Node

@onready var train = $train

func _ready():
	get_tree().scene_changed.connect(_on_scene_changed)
	_update_train()

func _on_scene_changed():
	_update_train()

func _update_train():
	var current_scene = get_tree().current_scene

	if current_scene and current_scene.name == "game":
		train.show()
	else:
		train.hide()
