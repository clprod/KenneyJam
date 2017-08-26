extends "res://scripts/tower_base.gd"

export(float) var projectile_speed
export(PackedScene) var projectile_scene

func _process(delta):
	var target = get_target()
	if target != null:
		get_node("canon").look_at(target.get_pos())
		shoot(target)

func shoot(target):
	if !can_shoot():
		return

	last_shoot = shooting_speed
	if projectile_scene != null:
		var projectile = projectile_scene.instance()
		var direction = (target.get_pos() - get_pos()).normalized()
		projectile.shoot(direction, projectile_speed)
		add_child(projectile)
