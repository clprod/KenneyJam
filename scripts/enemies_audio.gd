
func _ready():
	pass

func onDeathSound():
	play(str(randi()%3+1))
