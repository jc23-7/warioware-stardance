extends Control

@export var score: RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score.text = str(Global.minigames_done)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_home_pressed() -> void:
	GlobalAudio.button_pressed()
	Global.change_scene("title_scene")


func _on_quit_pressed() -> void:
	GlobalAudio.button_pressed()
	get_tree().quit()


func _on_survival_pressed() -> void:
	GlobalAudio.button_pressed()
	Global.start_survival()
