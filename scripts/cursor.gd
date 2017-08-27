extends Sprite

var offset = Vector2()

func _ready():
	set_process(true)
	set_z(100)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(delta):
	set_pos(get_global_mouse_pos() - offset)

func set_as_hand(texture):
	set_texture(texture)
	offset = -get_texture().get_size()/2

func set_as_reticle(texture):
	set_texture(texture)
	offset = Vector2()