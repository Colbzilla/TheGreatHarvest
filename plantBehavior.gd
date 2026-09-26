extends Node2D

@onready var attackArea = $AttackArea
@onready var detectArea = $DetectionArea

var canAttack = false
var canPursue = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_detection_area_area_entered(area: Area2D) -> void:
	canPursue = true
func _on_detection_area_area_exited(area: Area2D) -> void:
	canAttack = true


func _on_attack_area_area_entered(area: Area2D) -> void:
	canAttack = false
func _on_attack_area_area_exited(area: Area2D) -> void:
	canPursue = false
