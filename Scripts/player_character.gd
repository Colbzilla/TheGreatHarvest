extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

## Speed in pixels per second.
@export_range(0, 1000) var speed := 60

## Player Movement
func _physics_process(_delta: float) -> void:
	
	## Direction Player is facing
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if Input.is_action_just_pressed("attack"):
		attack()
	
	get_player_input()
	move_and_slide()
	handle_movement_animation(direction)

func _process(delta: float) -> void:
	pass

# Code for Movement
func get_player_input() -> void:
	var vector := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = vector * speed

## Code for Attack
func attack() -> void:
	pass


func handle_movement_animation(dir) -> void:
	if !velocity:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("walking")
		
		## Flips animation when facing different way
		if dir == 1:
			animated_sprite.flip_h = true
		if dir == -1: 
			animated_sprite.flip_h = false
	
