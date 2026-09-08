extends Control

@export var stories_json: JSON

@onready var parent: Control = $"../"
@onready var title: RichTextLabel = $"VBoxContainer/Title"
@onready var story: RichTextLabel = $"VBoxContainer/MarginContainer/Story"

var selected_constellation
var stories

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parent.level_selected.connect(_on_level_selected)
	
	stories = stories_json.data

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _on_level_selected(constellation_name: String):
	for constellation in Global.constellations:
		if constellation.constellation_name == constellation_name:
			selected_constellation = constellation
			break
	
	title.text = selected_constellation.constellation_name
	if selected_constellation.completed:
		story.text = stories[selected_constellation.constellation_name]
	show()


func _on_button_pressed() -> void:
	parent.start_game.emit(selected_constellation.constellation_name)
