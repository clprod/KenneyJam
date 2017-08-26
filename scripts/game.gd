extends Node2D

var counter = 0

func _ready():
	set_process(true)

func _process(delta):
	counter += delta
	if counter >= 1:
		var enemy = load("res://scenes/enemies/enemy_weak.tscn").instance()
		get_node("map/Path2D").add_child(enemy)
		counter = 0