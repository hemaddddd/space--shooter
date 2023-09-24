extends CharacterBody2D

var  speed = 4
var max_speed = 100
var rotate_speed = 0.1
var nose = Vector2(0,-60)
var health = 10
var Bullet = load("res://player/bullet.tscn")
var Effects = null
var Explosion = load("res://Effects/explosion.tscn")

func get_input():
	var to_return = Vector2.ZERO
	$Exhaust.hide()
	if Input.is_action_pressed("Forward"):
		to_return += Vector2(0,-1)
		$Exhaust.show()
	if Input.is_action_pressed("left"):
		rotation -= rotate_speed
	if Input.is_action_pressed("right"):
		rotation += rotate_speed
	return to_return.rotated(rotation) 

func _physics_process(_delta):
	velocity += get_input()*speed
	velocity = velocity.normalized() * clamp(velocity.length(), 0, max_speed)
	
	position.x = wrapf(position.x, 0, Global.VP.x)
	position.y = wrapf(position.y, 0, Global.VP.y)
	velocity = velocity.normalized() * clamp(velocity.length(), 0, max_speed)
	
	move_and_slide()
	
	if Input.is_action_just_pressed("shoot"):
		var bullet = Bullet.instantiate()
		bullet.position = position + nose.rotated(rotation)
		bullet.rotation = rotation
		var Effects = get_node_or_null("/root/Game/Effects")
		if Effects != null:
			Effects.add_child(bullet)

func damage(d):
	health = health - d
	if health <= 0:
		Effects = get_node_or_null("/root/Game/Effects")
		if Effects != null:
			var explosion = Explosion.instantiate()
			Effects.add_child(explosion)
			explosion.global_position = global_position
			hide()
			await explosion.anumation_finished
		Global.update_lives(-1)
		queue_free()

func _on_area_2d_body_entered(body):
	if body.name != "player":
		damage(100)
