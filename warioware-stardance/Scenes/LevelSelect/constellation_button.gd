extends TextureButton

@onready var level_select: Node2D = $"../../../../"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var index = 0
	for constellation in Global.constellations:
		if constellation.constellation_name == name:
			break
		index += 1
	
	disabled = Global.completed_constellations[index]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_pressed() -> void:
	level_select.level_selected.emit(name)
