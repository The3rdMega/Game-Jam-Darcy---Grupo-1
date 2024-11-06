class_name Door extends StaticBody2D

var Door_Closed: bool = true

var Pressed_Button: bool = false
var Pressed_Torch: bool = false

@export var closed: Texture
@export var open: Texture


func OpenDoor():	
	if Door_Closed:
		$Sprite2D.texture = load(open.resource_path)
		get_node("CollisionShape2D").disabled = true
		Door_Closed = false
	else:
		$Sprite2D.texture = load(closed.resource_path)
		get_node("CollisionShape2D").disabled = false
		Door_Closed = true


func _on_player_button_pressed() -> void:
	Pressed_Button = !Pressed_Button
	OpenDoor()

func _on_player_torch_pressed() -> void:
	Pressed_Torch = !Pressed_Torch
	OpenDoor()


func _on_door_interaction_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
