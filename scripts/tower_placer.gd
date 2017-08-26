extends Node2D

export(int) var tile_size
export(NodePath) var tower_parent

func _process(delta):
	var pos = get_global_mouse_pos()
	pos /= tile_size
	pos.x = floor(pos.x)
	pos.y = floor(pos.y)
	pos *= tile_size
	pos += Vector2(tile_size, tile_size)/2
	set_pos(pos)

func enable():
	set_process(true)
	show()

func disable():
	set_process(false)
	hide()

func place_tower():
	if get_child_count() == 0:
		return
	var tower = get_child(0)
	remove_child(tower)
	get_node(tower_parent).add_child(tower)
	tower.set_pos(get_pos())
	tower.set_scale(Vector2(1, 1))

func set_tower(tower_file):
	if get_child_count() == 1:
		remove_child(get_child(0))
	
	var tower = load("res://scenes/towers/" + tower_file + ".tscn").instance()
	add_child(tower)
	tower.set_scale(Vector2(1.2, 1.2))