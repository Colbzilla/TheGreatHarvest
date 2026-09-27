extends Node

@onready var health_bar = $HealthBar

@export var player_health = 6
@export var cash_money = 10#Start at 10 so they can buy seeds

@export var collected_corn = 0
@export var collected_pumpkin = 0

@export var corn_seeds = 0
@export var pumpkin_seeds = 0

@export var move_speed_mult = 1
@export var attack_speed_mult = 1
@export var range_mult = 1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	health_bar.frame = player_health
