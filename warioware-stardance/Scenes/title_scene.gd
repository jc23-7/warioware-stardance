extends Control

@export var tutorial_template: PackedScene
@export var big_dipper: Constellation

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_start_pressed() -> void:
	GlobalAudio.button_pressed()
	#get_tree().change_scene_to_file("res://Scenes/timer_screen.tscn")
	
	Global.change_scene("level_select")


func _on_tutorial_pressed() -> void:
	GlobalAudio.button_pressed()
	var tutorial = tutorial_template.instantiate()
	
	add_child(tutorial)


func _on_quit_pressed() -> void:
	GlobalAudio.button_pressed()
	get_tree().quit()
