extends Node2D

@onready var detectArea = $DetectArea
@onready var ui = $UI
var values

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	values = get_tree().root.get_node("Map")

func checkBalance(ammount):
	if ammount < values.cash_money:
		return 1
	return 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_detect_area_area_entered(area: Area2D) -> void:#Present shop items
	ui.visible = true
func _on_detect_area_area_exited(area: Area2D) -> void:#Clear shop items
	ui.visible = false

#Button Events
func _on_attack_speed_pressed() -> void:
	if values.cash_money >= 100:
		values.cash_money -= 100
		values.attack_speed_mult *= 1.2
func _on_attack_range_pressed() -> void:
	if values.cash_money >= 100:
		values.cash_money -= 100
		values.range_mult *= 1.2
func _on_move_speed_pressed() -> void:
	if values.cash_money >= 100:
		values.cash_money -= 100
		values.move_speed_mult *= 1.2

func _on_corn_pressed() -> void:
	if values.cash_money >= 10:
		values.corn_seeds += 10
		values.cash_money -= 10
func _on_pumpkin_pressed() -> void:
	if values.cash_money >= 10:
		values.pumpkin_seeds += 10
		values.cash_money -= 10
