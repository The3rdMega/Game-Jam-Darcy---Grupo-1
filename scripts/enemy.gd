extends RigidBody2D

var speed = 60
var player_chase
var player = null
var tipo = ""

func _ready() -> void:
	player_chase = false
	
	
func _physics_process(delta: float) -> void:
	if player_chase:
		if tipo == "player":
			position.x += (player.position.x - position.x)/speed
		else:
			position.x -= (player.position.x - position.x)/speed
			
		$AnimatedSprite2D.play("walk")
		if (player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
		
	else:
		$AnimatedSprite2D.play("idle")

func _on_detection_area_body_entered(body: Node2D) -> void:
	if(body.name == "Player"):
		player = body
		player_chase = true
		tipo = "player"


func _on_detection_area_body_exited(body: Node2D) -> void:
	if(body.name == "Player"):
		player_chase = false


func _on_detection_area_area_entered(area: Area2D) -> void:
	if (area.get_parent().name == "Player"):
		player = area.get_parent()
		player_chase = true
		tipo = "fantasma"

func _on_detection_area_area_exited(area: Area2D) -> void:
	if (area.get_parent().name == "Player"):
		player = null
		player_chase = false
