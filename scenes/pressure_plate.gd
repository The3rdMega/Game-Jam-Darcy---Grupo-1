extends Area2D

func _on_area_entered(area: Area2D) -> void:
	get_parent().OpenDoor()


func _on_area_exited(area: Area2D) -> void:
	get_parent().CloseDoor()
