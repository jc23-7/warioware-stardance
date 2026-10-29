extends Control

@export var title: RichTextLabel
@export var description: RichTextLabel
@export var constellation_container: Control
@export var fail_image: TextureRect

var success

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.minigame_success:
		title.text = "SUCCESS!"
		description.text = "Story collected"
		for child in constellation_container.get_children():
			if str(child.name) == Global.current_constellation.constellation_name:
				child.show()
			else:
				child.hide()
	else:
		title.text = "Failed..."
		description.text = "Better luck next time"
		fail_image.show()
		
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _return_to_levels() -> void:
	GlobalAudio.button_pressed()
	Global.change_scene("level_select")
