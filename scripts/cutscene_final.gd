extends Node2D

@onready var Tela: AnimatedSprite2D = $AnimatedSprite2D
var CurrentFrame = -1

func _ready():
	CurrentFrame = -1


func _process(delta):
	var frames = ["Cutscene2","Cutscene3","Cutscene4","Cutscene5","Cutscene6","Cutscene7"]
	if Input.is_action_just_pressed("Interact"):
		get_tree().change_scene_to_file("res://scenes/game.tscn")
		print("pressed")
		CurrentFrame += 1
		if CurrentFrame == 6:
			get_tree().change_scene_to_file("res://scenes/game.tscn")
		else:
			Tela.play(frames[CurrentFrame])
