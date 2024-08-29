extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -320.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite = $AnimatedSprite2D
@onready var coyote_timer = $CoyoteTimer

func _ready():
	teleport_to_spawn_point()
	velocity.x = 0
	velocity.y = 0

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

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
			animated_sprite.play("jump")

	velocity.x = direction * SPEED

	move_and_slide()

func teleport_to_spawn_point():
	if $SpawnPoint:
		position = $SpawnPoint.global_position
		velocity = Vector2.ZERO
