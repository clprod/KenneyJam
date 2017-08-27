
func _ready():
	pass

func onDeathSound():
	play(String(randi()%2+1))
