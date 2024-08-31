extends Area2D

@export var Text: String
var timer: int = 0.0
var timer_active: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$Text.text = Text
	$Text.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timer_active:
		timer += delta
	if timer > 0.1:
		timer_active = false
		$Text.visible = false
		timer = 0



func _on_body_entered(body):
	if not $Text.visible:
		$Text.visible = true
		timer_active = true
	
