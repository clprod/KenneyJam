extends PathFollow2D

export(int) var health = 5
export(float) var speed = 10

export(int) var droped_money = 5

var end_threshold = 5
var death_timer = 0

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	if health < 0:
		death_timer += delta
		if death_timer > 1.5:
			queue_free()
		return
	set_offset(get_offset() + (speed * delta))
	if get_unit_offset() >= 1:
		get_node("/root/game/player").remove_health(1)
		queue_free()

func take_damages(amount):
	health -= amount
	get_node("AnimationPlayer").play("hit")
	if health < 0:
		get_node("/root/game/player").add_money(droped_money)
		var indicator = load("res://scenes/ui/money_indicator.tscn").instance()
		get_node("/root/game/ui").add_child(indicator)
		indicator.set_value(droped_money)
		indicator.set_pos(get_global_pos())
		get_node("SamplePlayer").onDeathSound()
		remove_child(get_node("KinematicBody2D"))
		remove_from_group("enemies")

func get_slowed(amountOfSpeedReduce):
	speed -= amountOfSpeedReduce
	get_node("AnimationPlayer").play("hit")