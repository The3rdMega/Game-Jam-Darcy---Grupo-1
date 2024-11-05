extends CharacterBody2D

var speed = 60
var player_chase = false
var player = null

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if player_chase:
		position += (player.position - position)/speed
		$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.play("idle")

func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	player_chase = true


func _on_detection_area_body_exited(body: Node2D) -> void:
	player = null
	player_chase = false
