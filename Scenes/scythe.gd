extends CharacterBody2D

@onready var player_pos = get_parent().get_node("PlayerCharacter").position
var direction := global_position.direction_to(get_global_mouse_position())
@onready var animated_sprite = $AnimatedSprite2D
@onready var collision_shape = $CollisionShape2D
var attack_animation = 1


func _physics_process(_delta: float) -> void:
	
	## Updates angle to mouse, then sets scythe angle
	direction = get_parent().get_node("PlayerCharacter").position.direction_to(get_global_mouse_position())
	rotation = direction.angle()
	
	## Sets scythe to player position
	position = get_parent().get_node("PlayerCharacter").position
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_pressed("attack") || animated_sprite.is_playing():
		## Moves scythe toward mouse
		position.x += 24 * cos((direction).angle())
		position.y += 24 * sin((direction).angle())
		
		## Activates Collision Shape
		collision_shape.disabled = !(animated_sprite.frame == 2)
		
		
		if !animated_sprite.is_playing():
			if attack_animation == 1:
				animated_sprite.play("attackOne")
				attack_animation = 2
			else:
				animated_sprite.play("attackTwo")
				attack_animation = 1
