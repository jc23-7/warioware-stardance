extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var x = (get_viewport_rect().size.x - (160 * 4))/2
	for child in get_children():
		if String(child.name)[-1].to_int() <= Global.lives:
			child.frame = 0
		else:
			child.frame = 1
		
		child.global_position.y = 0
		child.global_position.x = x;
		x += 160
	global_position.y = 200


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
				
