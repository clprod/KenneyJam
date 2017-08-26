extends PathFollow2D

export(int) var health = 5
export(float) var speed = 10

var end_threshold = 5

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	set_offset(get_offset() + (speed * delta))
	if get_unit_offset() >= 1:
		queue_free()

func take_damages(amount):
	health -= amount
	if health < 0:
		queue_free()