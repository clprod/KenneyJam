extends KinematicBody2D

var velocity

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	move(velocity * delta)

func shoot(direction, speed):
	velocity = direction * speed