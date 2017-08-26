	extends Node2D

var fire_alternate = true;
export var loading_time = 0.1
var last_time_shoot = 0
var isDisabled = false

export(float) var projectile_speed
export(PackedScene) var projectile_scene

func _ready():
	set_process(true)
	set_process_input(true)
	
func disable():
	isDisabled = true
func enable():
	isDisabled = false
	
func _process(delta):
	if isDisabled:
		return
	
	get_node("Canon").look_at(get_global_mouse_pos())
	
	last_time_shoot -= delta
	if last_time_shoot <= 0:
		if Input.is_mouse_button_pressed(BUTTON_LEFT):
			fire()
			last_time_shoot = loading_time
	else:
		get_node("Canon").get_node("fire_left").set_hidden(true)
		get_node("Canon").get_node("fire_right").set_hidden(true)


func shootProjectileFrom(canon):
	var projectile = projectile_scene.instance()
	var direction = (get_global_mouse_pos() - get_global_pos()).normalized()
	projectile.shoot(direction, projectile_speed)
	get_node("Base").add_child(projectile)
	projectile.look_at(get_pos() + direction)
	projectile.set_global_pos(canon.get_global_pos())
	
func fire():
	# Canon Animation
	if fire_alternate : 
		get_node("Canon").get_node("fire_left").set_hidden(false)
		get_node("Canon").get_node("fire_right").set_hidden(true)
		shootProjectileFrom(get_node("Canon").get_node("fire_left"))
		fire_alternate = false
	else :
		get_node("Canon").get_node("fire_left").set_hidden(true)
		get_node("Canon").get_node("fire_right").set_hidden(false)
		shootProjectileFrom(get_node("Canon").get_node("fire_right")) 
		fire_alternate = true
