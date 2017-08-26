extends Node2D

func _ready():
	var enemy = load("res://scenes/enemies/enemy_weak.tscn").instance()
	get_node("map/Path2D").add_child(enemy)
