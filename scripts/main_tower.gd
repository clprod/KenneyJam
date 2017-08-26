extends Node2D

func _ready():
	set_process(true)
	
func _process(delta):
	get_node("Canon").look_at(get_global_mouse_pos())
