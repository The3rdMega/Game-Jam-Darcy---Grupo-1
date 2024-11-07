extends Area2D



func _on_enemy_pressure_0():
	get_parent().SetNum(-1)


func _on_enemy_pressure_1():
	get_parent().SetNum(1)
