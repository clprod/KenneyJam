extends Node2D

export(int) var health = 10
export(float) var speed = 10

onready var path_follow = get_parent()
var end_threshold = 5

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	path_follow.set_offset(path_follow.get_offset() + (speed * delta))
	if abs(path_follow.get_offset() - path_follow.get_parent().get_curve().get_baked_length()) <= end_threshold:
		queue_free()
