extends AudioStreamPlayer2D

@onready var musicBG = $"Background Music"
var backgroundmusicOn = true

func _process(delta: float) -> void:
	if musicBG.playing == false:
			musicBG.play()
	
func update_music_status():
	if backgroundmusicOn:
		if musicBG.playing == false:
			musicBG.play()
	else:
		musicBG.stop()
