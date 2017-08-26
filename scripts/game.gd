extends Node2D

enum GameState {
	BUILDING,
	DEFENDING
}

var counter = 0
var current_state

onready var tower_placer = get_node("player/tower_placer")

func _ready():
	set_state(GameState.BUILDING)
	set_process(true)

func _process(delta):
	if current_state == GameState.BUILDING:
		if Input.is_mouse_button_pressed(BUTTON_LEFT):
			var tower = tower_placer.get_child(0)
			var tower_pos = tower.get_global_pos()
			tower_placer.remove_child(tower)
			get_node("towers").add_child(tower)
			tower.set_global_pos(tower_pos)
			set_state(GameState.DEFENDING)
	elif current_state == GameState.DEFENDING:
		counter -= delta
		if counter <= 0:
			var enemy = load("res://scenes/enemies/enemy_weak.tscn").instance()
			get_node("map/Path2D").add_child(enemy)
			counter = 1

func set_state(state):
	current_state = state
	if current_state == GameState.BUILDING:
		tower_placer.enable()
	elif current_state == GameState.DEFENDING:
		tower_placer.disable()
