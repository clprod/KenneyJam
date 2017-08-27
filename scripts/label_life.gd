
var textToDisplay = "Life: "

func _on_player_health_changed( health ):
	get_node("Label").set_text(textToDisplay + str(health))
