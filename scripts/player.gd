extends Node2D

export(int) var health
export(int) var money = 100

signal signal_money(money)

func addMoney(money2add):
	money += money2add
	emit_signal("signal_money")