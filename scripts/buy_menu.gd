extends Control

func show():
	get_node("AnimationPlayer").play("show")

func hide():
	get_node("AnimationPlayer").play("hide")