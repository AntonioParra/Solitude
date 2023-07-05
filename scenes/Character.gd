extends CharacterBody2D

signal flee

@export var flee_target: Player
@onready var sprite: Sprite2D = $Sprite2D

const WALK_SPEED = Constants.base_speed
const FLEE_SPEED = WALK_SPEED * 1.25
const FLEE_DISTANCE = 150
const FLEE_DISTANCE_SQUARED = FLEE_DISTANCE * FLEE_DISTANCE

var fleeing: bool = false

func _ready() -> void:
	var sprite_index: int = randi() % 12
	var texture = load("res://assets/img/characters/char" + str(sprite_index) + ".png")
	sprite.texture = texture
	
	start_wandering()
	

func _physics_process(_delta):
	if (flee_target != null) and (flee_target.position - position).length_squared() < FLEE_DISTANCE_SQUARED:
		start_fleeing()
		
	if velocity.length_squared() > 0:
		velocity = velocity.normalized() * get_speed()
		move_and_slide()
		
func get_speed() -> float:
	return WALK_SPEED if not fleeing else FLEE_SPEED
	
func start_wandering() -> void:
	velocity = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	fleeing = false
	
func start_fleeing() -> void:
	velocity = (position - flee_target.position).normalized()
	if velocity.length() == 0:
		velocity = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	fleeing = true
	emit_signal("flee")
