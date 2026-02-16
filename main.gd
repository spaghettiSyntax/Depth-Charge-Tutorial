extends Node2D


@export var fish_scene: PackedScene


@onready var score_label: Label = $HUD/ScoreLabel


var score: int = 0


func _ready() -> void:
	# Wire up the Spawner
	$Timer.timeout.connect(_on_timer_timeout)
	
	# Wire up the SignalBus
	SignalBus.on_fish_caught.connect(_update_score)
	SignalBus.on_game_over.connect(_on_game_over)
	
	
func _update_score() -> void:
	score += 1
	score_label.text = "Score: %s" % score
	
	
func _on_timer_timeout() -> void:
	var fish: Area2D = fish_scene.instantiate()
	add_child(fish)
	
	# Randomize
	var spawn_y: float = randf_range(200, 600)
	var is_left: bool = randf() > 0.5
	
	if is_left:
		fish.position = Vector2(-50, spawn_y)
		fish.direction = 1
	else:
		fish.position = Vector2(1300, spawn_y)
		fish.direction = -1
		fish.get_node("Sprite2D").flip_h = true
		
		
func _on_game_over() -> void:
	# Save the score!
	SignalBus.final_score = score
	
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
