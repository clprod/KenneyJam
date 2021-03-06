extends Node2D

export(int) var shooting_range
export(int) var shooting_power
export(float) var shooting_speed
export(int) var cost

var health = 5
var showing_range = false
var last_shoot = 0

func _ready():
	set_process(true)

func disable():
	set_process(false)

func enable():
	set_process(true)

func _process(delta):
	last_shoot -= delta

func get_target():
	var target = null
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		if enemy.get_global_pos().distance_to(get_global_pos()) <= shooting_range:
			if target == null or target.get_offset() < enemy.get_offset():
				target = enemy
	return target 

func can_shoot():
	return last_shoot <= 0
	
func take_damages(amount):
	health -= amount
	if health < 0:
		queue_free()

func show_range():
	showing_range = true
	update()
func hide_range():
	showing_range = false
	update()

func _draw():
	if showing_range:
		draw_circle(get_pos(), shooting_range, Color(0, 0, 1, 0.3))