extends Node2D

@onready var Tela: AnimatedSprite2D = $AnimatedSprite2D
var CurrentFrame = -1

func _ready():
	CurrentFrame = -1


func _process(delta):
	var frames = ["Cutscene2","Cutscene3","Cutscene4","Cutscene5","Cutscene6"]
	if Input.is_action_just_pressed("Interact"):
		print("pressed")
		CurrentFrame += 1
		if CurrentFrame == 5:
			get_tree().change_scene_to_file("res://scenes/Cutscene.tscn")
		else:
			Tela.play(frames[CurrentFrame])
