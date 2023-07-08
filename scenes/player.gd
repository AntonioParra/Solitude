class_name Player extends CharacterBody2D

const SPEED : float = Constants.base_speed
var time_start_moving: int = -1
@onready var sprite: Sprite2D = $Sprite2D
@export var target: Vector2

signal moving

func _ready():
	sprite.scale = Constants.character_scale * 1.25


func _physics_process(_delta):
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		target = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		target = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		target = Vector2.ZERO
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		target = Vector2.ZERO
		
	if target != Vector2.ZERO:
		var direction = target - position
		if direction.length_squared() > 16:
			velocity = direction.normalized() * SPEED
		else:
			velocity = Vector2.ZERO
			
	if velocity.length_squared() > 0:
		velocity = velocity.normalized() * SPEED
		move_and_slide()
		emit_signal("moving")
		if(time_start_moving == -1):
			time_start_moving = Time.get_ticks_msec()
	else:
		time_start_moving = -1
		
	
	if time_start_moving == -1:
		sprite.rotation = 0
	else:
		var time_since_moving: int = Time.get_ticks_msec() - time_start_moving
		sprite.rotation = sin(time_since_moving / 180.0) / 3
		
	
