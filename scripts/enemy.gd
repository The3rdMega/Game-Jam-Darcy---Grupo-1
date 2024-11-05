extends RigidBody2D

var speed = 60
var player_chase
var player = null

func _ready() -> void:
	player_chase = false
func _physics_process(delta: float) -> void:
	
	if player_chase:
		position.x += (player.position.x - position.x)/speed
		$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.play("idle")

func _on_detection_area_body_entered(body: Node2D) -> void:
	if(body.name == "Player"):
		player = body
		player_chase = true


func _on_detection_area_body_exited(body: Node2D) -> void:
	if(body.name == "Player"):
		player_chase = false
