extends CharacterBody2D


const SPEED = 15.0
const JUMP_VELOCITY = -300.0
const GHOST_DELAY = 5

var Is_ghost = false
var initialPosition: Vector2
var nextTimetToTransform: float
var collider: CollisionShape2D
var animator: AnimatedSprite2D
var canDash: bool
var dash_timer: Timer

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
		PlayerControl(delta)
	# Add the gravity.
	
	if(Input.is_action_just_released("f")):
		Ghost()
 	


func Ghost():
	if(Is_ghost):
		##VIRAR HUMANO
		position = initialPosition
		animator.animation = "Idle"
		collider.disabled = false
	else:
		##VIRAR GHOST
		animator.animation = "Ghost"
		initialPosition = position
		collider.disabled = true
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

func dash(direction:int):
	print("shimishimeishimeishimiai drake swalalalala")
	velocity.x+= (30*SPEED*direction)
	dash_timer.start()
	canDash = false	
	
func dashTimeout():
	canDash = true
	print("not")
