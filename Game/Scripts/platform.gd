extends Node

var player_pos: Vector2
var rng: RandomNumberGenerator = RandomNumberGenerator.new()
var direction: int = rng.randi_range(-1, 1)
var speed: int = rng.randi_range(20, 100)

# Called when the node enters the scene tree for the first time.
func _ready():
	player_pos = $moving_platform.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	while player_pos.x - 50 < position.x and position.x < player_pos.x + 50:
		position.x += direction * delta * speed

	if position.x >= player_pos.x + 50 or position.x <= player_pos.x - 50:
		direction = -direction
