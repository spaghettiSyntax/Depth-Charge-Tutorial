extends Node


# Define our global signals here!
@warning_ignore("unused_signal")
signal on_fish_caught()
@warning_ignore("unused_signal")
signal on_game_over()
@warning_ignore("unused_signal")
signal on_player_drop()


# Data Persistence
var final_score: int = 0
