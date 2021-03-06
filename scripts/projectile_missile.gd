extends KinematicBody2D

var velocity
export(PackedScene) var explosion_scene

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	move(velocity * delta)
	if get_global_pos().x <= 0 or get_global_pos().x >= get_viewport_rect().size.width or get_global_pos().y <= 0 or get_global_pos().y >= get_viewport_rect().size.height:
		queue_free()
	else:
		if is_colliding():
			if get_collider().get_parent().has_method("take_damages"):
				get_collider().get_parent().take_damages(2)
				var explosion = explosion_scene.instance()
				get_node("/root/game").add_child(explosion)
				explosion.set_pos(get_collision_pos())
				queue_free()

func shoot(direction, speed):
	velocity = direction * speed