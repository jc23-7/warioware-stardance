extends MinigameManager

@onready var line_container: Node2D = $LineContainer
signal star_clicked (star:int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	for line in line_container.get_children():
		line.hide()
