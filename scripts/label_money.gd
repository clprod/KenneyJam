
var textToDisplay = "Money: "
func _ready():
	get_node("Label").set_text(textToDisplay + String(get_node("/root/game/player").money))
	
func _on_player_signal_money( money ):
	get_node("Label").set_text(textToDisplay+String(money))
