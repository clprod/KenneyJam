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

func _process(delta):
	counter -= delta
	if counter <= 0:
		var enemy = load("res://scenes/enemies/enemy_weak.tscn").instance()
		get_node("map/Path2D").add_child(enemy)
		counter = 1

func _input(event):
	if event.type == InputEvent.MOUSE_BUTTON and event.is_pressed():
		if tower_placer.get_child_count() == 0:
			return
		var tower = tower_placer.get_child(0)
		var tower_pos = tower.get_global_pos()
		tower_placer.remove_child(tower)
		get_node("towers").add_child(tower)
		tower.set_global_pos(tower_pos)
	elif event.type == InputEvent.KEY and event.is_pressed():
		set_state(GameState.DEFENDING)

func set_state(state):
	current_state = state
	if current_state == GameState.BUILDING:
		set_process(false)
		set_process_input(true)
		tower_placer.enable()
		get_node("Main tower").disable()
	elif current_state == GameState.DEFENDING:
		set_process(true)
		set_process_input(false)
		tower_placer.disable()
		while tower_placer.get_child_count() > 0:
			tower_placer.remove_child(tower_placer.get_child(0))
		get_node("Main tower").enable()
