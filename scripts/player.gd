extends Node2D

export(int) var health
export(int) var money = 100

signal money_changed(money)

func _ready():
	connect("money_changed", get_node("../ui/money"), "_on_player_signal_money")
	emit_signal("money_changed", money)

func add_money(money2add):
	set_money(money + money2add)

func set_money(p_money):
	money = p_money
	emit_signal("money_changed", money)