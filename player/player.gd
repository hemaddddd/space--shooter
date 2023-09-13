extends CharacterBody2D

var  speed = 4
var max_speed = 100
var rotate_speed = 0.1

func _physics_process(delta):
	if Input.is_action_pressed("left"):
		rotation = rotation - rotate_speed
	if Input.is_action_pressed("right"):
		rotation = rotation + rotate_speed
	if Input.is_action_pressed("Forward"):
		velocity = velocity + Vector2(0, -speed).rotated(rotation)
	
	position.x = wrapf(position.x, 0, 1152)
	position.y = wrapf(position.y, 0, 648)
	velocity = velocity.normalized() * clamp(velocity.length(), 0, max_speed)
	move_and_slide()
