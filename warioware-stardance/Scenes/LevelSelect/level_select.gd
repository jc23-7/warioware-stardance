extends Node2D



signal level_selected(constellation_name: String)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_selected.connect(_on_level_selected)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_level_selected(constellation_name: String):
	for constellation in Global.constellations:
		if constellation.constellation_name == constellation_name:
			Global.start_constellation(constellation)
