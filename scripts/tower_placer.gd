extends Node2D

export(int) var tile_size

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

func disable():
	set_process(false)