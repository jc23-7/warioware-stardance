extends Node2D
signal collectable_collected()

@onready var player: CharacterBody2D = $"../Player"
@onready var self_area = $Area2D
@onready var player_area = $"../Player/Area2D"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += 250 * delta
	position.x += -50 * delta
	
	if player_area.overlaps_area(self_area) && position.y <= 225 && position.y >= 200:
		if self.visible:
			emit_signal("collectable_collected")
			queue_free() 
			
