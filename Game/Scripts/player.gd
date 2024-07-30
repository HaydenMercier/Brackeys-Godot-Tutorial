extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -320.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var can_coyote_jump = false
var is_jumping = false

@onready var animated_sprite = $AnimatedSprite2D
@onready var coyote_timer = $CoyoteTimer

func _physics_process(delta):
	if is_on_floor():
		can_coyote_jump = true
		is_jumping = false
	else:
		if is_jumping:
			velocity.y += gravity * delta
		else:
			velocity.y += gravity * delta 

	if Input.is_action_just_pressed("jump"):
		if (can_coyote_jump or coyote_timer.time_left > 0) and not is_jumping:
			velocity.y = JUMP_VELOCITY
			is_jumping = true
			can_coyote_jump = false
			coyote_timer.start()

	var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")

	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		if is_jumping:
			animated_sprite.play("jump")
		else:
			animated_sprite.play("fall")

	velocity.x = direction * SPEED

	print("Velocity X: ", velocity.x)

	move_and_slide()

func teleport_to_spawn_point():
	if $SpawnPoint:
		position = $SpawnPoint.global_position
		velocity = Vector2.ZERO

func _on_coyote_timer_timeout():
	can_coyote_jump = false
