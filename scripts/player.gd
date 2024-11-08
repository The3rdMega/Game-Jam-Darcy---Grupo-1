extends CharacterBody2D


const SPEED = 25.0
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
var interactor: Area2D
@onready var allInteractions = []
@onready var InteractLabel = $InteractionComponents/InteractionLabel

@onready var playerAudioWalk = $AudioWalk
@onready var playerAudioJump = $AudioJump

func _ready() -> void:
	animator = get_node("AnimatedSprite2D")
	collider = get_node("CollisionShape2D")
	canDash = true
	dash_timer = Timer.new()
	add_child(dash_timer)
	dash_timer.one_shot = true
	dash_timer.connect("timeout",dashTimeout)
	dash_timer.wait_time = 0.5  

func _physics_process(delta: float) -> void:
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	elif velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	
	
	
	if Input.is_action_just_pressed("Interact") and interactor != null:
		HandleInteraction()	
	
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
	var diedRight = null
	var diedLeft = null
	if(not Is_ghost):
		
		##VIRAR GHOST
		if(is_on_floor()):
			spawnDead = deadSprite.instantiate()
			get_parent().add_child(spawnDead)
			spawnDead.z_index = 3
			spawnDead.global_position = position
			spawnDead.global_position += Vector2(0, -6)
			if velocity.x < 0:
				spawnDead.get_node("AnimatedSprite2D").flip_h = true
				diedLeft = true
				diedRight = null
			elif velocity.x > 0:
				spawnDead.get_node("AnimatedSprite2D").flip_h = false
				diedLeft = null
				diedRight = true
			
			animator.animation = "Ghost"
			initialPosition = position
			collider.disabled = true
			Is_ghost = !Is_ghost
	else:
		##VIRAR HUMANO
		while (initialPosition.distance_to(position) > 3):
			velocity += (initialPosition-position).normalized() * SPEED*8
			await get_tree().process_frame
		velocity = Vector2.ZERO
		collider.disabled = false
		rising = true
		if is_instance_valid(spawnDead):
			spawnDead.queue_free()
		position = initialPosition
		$AnimatedSprite2D.play("Rise")
		if diedRight:
			$AnimatedSprite2D.flip_h = false
			diedLeft = null
			diedRight = null
		elif diedLeft:
			$AnimatedSprite2D.flip_h = true
			diedLeft = null
			diedRight = null
		Is_ghost = !Is_ghost

		#_on_animated_sprite_2d_animation_finished("Rise")
		

func PlayerControl(delta:float):
	if Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_A):
		$AnimatedSprite2D.play("Walk")
	else:
		$AnimatedSprite2D.play("Idle")
	velocity.x*=0.8
	var dirX = 0 
	if not is_on_floor():
		velocity += get_gravity() * delta

	if (Input.is_key_pressed(KEY_SPACE) or Input.is_key_pressed(KEY_W) ) and is_on_floor():
		velocity.y = JUMP_VELOCITY
		if playerAudioJump.playing == false and is_on_floor():
			playerAudioJump.play()

	if Input.is_key_pressed(KEY_A):
		velocity.x += -SPEED
		dirX = -1
		if playerAudioWalk.playing == false and is_on_floor():
			playerAudioWalk.play()

	if Input.is_key_pressed(KEY_D):
		velocity.x += SPEED
		dirX = 1
		if playerAudioWalk.playing == false and is_on_floor():
			playerAudioWalk.play()
			
	if Input.is_key_pressed(KEY_SHIFT) and canDash:
		dash(dirX)
	move_and_slide()
	
func GhostControl():
	velocity*=0.8
	if Input.is_key_pressed(KEY_A):
		velocity.x += -SPEED
	if Input.is_key_pressed(KEY_D):
		velocity.x += SPEED
	if Input.is_key_pressed(KEY_W):
		velocity.y += -SPEED
	if Input.is_key_pressed(KEY_S):
		velocity.y += SPEED
	move_and_slide()

func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "Rise":
		rising = false
		$AnimatedSprite2D.play("Idle")


func dash(direction:int):
	velocity.x+= (15*SPEED*direction)
	dash_timer.start()
	canDash = false	
	
func dashTimeout():
	canDash = true
	print("not")
	
	


func _on_interaction_area_area_entered(area: Area2D) -> void:
	if(area.has_method("button") or area.has_method("torch")):
		if area.has_method("torch") and Is_ghost:
			InteractLabel.text = "Press [E]"
		else:
			InteractLabel.text = ""
		if area.has_method("button") and not Is_ghost:
			InteractLabel.text = "Press [E]"
		else:
			InteractLabel.text = ""
		interactor = area
	

func _on_interaction_area_area_exited(area: Area2D) -> void:
	if(area == interactor):
		interactor = null
	InteractLabel.text = ""
	

func HandleInteraction() -> void:
	if interactor.has_method("button") and !Is_ghost:
		interactor.button()
	if interactor.has_method("torch") and Is_ghost:
		interactor.torch()
