extends TextureButton

@onready var level_select: Control = $"../../../../"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_pressed() -> void:
	level_select.level_selected.emit(name)
