extends Node2D

export(int) var shooting_range
export(int) var shooting_power
export(float) var shooting_speed
export(int) var cost

func _ready():
	set_process(true)

func _process(delta):
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		pass
