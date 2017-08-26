extends Node2D

export(int) var health
export(int) var money = 100

signal money_changed(money)
signal health_changed(health)

func _ready():
	connect("money_changed", get_node("../ui/money"), "_on_player_signal_money")
	connect("health_changed", get_node("../ui/life"), "_on_player_signal_life")
	emit_signal("money_changed", money)
	emit_signal("health_changed", health)

func add_money(money2add):
	set_money(money + money2add)
	
func set_health(p_health):
	health = p_health
	emit_signal("health_changed", health)

func remove_health(health2remove):
	set_health(health - health2remove)

func set_money(p_money):
	money = p_money
	emit_signal("money_changed", money)