extends TextureButton

@export var level_info: Control

@export var click_mask: BitMap

@export_group("Uncompleted Textures")
@export var uncompleted_normal: Texture2D
@export var uncompleted_hover: Texture2D
@export var uncompleted_selected: Texture2D

@export_group("Completed Textures")
@export var completed_normal: Texture2D
@export var completed_hover: Texture2D
@export var completed_selected: Texture2D

@export_group("Locked Textures")
@export var locked_normal: Texture2D
@export var locked_hover: Texture2D
@export var locked_selected: Texture2D


var completed = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for constellation in Global.constellations:
		if constellation.constellation_name == str(name):
			if not constellation.unlocked:
				texture_normal = completed_normal
				texture_hover = completed_hover
				texture_pressed = completed_selected
			elif constellation.completed:
				texture_normal = completed_normal
				texture_hover = completed_hover
				texture_pressed = completed_selected
			else:
				texture_normal = uncompleted_normal
				texture_hover = uncompleted_hover
				texture_pressed = uncompleted_selected
			texture_click_mask = click_mask
			break

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_pressed() -> void:
	level_info.level_selected.emit(name)
