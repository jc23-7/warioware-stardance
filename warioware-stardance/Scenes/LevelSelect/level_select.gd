extends Control

@onready var level_info: Control = $LevelInfo

signal level_selected(constellation_name: String)
signal start_game(constellation_name: String)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_info.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_game_pressed() -> void:
	for constellation in Global.constellations:
		if constellation.constellation_name == level_info.selected_constellation.constellation_name:
			Global.start_constellation(constellation)
