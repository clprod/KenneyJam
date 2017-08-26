extends Node2D

export(int) var health = 10
export(float) var speed = 10

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	get_parent().set_offset(get_parent().get_offset() + (speed * delta))
