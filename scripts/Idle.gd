extends State

func handle_input(event: InputEvent) -> void:
	pass

func update(delta: float) -> void:
	owner.apply_gravity(delta)
	owner.move_player()
	
	if Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left"):
		state_machine.transition_to("Walk")
	
	if Input.is_action_just_pressed("ui_accept"): # test if the name of the action is really jump
		state_machine.transition_to("Jump")

func physics_update(delta: float) -> void:
	if not owner.is_on_floor():
		state_machine.transition_to("Fall")

func enter(msg := {}) -> void:
	owner.animated_sprite_2d.play("Idle")
	
func exit() -> void:
	pass
