extends AudioStreamPlayer

const NORMAL_VOLUME_DB := 3.0


func _ready() -> void:
	get_tree().scene_changed.connect(_check_scene)
	call_deferred("_check_scene")


func _check_scene() -> void:
	var scene := get_tree().current_scene

	if scene == null:
		return

	var scene_name := scene.name.to_lower()

	if scene_name == "game" or scene_name == "camera":
		volume_db = NORMAL_VOLUME_DB

		if not playing:
			play()
	else:
		stop()
		volume_db = NORMAL_VOLUME_DB
