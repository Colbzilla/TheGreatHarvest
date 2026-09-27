extends Node2D

@onready var detectArea = $DetectArea
@onready var ui = $UI
var values

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	values = get_tree().root.

func checkBalance(ammount):
	if 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_detect_area_area_entered(area: Area2D) -> void:#Present shop items
	ui.visible = true
func _on_detect_area_area_exited(area: Area2D) -> void:#Clear shop items
	ui.visible = false

#Button Events
func _on_attack_speed_pressed() -> void:
	pass # Replace with function body.
func _on_attack_range_pressed() -> void:
	pass # Replace with function body.
func _on_move_speed_pressed() -> void:
	pass # Replace with function body.

func _on_corn_pressed() -> void:
	pass # Replace with function body.
func _on_pumpkin_pressed() -> void:
	pass # Replace with function body.
