extends Sprite

export (Texture) var cursor_picking
export (Texture) var cursor_reticle
var offset = Vector2()

func _ready():
	set_process(true)
	set_z(100)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	set_as_hand()

func _process(delta):
	set_pos(get_global_mouse_pos() - offset)

func set_as_hand():
	set_texture(cursor_picking)
	offset = -get_texture().get_size()/2

func set_as_reticle():
	set_texture(cursor_reticle)
	offset = Vector2()