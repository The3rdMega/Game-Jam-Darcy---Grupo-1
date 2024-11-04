class_name State
extends Node

#referencia a state machine, para chamar o seu "transition_to()" diretamente
var state_machine = null

#Função virtual. Recebe eventos do callback do "_unhandled_input()".
func handle_input(_event: InputEvent) -> void:
	pass


#Função virtual. Corresponde ao callback do "_process()".
func update(_delta: float):
	pass

#Função virtual. Corresponde ao callback do "_physics_process()".
func _physics_update(_delta: float) -> void:
	pass

#Função virtual. Chamada pela state machine enquanto muda o estado ativo. O parâmetro "msg"
# é um dicionário com dados arbitrários que o estado pode utilizar para se estabilizar
func enter(_msg := {}) -> void:
	pass

#Função virtual. Chamada pela state machine antes de mudar o estado ativo. Use essa
#função para limpar o estado.
func exit() -> void:
	pass
