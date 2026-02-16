extends Control


@onready var score_label: Label = $VBoxContainer/ScoreLabel


func _ready() -> void:
	# Pull the data from our SignalBus!
	score_label.text = "Final Score: %s" % SignalBus.final_score


func _on_retry_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
