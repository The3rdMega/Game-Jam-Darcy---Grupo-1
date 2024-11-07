extends Node2D

@onready var musicBG = $"Background Music"
var backgroundmusicOn = true

func _process(delta: float) -> void:
	update_music_status()
	
func update_music_status():
	if backgroundmusicOn:
		if musicBG.playing == false:
			musicBG.play()
	else:
		musicBG.stop()
