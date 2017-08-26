extends Node2D

func _ready():
	set_process(true)
	get_node("AnimationPlayer").play("diappear")
	set_rotd(rand_range(0, 360))
	get_node("/root/game/Camera2D").shake(0.3, 100, 3)

func _process(delta):
	if not get_node("AnimationPlayer").is_playing():
		queue_free()
