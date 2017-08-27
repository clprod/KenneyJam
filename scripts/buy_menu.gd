extends Control

func show():
	get_node("AnimationPlayer").play("show")

func hide():
	get_node("AnimationPlayer").play("hide")

func _on_player_signal_money(money):
	var buy_possible = false
	if get_node("/root/game/player").money < load("res://scenes/towers/single_canon.tscn").instance().cost:
		get_node("ScrollContainer/VBoxContainer/Button").set_disabled(true)
	else:
		get_node("ScrollContainer/VBoxContainer/Button").set_disabled(false)
		buy_possible = true
	if get_node("/root/game/player").money < load("res://scenes/towers/single_projectile.tscn").instance().cost:
		get_node("ScrollContainer/VBoxContainer/Button1").set_disabled(true)
	else:
		get_node("ScrollContainer/VBoxContainer/Button1").set_disabled(false)
		buy_possible = true