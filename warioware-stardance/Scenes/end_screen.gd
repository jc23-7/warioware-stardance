extends Control

@onready var fail: Control = $Fail
@onready var success: Control = $Success


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.lives == 0:
		fail.show()
		success.hide()
	else:
		fail.hide()
		success.show()
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_home_pressed() -> void:
	GlobalAudio.button_pressed()
	Global.change_scene("res://Scenes/title_scene.tscn")


func _on_quit_pressed() -> void:
	GlobalAudio.button_pressed()
	get_tree().quit()
