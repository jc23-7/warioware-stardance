extends Control

@export var stories_json: JSON
@export var tutorials_json: JSON

@onready var parent: Control = $"../"
@onready var title: RichTextLabel = $"Title"
@onready var story: RichTextLabel = $"StoryTab/StoryText"
@onready var tutorial: RichTextLabel = $"TutorialTab/TutorialText"
@onready var tutorial_control: SubViewportContainer = $"TutorialTab/Tutorial"
@onready var start_game: Button = $StartGame
@onready var tab = $"StoryTab"



@onready var instructions: Control = $"../Instructions"

signal level_selected(constellation_name: String)
signal tutorial_tab(constellation_name: String)

var selected_constellation
var stories
var tutorials

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	instructions.show()
	level_selected.connect(_on_level_selected)
	
	stories = stories_json.data
	tutorials = tutorials_json.data
	
	for child in get_children():
		if child.get_class() == "Control" and child != tab:
			child.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _on_level_selected(constellation_name: String):
	selected_constellation = null
	for constellation in Global.constellations:
		if constellation.constellation_name == constellation_name:
			selected_constellation = constellation
			break
	
	if not selected_constellation:
		title.text = "???"
		story.text = "Constellation coming soon!"
		tutorial.text = "Constellation coming soon!"
		start_game.hide()
	else:
		start_game.show()
		title.text = selected_constellation.constellation_name
		story.text = "Complete the game to unlock the story!"
		if selected_constellation.completed:
			story.text = stories[selected_constellation.constellation_name]
		
		tutorial.text = tutorials[selected_constellation.constellation_name]
	
	_change_tab($StoryTab.get_path())
	show()

func _on_start_game_pressed() -> void:
	GlobalAudio.button_pressed()
	Global.tutorial = false
	for constellation in Global.constellations:
		if constellation.constellation_name == selected_constellation.constellation_name:
			Global.start_constellation(constellation)


func _change_tab(tab_name: NodePath) -> void:
	GlobalAudio.button_pressed()
	if tab:
		tab.hide()
	tab = get_node(tab_name)
	tab.show()
	
	for child in tab.get_children():
		if child is Button and not selected_constellation:
			child.hide()
		else:
			child.show()
	
	if tab.name == "TutorialTab":
		tutorial_tab.emit(selected_constellation.constellation_name)
	
	


func _on_return_to_home() -> void:
	GlobalAudio.button_pressed()
	Global.change_scene("title_scene")
