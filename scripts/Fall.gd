extends State

func handle_input(event: InputEvent) -> void:
	pass 

func update(delta: float) -> void:
	owner.apply_gravity(delta)
	owner.move_player()

func physics_update(delta: float) -> void:
	if owner.is_on_floor():
		state_machine.transition_to("Idle")

func enter(msg := {}) -> void:
	owner.animated_sprite_2d.play("Fall")
	
func exit() -> void:
	pass
