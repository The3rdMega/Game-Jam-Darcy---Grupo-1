class_name Door extends StaticBody2D

var Door_Closed: bool = true

var Pressed_Button: bool = false
var Pressed_Torch: bool = false

@export var closed: Texture
@export var open: Texture
var childCount: int
var buttonsPressed: int
func _ready() -> void:
	buttonsPressed = 0
	childCount = get_child_count() -2
	print(childCount)

func OpenDoor():
		$Sprite2D.texture = load(open.resource_path)
		get_node("CollisionShape2D").disabled = true
		Door_Closed = false



func CloseDoor():
		$Sprite2D.texture = load(closed.resource_path)
		get_node("CollisionShape2D").disabled = false
		Door_Closed = true



func SetNum(n:int):
	buttonsPressed+=n
	if(buttonsPressed == childCount):
		OpenDoor()
		return
	CloseDoor()
	
	
	

func _on_door_interaction_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
