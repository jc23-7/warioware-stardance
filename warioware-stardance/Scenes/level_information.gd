extends Control

@export var stories_json: JSON

@onready var parent: Control = $"../"
@onready var title: RichTextLabel = $"Title"
@onready var story: RichTextLabel = $"StoryTab/StoryText"
@onready var tutorial: RichTextLabel = $"TutorialTab/TutorialText"
@onready var tab = $"StoryTab"


signal level_selected(constellation_name: String)
signal tutorial_tab(constellation_name: String)

var selected_constellation
var stories

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	level_selected.connect(_on_level_selected)
	
	stories = stories_json.data
	
	for child in get_children():
		if child.get_class() == "Control" and child != tab:
			child.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _on_level_selected(constellation_name: String):
	for constellation in Global.constellations:
		if constellation.constellation_name == constellation_name:
			selected_constellation = constellation
			break
	
	if not selected_constellation.unlocked:
		title.text = "???"
		story.text = "Constellation locked"
		tutorial.text = "Constellation locked"
	else:
		title.text = selected_constellation.constellation_name
		if selected_constellation.completed:
			story.text = stories[selected_constellation.constellation_name]
	show()

func _on_start_game_pressed() -> void:
	Global.tutorial = false
	for constellation in Global.constellations:
		if constellation.constellation_name == selected_constellation.constellation_name:
			Global.start_constellation(constellation)


func _change_tab(tab_name: NodePath) -> void:
	if tab:
		tab.hide()
	tab = get_node(tab_name)
	tab.show()
	
	if tab.name == "TutorialTab":
		tutorial_tab.emit(selected_constellation.constellation_name)
	
	
