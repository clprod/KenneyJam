extends Node2D

enum GameState {
	BUILDING,
	DEFENDING
}

var counter = 0
var current_state

onready var tower_placer = get_node("player/tower_placer")

func _ready():
	get_node("ui/buy_menu/ScrollContainer/VBoxContainer/Button").connect("pressed", get_node("player/tower_placer"), "set_tower", ["single_canon"])
	get_node("ui/buy_menu/ScrollContainer/VBoxContainer/Button1").connect("pressed", get_node("player/tower_placer"), "set_tower", ["single_projectile"])
	set_state(GameState.BUILDING)
	set_process_input(true)

func _process(delta):
	counter -= delta
	if counter <= 0:
		var enemy = load("res://scenes/enemies/enemy_fast.tscn").instance()
		get_node("map/Path2D").add_child(enemy)
		counter = 1

func _input(event):
	if event.type == InputEvent.MOUSE_BUTTON and event.is_pressed():
		if current_state == GameState.BUILDING:
			tower_placer.place_tower()
	elif event.type == InputEvent.KEY and event.is_pressed():
		if current_state == GameState.BUILDING:
			set_state(GameState.DEFENDING)
		else:
			set_state(GameState.BUILDING)

func set_state(state):
	current_state = state
	if current_state == GameState.BUILDING:
		set_process(false)
		tower_placer.enable()
		get_node("ui/buy_menu").show()
		get_node("main_tower").disable()
	elif current_state == GameState.DEFENDING:
		set_process(true)
		tower_placer.disable()
		while tower_placer.get_child_count() > 0:
			tower_placer.remove_child(tower_placer.get_child(0))
		get_node("ui/buy_menu").hide()
		get_node("main_tower").enable()
