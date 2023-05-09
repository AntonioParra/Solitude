extends CharacterBody2D

signal moving

const SPEED : float = Constants.base_speed

@onready var sprite: Sprite2D = $Sprite2D

func _ready():
	sprite.scale = Constants.character_scale * 1.25


func _physics_process(_delta):
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1

	if velocity.length_squared() > 0:
		velocity = velocity.normalized() * SPEED
		move_and_slide()
		emit_signal("moving")
