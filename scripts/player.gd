extends CharacterBody2D


const SPEED = 60.0
const JUMP_VELOCITY = -300.0
const GHOST_DELAY = 5
var Is_ghost = false
var initialPosition: Vector2
var nextTimetToTransform: float

var animator: AnimatedSprite2D
func _ready() -> void:
	animator = get_node("AnimatedSprite2D")
	
func _physics_process(delta: float) -> void:
	
	if(Is_ghost):
		GhostControl()
	else:
		PlayerControl(delta)
	# Add the gravity.
	
	if(Input.is_action_just_released("f")):
		Ghost()

 	
var deadSprite = load("res://scenes/dead_sprite.tscn")
var spawnDead = deadSprite.instantiate()
func Ghost():
	var alreadyDead = null
	if(not Is_ghost):
		##VIRAR GHOST
		spawnDead = deadSprite.instantiate()
		get_parent().add_child(spawnDead)
		spawnDead.global_position = position
		spawnDead.global_position += Vector2(0, -6)
		animator.animation = "Ghost"
		initialPosition = position
	else:
		##VIRAR HUMANO
		spawnDead.queue_free()
		position = initialPosition
		animator.animation = "Idle"
	Is_ghost = !Is_ghost
		

func PlayerControl(delta:float):
	velocity.x*=0.8
	if not is_on_floor():
		velocity += get_gravity() * delta

	if (Input.is_key_pressed(KEY_SPACE) or Input.is_key_pressed(KEY_W) ) and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if Input.is_key_pressed(KEY_A):
		velocity.x += -SPEED
	if Input.is_key_pressed(KEY_D):
		velocity.x += SPEED
		
	move_and_slide()
func GhostControl():
	velocity*=0.8
	if Input.is_key_pressed(KEY_A):
		velocity.x += -SPEED/2
	if Input.is_key_pressed(KEY_D):
		velocity.x += SPEED/2
	if Input.is_key_pressed(KEY_W):
		velocity.y += -SPEED/2
	if Input.is_key_pressed(KEY_S):
		velocity.y += SPEED/2
	move_and_slide()
	
