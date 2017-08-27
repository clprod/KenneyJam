extends Node2D

export(int) var tile_size
export(NodePath) var tower_parent
export(PackedScene) var smoke_scene
export(PackedScene) var spent_scene

func _process(delta):
	var pos = get_global_mouse_pos()
	pos /= tile_size
	pos.x = floor(pos.x)
	pos.y = floor(pos.y)
	pos *= tile_size
	pos += Vector2(tile_size, tile_size)/2
	set_pos(pos)
	
	if get_child_count() == 0:
		return
	if is_place_valid():
		set_tower_modulate(Color(0, 1, 0, 0.5))
	else:
		set_tower_modulate(Color(1, 0, 0, 0.5))

func is_place_valid():
	var map = get_node("/root/game/map/TileMap")
	if not map.get_cellv(get_pos()/tile_size) == 2:
		return false
	for tower in get_tree().get_nodes_in_group("towers"):
		if tower.get_pos() == get_pos():
			return false
	return true

func set_tower_modulate(color):
	var tower = get_child(0)
	for child in tower.get_children():
 		if( child.get_type() == "Sprite" ): child.set_modulate(color)

func enable():
	set_process(true)
	show()

func disable():
	set_process(false)
	hide()

func place_tower():
	if get_child_count() == 0:
		return
	if not is_place_valid():
		return
	var tower = get_child(0)
	set_tower_modulate(Color(1, 1, 1, 1))
	remove_child(tower)
	get_node(tower_parent).add_child(tower)
	get_parent().remove_money(tower.cost)
	tower.set_pos(get_pos())
	tower.set_scale(Vector2(1, 1))
	tower.enable()
	tower.hide_range()
	var smoke = smoke_scene.instance()
	tower.add_child(smoke)
	get_node("/root/game/Camera2D").shake(0.3, 100, 3)
	var spent = spent_scene.instance()
	spent.set_value(-tower.cost)
	get_node("/root/game/ui").add_child(spent)
	spent.set_pos(get_pos())

func set_tower(tower_file):
	if get_child_count() == 1:
		remove_child(get_child(0))
	
	var tower = load("res://scenes/towers/" + tower_file + ".tscn").instance()
	get_node("SamplePlayer").onSelect()
	add_child(tower)
	tower.set_scale(Vector2(1.2, 1.2))
	tower.show_range()
	tower.disable()
	
	