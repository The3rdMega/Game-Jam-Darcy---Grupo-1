class_name Door extends StaticBody2D

var Door_Closed: bool = true

func OpenDoor():
	print("entrou")
	if Door_Closed:
		$Sprite2D.texture = load("res://assets/Tiny RPG Character Asset Pack v1.03 -Free Soldier&Orc/Door_Open.png")
		get_node("CollisionShape2D").disabled = true
		Door_Closed = false
	else:
		$Sprite2D.texture = load("res://assets/Tiny RPG Character Asset Pack v1.03 -Free Soldier&Orc/Door_Closed.png")
		get_node("CollisionShape2D").disabled = false
		Door_Closed = true


func _on_player_button_pressed() -> void:
	OpenDoor()
