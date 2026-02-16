extends CharacterBody2D


const SPEED: float = 400.0
const WATER_LEVEL: float = 150.0


@export var projectile_scene: PackedScene


var can_shoot: bool = true


func _ready() -> void:
	position.y = WATER_LEVEL
	
	
func _physics_process(delta: float) -> void:
	var direction: float = Input.get_axis("move_left", "move_right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	# Clamp X position to screen width (0 to 1280
	# Small buffer (40px) so half the sprite doesn't disappear
	position.x = clamp(position.x, 40, 1240)
		
	position.y = WATER_LEVEL
	
	move_and_slide()
	
	if Input.is_action_just_pressed("drop"):
		drop_item()
		
		
func drop_item() -> void:
	if can_shoot:
		can_shoot = false # Lock firing
		
		var item: Node2D = projectile_scene.instantiate()
		get_tree().current_scene.add_child(item)
		item.global_position = $DropPoint.global_position
		
		SignalBus.on_player_drop.emit()
		
		# Wait (0.5).timeout
		await get_tree().create_timer(0.5).timeout
		can_shoot = true
		
