extends Area2D

@export var nextLevel: String

func _ready() -> void:
	connect("area_entered",_on_area_entered)


func _on_area_entered(area: Area2D) -> void:
	if(area.get_parent().name == "Player"):
		if(area.get_parent().Is_ghost == false):
			get_tree().change_scene_to_file(nextLevel)
