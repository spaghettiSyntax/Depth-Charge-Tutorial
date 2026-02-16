extends Node


@onready var drop_sound: AudioStreamPlayer = $DropSound
@onready var explode_sound: AudioStreamPlayer = $ExplodeSound


func _ready() -> void:
	# Listen to global events
	SignalBus.on_fish_caught.connect(play_explode)
	SignalBus.on_player_drop.connect(play_drop)
	
	
func play_explode() -> void:
	explode_sound.play()
	

func play_drop() -> void:
	drop_sound.play()
