class_name Door extends StaticBody2D

var Door_Closed: bool = true

var Pressed_Button: bool = false
var Pressed_Torch: bool = false

<<<<<<< Updated upstream
=======
@export var closed: Texture
@export var open: Texture
var childCount: int
var buttonsPressed: int
@export var AtivoemZero: bool = false
func _ready() -> void:
	buttonsPressed = 0
	childCount = get_child_count() -2
	print(childCount)

func OpenDoor():
		$Sprite2D.texture = load(open.resource_path)
		get_node("CollisionShape2D").disabled = true
		Door_Closed = false

>>>>>>> Stashed changes


func OpenDoor():	
	if Door_Closed and Pressed_Button and Pressed_Torch:
		$Sprite2D.texture = load("res://assets/Tiny RPG Character Asset Pack v1.03 -Free Soldier&Orc/Door_Open.png")
		get_node("CollisionShape2D").disabled = true
		Door_Closed = false
	else:
		$Sprite2D.texture = load("res://assets/Tiny RPG Character Asset Pack v1.03 -Free Soldier&Orc/Door_Closed.png")
		get_node("CollisionShape2D").disabled = false
		Door_Closed = true


func _on_player_button_pressed() -> void:
	Pressed_Button = !Pressed_Button
	OpenDoor()

func _on_player_torch_pressed() -> void:
	Pressed_Torch = !Pressed_Torch
	OpenDoor()

<<<<<<< Updated upstream
=======
func SetNum(n:int):
	buttonsPressed+=n
	print(buttonsPressed)
	
	if(buttonsPressed == childCount and AtivoemZero):
		OpenDoor()
		return
	CloseDoor()
	
	
	
>>>>>>> Stashed changes

func _on_scene_transition_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
