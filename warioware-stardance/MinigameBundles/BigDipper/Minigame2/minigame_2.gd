extends MinigameManager

@export var star_template: PackedScene
@onready var star_bucket_animation: AnimatedSprite2D = $"StarBucket/Animation"
signal star_spot_clicked(x: float, y:float)
signal bucket_clicked
var star_picked_up = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	bucket_clicked.connect(_on_star_picked_up)



func _on_star_picked_up() -> void:
	if not game_ended:
		star_picked_up = true
		var star = star_template.instantiate()
		
		star_spot_clicked.connect(star._on_star_spot_clicked)
		
		add_child(star)
		
		star_bucket_animation.frame = completed_points + 1
