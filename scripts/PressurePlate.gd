extends Area2D


func _ready() -> void:
	connect("area_entered",_on_area_entered)
	connect("area_exited",_on_area_entered)



func _process(delta: float) -> void:
	pass
func _on_area_entered():
	pass
