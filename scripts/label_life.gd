
var textToDisplay = "Life: "

func _on_player_signal_life( life ):
	get_node("Label").set_text(textToDisplay + str(life))
