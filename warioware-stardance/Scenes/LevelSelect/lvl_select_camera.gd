extends Camera2D

@onready var star_chart: TextureRect = $"../TextureRect"

var prev_pos: Vector2 = Vector2.ZERO
var panning = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			panning = true
			prev_pos = event.position
		else:
			panning = false
	if panning:
		position -= event.position - prev_pos
		prev_pos = event.position
		
		var camera_center = get_viewport_rect().size / 2
		
		position.x = clamp(position.x, star_chart.position.x + camera_center.x, star_chart.position.x+star_chart.size.x - camera_center.x)
		position.y = clamp(position.y, star_chart.position.y + camera_center.y, star_chart.position.y+star_chart.size.y - camera_center.y)
