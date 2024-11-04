extends State

func handle_input(event: InputEvent) -> void:
	pass 

func update(delta: float) -> void:
	owner.apply_gravity(delta)
	owner.move_player()
	
	#Jump
	if Input.is_action_just_pressed("ui_accept"): # test if the name of the action is really jump
		state_machine.transition_to("Jump")
	#Return to Idle if not moving
	var direction := Input.get_axis("ui_left","ui_right")
	if direction == 0:
		state_machine.transition_to("Idle")

func physics_update(delta: float) -> void:
	if not owner.is_on_floor():
		state_machine.transition_to("Fall")

func enter(msg := {}) -> void:
	owner.animated_sprite_2d.play("Walk")
	
func exit() -> void:
	pass
