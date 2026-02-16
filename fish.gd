extends Area2D


var speed: float = 150.0
var direction: int = 1
var time_alive: float = 0.0
var bob_speed: float = 5.0
var bob_height: float = 2.0


func _ready() -> void:
	# Randomize movement parameters
	bob_speed = randf_range(3.0, 8.0)
	bob_height = randf_range(1.0, 3.0)
	

func _physics_process(delta: float) -> void:
	# Move Forward
	position.x += speed * direction * delta
	
	# Bob up and down
	time_alive += delta
	position.y += sin(time_alive * bob_speed) * bob_height
	
	# Check if off-screen escaped!
	# If moving right (1) and x > 1300, OR moving left (-1) and x < -20
	if direction == 1 and position.x > 1300 \
		or direction == -1 and position.x < -20:
			SignalBus.on_game_over.emit()
			queue_free()
		
		
func die() -> void:
	# The Magic Moment
	SignalBus.on_fish_caught.emit()
	queue_free()
