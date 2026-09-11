extends Node2D

func _ready():
	if Global.game_has_been_entered:
		$beginning.queue_free()
		$overlay.queue_free()

func _exit_tree():
	Global.game_has_been_entered = true
