extends AnimatedSprite2D
class_name GrabMechanism

@export var parent_minigame: Node2D
@export var default_pos: Vector2
@export var goal_pos: Vector2
@export var move_speed: int

@export var default_frame: int
@export var grab_frame: int
@export var has_object_frame: int

@onready var animation_player: AnimationPlayer = $"AnimationPlayer"
@onready var sprite: AnimatedSprite2D = $"AnimatedSprite2D"

var grab_tween: Tween
var retreat_tween: Tween
var active = false
var has_object = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = default_pos


func grab() -> void:
	if not parent_minigame.game_ended:
		frame = grab_frame
		
		var distance = position.distance_to(goal_pos)
		var length = distance / move_speed
		
		grab_tween = create_tween()
		grab_tween.tween_property(self, "position", goal_pos, length)
		grab_tween.finished.connect(grab_completed)

func grab_completed() -> void:
	frame = has_object_frame
	has_object = true
	retreat()

func retreat() -> void:
	if grab_tween:
		grab_tween.kill()
	var distance = position.distance_to(default_pos)
	var length = distance / move_speed

	retreat_tween = create_tween()
	retreat_tween.tween_property(self, "position", default_pos, length)
	retreat_tween.finished.connect(retreated)

func retreated() -> void:
	active = false
