extends Area2D


const SINK_SPEED: float = 200.0


func _physics_process(delta: float) -> void:
	position.y += SINK_SPEED * delta
	if position.y > 800:
		queue_free()
		
		
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("fish"):
		area.die() # We assume the fish has a die() function
		queue_free()
