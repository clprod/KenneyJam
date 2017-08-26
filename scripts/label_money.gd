
var textToDisplay = "Money: "

func _on_player_signal_money( money ):
	get_node("Label").set_text(textToDisplay + str(money))
