extends CharacterBody2D

@export var flee_targer: Player

const WALK_SPEED = Constants.base_speed
const FLEE_SPEED = WALK_SPEED * 1.25

var state: string


func _physics_process(delta):
	
	if velocity.length_squared() > 0:
		velocity = velocity.normalized() * get_speed()
		move_and_slide()
		
func get_speed() -> float:
	return WALK_SPEED
