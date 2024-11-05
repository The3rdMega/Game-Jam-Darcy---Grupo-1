extends CharacterBody2D


const SPEED = 15.0
const JUMP_VELOCITY = -300.0
const GHOST_DELAY = 5
var Is_ghost = false
var initialPosition: Vector2
var nextTimetToTransform: float

var canDash: bool
var dash_timer: Timer
var collider:CollisionShape2D
var rising = false
var animator: AnimatedSprite2D
func _ready() -> void:
	animator = get_node("AnimatedSprite2D")
	collider = get_node("CollisionShape2D")
	canDash = true
	dash_timer = Timer.new()
	add_child(dash_timer)
	dash_timer.one_shot = true
	dash_timer.connect("timeout",dashTimeout)
	dash_timer.wait_time = 1.5  

func _physics_process(delta: float) -> void:
	
	if(Is_ghost):
		GhostControl()
	else:
		if not rising:
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
		spawnDead.z_index = -1
		spawnDead.global_position = position
		spawnDead.global_position += Vector2(0, -6)
		animator.animation = "Ghost"
		initialPosition = position
		collider.disabled = true
	else:
		##VIRAR HUMANO
		collider.disabled = false
		rising = true
		spawnDead.queue_free()
		position = initialPosition
		$AnimatedSprite2D.play("Rise")
		#_on_animated_sprite_2d_animation_finished("Rise")
	Is_ghost = !Is_ghost
		

func PlayerControl(delta:float):
	velocity.x*=0.8
	var dirX = 0 
	if not is_on_floor():
		velocity += get_gravity() * delta

	if (Input.is_key_pressed(KEY_SPACE) or Input.is_key_pressed(KEY_W) ) and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if Input.is_key_pressed(KEY_A):
		velocity.x += -SPEED
		dirX = -1

	if Input.is_key_pressed(KEY_D):
		velocity.x += SPEED
		dirX = 1
	if Input.is_key_pressed(KEY_SHIFT) and canDash:
		dash(dirX)

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

func _on_animated_sprite_2d_animation_finished():
	print("ENTERED")
	if 	$AnimatedSprite2D.animation == "Rise":
		rising = false
		$AnimatedSprite2D.play("Idle")
func dash(direction:int):
	print("shimishimeishimeishimiai drake swalalalala")
	velocity.x+= (30*SPEED*direction)
	dash_timer.start()
	canDash = false	
	
func dashTimeout():
	canDash = true
	print("not")
