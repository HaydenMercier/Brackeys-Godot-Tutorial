extends Node2D


var tween
var distance = 100
var time = 2
var initial_position
var target_position

func _ready():

	tween = Tween.new()
	add_child(tween)
	

	initial_position = position
	target_position = initial_position + Vector2(distance, 0)
	

	move_platform()

func move_platform():

	tween.interpolate_property(self, "position", initial_position, target_position, time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	

	tween.connect("tween_completed", self, "on_tween_completed")

func on_tween_completed(object, key):

	var temp = initial_position
	initial_position = target_position
	target_position = temp
	

	move_platform()
