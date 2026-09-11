extends Node

var click_sound = preload("res://sounds/click_normal.wav")
var click_player: AudioStreamPlayer

func _ready():
	$credits_ashicon.hide()
	$credits_cibiicon.hide()
	$credits_zyiiicon.hide()
	$credits_ash.hide()
	$credits_cibi.hide()
	$credits_zyii.hide()
	$gobackButton.hide()
	$settingsText.hide()
	$creditsbutton.pressed.connect(_on_creditsbutton_pressed)
	$settingsbutton.pressed.connect(_on_settingsbutton_pressed)
	$gobackButton.pressed.connect(_on_gobackbutton_pressed)
	click_player = AudioStreamPlayer.new()
	click_player.stream = click_sound
	add_child(click_player)

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		click_player.play()

func _on_settingsbutton_pressed():
	$title.hide()
	$playbutton.hide()
	$settingsbutton.hide()
	$creditsbutton.hide()
	$gobackButton.show()
	$settingsText.show()
	
func _on_creditsbutton_pressed():
	$title.hide()
	$playbutton.hide()
	$settingsbutton.hide()
	$creditsbutton.hide()
	$gobackButton.show()
	$credits_ashicon.show()
	$credits_cibiicon.show()
	$credits_zyiiicon.show()
	$credits_ash.show()
	$credits_cibi.show()
	$credits_zyii.show()
	
func _on_gobackbutton_pressed():
	$title.show()
	$playbutton.show()
	$settingsbutton.show()
	$creditsbutton.show()
	$gobackButton.hide()
	$credits_ashicon.hide()
	$credits_cibiicon.hide()
	$credits_zyiiicon.hide()
	$credits_ash.hide()
	$credits_cibi.hide()
	$credits_zyii.hide()
	$settingsText.hide()
