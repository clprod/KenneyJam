extends Node2D

var left = true;

func _ready():
	set_process(true)
	set_process_input(true)
	get_node("Canon").get_node("fire_left").set_hidden(true)
	get_node("Canon").get_node("fire_right").set_hidden(true)
	
func _process(delta):
	get_node("Canon").look_at(get_global_mouse_pos())
	
func _input(event):
	if event.is_action_pressed("left_click"): 
		if left : 
			get_node("Canon").get_node("fire_left").set_hidden(false)
			get_node("Canon").get_node("fire_right").set_hidden(true)
			left = false
		else :
			get_node("Canon").get_node("fire_left").set_hidden(true)
			get_node("Canon").get_node("fire_right").set_hidden(false) 
			left = true
	