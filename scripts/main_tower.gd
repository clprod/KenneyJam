	extends Node2D

var fire_alternate = true;
export var loading_time = 0.1
var last_time_shoot = 0

func _ready():
	set_process(true)
	set_process_input(true)
	
func _process(delta):
	get_node("Canon").look_at(get_global_mouse_pos())
	
	last_time_shoot -= delta
	if last_time_shoot <= 0:
		if Input.is_mouse_button_pressed(BUTTON_LEFT):
			fire()
			last_time_shoot = loading_time
	else:
		get_node("Canon").get_node("fire_left").set_hidden(true)
		get_node("Canon").get_node("fire_right").set_hidden(true)
	
func fire():
	if fire_alternate : 
		get_node("Canon").get_node("fire_left").set_hidden(false)
		get_node("Canon").get_node("fire_right").set_hidden(true)
		fire_alternate = false
	else :
		get_node("Canon").get_node("fire_left").set_hidden(true)
		get_node("Canon").get_node("fire_right").set_hidden(false) 
		fire_alternate = true
