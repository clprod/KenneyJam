extends "res://scripts/tower_base.gd"

export(float) var fire_show_time = 0.1

onready var fire_node = get_node("canon/fire")

func _process(delta):
	if !fire_node.is_hidden() and shooting_speed - last_shoot >= fire_show_time:
		fire_node.hide()

	var target = get_target()
	if target != null:
		get_node("canon").look_at(target.get_pos())
		shoot(target)

func shoot(target):
	if !can_shoot():
		return

	fire_node.show()
	target.take_damages(shooting_power)
	last_shoot = shooting_speed