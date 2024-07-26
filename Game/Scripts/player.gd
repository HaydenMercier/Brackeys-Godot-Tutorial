extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -320.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var can_coyote_jump = false

@onready var animated_sprite = $AnimatedSprite2D
@onready var coyote_timer = $CoyoteTimer

func _ready():
	return

func _physics_process(delta):
	if not is_on_floor() && !can_coyote_jump:
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump"):
		if can_coyote_jump || is_on_floor():
			velocity.y = JUMP_VELOCITY
			if can_coyote_jump:
				can_coyote_jump = false

	var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	print("Direction: ", direction)  # Debug statement to check direction input

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
		animated_sprite.play("jump")

	velocity.x = direction * SPEED

	print("Velocity X: ", velocity.x)  # Debug statement to check velocity

	move_and_slide()

	var was_on_floor = is_on_floor()
	if was_on_floor && !is_on_floor():
		coyote_timer.start()
		can_coyote_jump = true

func teleport_to_spawn_point():
	if $SpawnPoint:
		position = $SpawnPoint.global_position
		velocity = Vector2.ZERO

func _on_coyote_timer_timeout():
	can_coyote_jump = false
