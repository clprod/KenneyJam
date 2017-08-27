
var textToDisplay = "Life: "

func _on_player_health_changed( health ):
	get_node("Label").set_text(textToDisplay + str(health))
	if (health == 0):
		get_node("/root/game/Camera2D").shake(0.1, 100, 100)
	else:
		get_node("/root/game/Camera2D").shake(0.1, 100, 20 - health*2)