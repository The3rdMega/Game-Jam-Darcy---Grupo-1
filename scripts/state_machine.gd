"""
Original code by GDQuest and contributors, CC BY-SA 4.0
link: https://www.gdquest.com/tutorial/godot/design-patterns/finite-state-machine/
"""


class_name StateMachine
extends Node

#Emite quando transiciona para um novo estado
signal transitioned(state_name)

#Caminho para o estado ativo inicial. Deve ser selecionado no inspetor (provavelmente Idle)
@export var initial_state:= NodePath()

#O estado atualmente ativo. No começo do jogo, puxamos o "initial_state".
@onready var state: State = get_node(initial_state)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#esperar o pai deste nodo ficar pronto
	await owner.ready
	#a máquina de estados se assinala a propriedade state_machine dos objetos Estados
	for child in get_children():
		child.state_machine = self
	state.enter()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)

func _process(delta: float) -> void:
	state.physics_update(delta)

#Essa função chama a função exit() do atual estado e então muda o estado atual ativo.
#Chama então a função enter() do novo estado.
#Opcionalmente recebe um dicionário "msg" para passar para a função enter() do próximo estado.
func transition_to(target_state_name: String, msg: Dictionary = {}) -> void:
	#Safety Check
	if not has_node(target_state_name):
		return
	state.exit()
	state = get_node(target_state_name)
	state.enter(msg)
	emit_signal("transitioned", state.name)
	
