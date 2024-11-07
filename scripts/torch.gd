extends Area2D
@export var interact_label = ""
@export var interact_type = ""
@export var interact_value = ""

var activated = false

func torch() -> void:
	if activated == false:
		$Sprite2D.texture = load("res://assets/Tiny RPG Character Asset Pack v1.03 -Free Soldier&Orc/InteractionACTIVATED.png")
		activated = true
		get_parent().SetNum(1)
	else:
		$Sprite2D.texture = load("res://assets/Tiny RPG Character Asset Pack v1.03 -Free Soldier&Orc/Interaction.png")
		activated = false
		get_parent().SetNum(-1)
