extends State

func handle_input(event: InputEvent) -> void:
	pass 

func update(delta: float) -> void:
	owner.apply_gravity(delta)
	owner.move_player()
	
	if owner.velocity.y > 0:
		state_machine.transition_to("Fall")
	
func physics_update(delta: float) -> void:
	pass

func enter(msg := {}) -> void:
	owner.aniomated_sprite_2d.play("Jump")
	owner.velocity.y = owner.JUMP_VELOCITY

func exit() -> void:
	pass
