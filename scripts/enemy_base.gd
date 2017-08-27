extends PathFollow2D

export(int) var health = 5
export(float) var speed = 10

export(int) var droped_money = 5

var end_threshold = 5

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	set_offset(get_offset() + (speed * delta))
	if get_unit_offset() >= 1:
		get_node("/root/game/player").remove_health(1)
		queue_free()

func take_damages(amount):
	health -= amount
	get_node("AnimationPlayer").play("hit")
	if health < 0:
		get_node("/root/game/player").add_money(droped_money)
		queue_free()