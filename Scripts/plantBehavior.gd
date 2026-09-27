extends Node2D

@onready var attackArea = $AttackArea
@onready var detectArea = $DetectionArea
@onready var matureTimer = $MaturityTimer
@onready var attackTimer = $AttackTimer
@onready var deathTimer = $DeathTimer
@onready var hitBox = $Hitbox

var isPursuing = false#Just controls animations
var canAttack = false#Cant move if attacking, once attacking is false it may move
var debounce = true

var deathTimeout = 3
var rng = RandomNumberGenerator.new()
var target #Should be player!

var moveSpeed = 15
var attackSpeed = 1
var damage = 10#Arbitrary lol
var defaultGrowth = 1

var states = {#Index, SpriteAnim, Health, canHit, Lower mature time, <higher
	"Seed" = [0,"",1,false,defaultGrowth,defaultGrowth],
	"Sprout" = [1,"",1,false,defaultGrowth,defaultGrowth],
	"Tall Sprout" = [2,"",1,false,defaultGrowth,defaultGrowth],
	"Ripe" = [3,"",1,true,defaultGrowth,defaultGrowth],
	"Monster" = [4,"",100,true,2000,2000],
	"Dead" = [5,"",0,false,2000,2000]
}
var state = states.values()[0]
@export var health = 1
var canGrow = false

func isAttacked(damage):
	health -= damage
	if health <= 0:
		state = states.values()[states.size()-1]#Turn to dead state
		deathTimer.start()

func attack(damage):#non-functional as of rn, placeholder values
	debounce = false
	#Make target recieve damage
	attackTimer.start()
	
func pursue(delta):
	var direction = global_position.direction_to(target.global_position)
	global_position += direction * moveSpeed * delta

func calcMatureTime():
	return (randi() % state[4] + state[5])

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if state[0] == 4:#If crop is a monster, then move & attack
		if isPursuing and !canAttack and target:#If we got a target, but we cant attack them yet, walk toward um
			pursue(delta)
		elif canAttack and debounce:
			#Attack player!
			attack(damage)


func _on_detection_area_area_entered(area: Area2D) -> void:
	if area.get_parent() is CharacterBody2D:#Checks if area belongs to player
		print("Player spotted, pursuing!")
		target = area.get_parent()
		isPursuing = true

func _on_detection_area_area_exited(area: Area2D) -> void:
	if area.get_parent() is CharacterBody2D:
		isPursuing = false
		canAttack = false
		target = null


func _on_attack_area_area_entered(area: Area2D) -> void:
	if target and isPursuing == true and area.get_parent() is CharacterBody2D:
		print("Player in attack range, attack!")
		canAttack = true
func _on_attack_area_area_exited(area: Area2D) -> void:
	if area.get_parent() is CharacterBody2D:
		canAttack = false


func _on_maturity_timer_timeout() -> void:
	if state[0] < states.size():#Checks if current state is less than the total states
		state = states.values()[state[0]+1]
		health = state[2]
		print("New State!!!")

		matureTimer.start(calcMatureTime())
func _on_attack_timer_timeout() -> void:
	if !debounce:
		debounce = true

func _on_death_timer_timeout() -> void:
	queue_free()#Nukes self on death, after timeout
