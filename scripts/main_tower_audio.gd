
func _ready():
	pass

func playShoot():
	var voice = play("bigshoot")
	set_pitch_scale(voice, rand_range(0.9, 1.1))