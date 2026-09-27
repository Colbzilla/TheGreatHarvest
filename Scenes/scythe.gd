extends CharacterBody2D

@onready var player_pos = get_parent().get_node("PlayerCharacter").position
var direction := global_position.direction_to(get_global_mouse_position())

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	## Sets scythe to player position
	player_pos = get_parent().get_node("PlayerCharacter").position
	position = player_pos
	
	## Updates angle to mouse, then sets scythe angle
	direction = global_position.direction_to(get_global_mouse_position())
	rotation = direction.angle()
