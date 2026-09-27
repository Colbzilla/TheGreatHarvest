extends CharacterBody2D


## Speed in pixels per second.
@export_range(0, 1000) var speed := 60


func _physics_process(_delta: float) -> void:
	
	if Input.is_action_just_pressed("attack"):
		attack()
	
	get_player_input()
	move_and_slide()


# Code for Movement
func get_player_input() -> void:
	var vector := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = vector * speed

## Code for Attack
func attack() -> void:
	pass


## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
