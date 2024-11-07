extends Node2D

@onready var Tela: AnimatedSprite2D = $AnimatedSprite2D
@onready var Historia: Label = $História
var CurrentFrame = -1
var CurrentHistoria = -1

func _ready():
	CurrentFrame = -1
	CurrentHistoria = -1


func _process(delta):
	var frames = ["Cutscene2","Cutscene3","Cutscene4","Cutscene5","Cutscene6","Cutscene7"]
	var historia = ["Para passar de uma sala fechada", "Seria necessário um sacrifício","O mais velho tomou a espada","E apunhalou o próprio peito","Com sua alma liberada","Os dois vão juntos sair daqui"]
	if Input.is_action_just_pressed("Interact"):
		print("pressed")
		CurrentFrame += 1
		CurrentHistoria += 1
		if CurrentFrame == 6:
			get_tree().change_scene_to_file("res://scenes/game.tscn")
		else:
			Tela.play(frames[CurrentFrame])
			Historia.text = historia[CurrentHistoria]
			
