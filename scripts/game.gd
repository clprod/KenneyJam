extends Node2D

enum GameState {
	BUILDING,
	DEFENDING
}

export(int) var base_wave_number
export var enemy_scenes_names = StringArray()
export var initial_spawn_rate = FloatArray()
export var final_spawn_rate = FloatArray()
var current_spawn_rate = FloatArray()

var time_to_spawn = 1
var current_wave = 1
var enemy_to_spawn = 10

export (Texture) var cursor_picking
export (Texture) var cursor_reticle

var counter = 0
var current_state

onready var tower_placer = get_node("player/tower_placer")

func _ready():
	get_node("ui/buy_menu/ScrollContainer/VBoxContainer/Button").connect("pressed", get_node("player/tower_placer"), "set_tower", ["single_canon"])
	get_node("ui/buy_menu/ScrollContainer/VBoxContainer/Button1").connect("pressed", get_node("player/tower_placer"), "set_tower", ["single_projectile"])
	set_state(GameState.DEFENDING)
	get_node("ui/wave_announcement").set_wave(current_wave)
	set_process_input(true)
	current_spawn_rate = initial_spawn_rate

func _process(delta):
	if enemy_to_spawn == 0:
		if get_tree().get_nodes_in_group("enemies").size() == 0:
			set_state(GameState.BUILDING)
		return
	counter -= delta
	if counter <= 0:
		var rand = rand_range(0, 100)
		var rate = 0
		for i in range(current_spawn_rate.size()):
			rate += current_spawn_rate[i]
			if rand <= rate:
				var enemy = load("res://scenes/enemies/" + enemy_scenes_names[i] + ".tscn").instance()
				get_node("map/Path2D").add_child(enemy)
				break
		counter = time_to_spawn
		enemy_to_spawn -= 1

func next_wave():
	current_wave += 1
	enemy_to_spawn = current_wave * 10
	time_to_spawn -= time_to_spawn/10
	for i in range(current_spawn_rate.size()):
		current_spawn_rate[i] += (final_spawn_rate[i] - initial_spawn_rate[i]) / (base_wave_number - 1)
	set_state(GameState.DEFENDING)
	get_node("ui/wave_announcement").set_wave(current_wave)

func _input(event):
	if event.type == InputEvent.MOUSE_BUTTON and event.is_pressed():
		if current_state == GameState.BUILDING:
			tower_placer.place_tower()
	elif event.type == InputEvent.KEY and event.is_pressed():
		if current_state == GameState.BUILDING:
			next_wave()
		else:
			set_state(GameState.BUILDING)

func set_state(state):
	current_state = state
	if current_state == GameState.BUILDING:
		set_process(false)
		tower_placer.enable()
		get_node("ui/buy_menu").show()
		get_node("main_tower").disable()
		get_node("/root/cursor").set_as_hand(cursor_picking)
	elif current_state == GameState.DEFENDING:
		set_process(true)
		tower_placer.disable()
		while tower_placer.get_child_count() > 0:
			tower_placer.remove_child(tower_placer.get_child(0))
		get_node("ui/buy_menu").hide()
		get_node("main_tower").enable()
		get_node("/root/cursor").set_as_reticle(cursor_reticle)
		counter = 2

func on_death():
	get_node("/root/cursor").set_as_hand(cursor_picking)
	get_tree().change_scene("res://scenes/ui/defeat_menu.tscn")
