extends Node2D

@export var constellations: Array[Constellation]
signal level_selected(constellation_name: String)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_selected.connect(_on_level_selected)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_level_selected(constellation_name: String):
	for constellation in constellations:
		if constellation.constellation_name == constellation_name:
			Global.start_constellation(constellation)
