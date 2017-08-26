extends Node2D

export(int) var shooting_range
export(int) var shooting_power
export(float) var shooting_speed
export(int) var cost

func _ready():
	set_process(true)

func _process(delta):
	var enemies = get_tree().get_nodes_in_group("enemies")
	var target = null
	for enemy in enemies:
		if enemy.get_global_pos().distance_to(get_global_pos()) <= shooting_range:
			if target == null or target.get_offset() < enemy.get_offset():
				target = enemy

	if target != null:
		get_node("canon").look_at(target.get_global_pos())
