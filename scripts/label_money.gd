extends Label

var textToDisplay = "Money: "
var moneyAmount = ""

func _ready():
	set_process(true)
	
func _process(delta):
	#moneyAmount = get_node("player").money
	set_text(textToDisplay+moneyAmount)