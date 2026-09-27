extends Node2D

@onready var attackArea = $AttackArea
@onready var detectArea = $DetectionArea
@onready var matureTimer = $MaturityTimer
@onready var attackTimer = $AttackTimer

var values
@onready var hitBox = $Hitbox

var isPursuing = false#Just controls animations
var canAttack = false#Cant move if attacking, once attacking is false it may move
var debounce = true

var deathTimeout = 3
var rng = RandomNumberGenerator.new()
var target #Should be player!

var moveSpeed = 15
var attackSpeed = 3
var damage = 1#Arbitrary lol
var defaultGrowth = 1

var states = {#Index, SpriteAnim, Health, canHit, Lower mature time, <higher, yield
	"Seed" = [0,"res://Sprites/Growing_Corn/seed.png",1,false,defaultGrowth,defaultGrowth,0],
	"Sprout" = [1,"res://Sprites/Growing_Corn/sprout.png",1,false,defaultGrowth,defaultGrowth,0],
	"Tall Sprout" = [2,"res://Sprites/Growing_Corn/tall_sprout.png",1,false,defaultGrowth,defaultGrowth,0],
	"Ripe" = [3,"res://Sprites/Growing_Corn/ripe.png",1,true,defaultGrowth,defaultGrowth,5],
	"Monster" = [4,"res://Sprites/Growing_Corn/CornEnemyCob.png",100,true,2000,2000,10],
	"Dead" = [5,"res://Sprites/Growing_Corn/CornEnemyCobDead.png",0,false,2000,2000,0]
}
var state = states.values()[0]
@export var health = state[2]
var canGrow = false

func attack(damage):#non-functional as of rn, placeholder values
	debounce = false
	values.player_health -= damage
	attackTimer.start()
	
func pursue(delta):
	var direction = global_position.direction_to(target.global_position)
	global_position += direction * moveSpeed * delta

func calcMatureTime():
	return (randi() % state[4] + state[5])

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	values = get_tree().root.get_node("Map")
	matureTimer.start(calcMatureTime())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if state[0] == 4:#If crop is a monster, then move & attack
		if isPursuing and !canAttack and target:#If we got a target, but we cant attack them yet, walk toward um
			pursue(delta)
		elif canAttack and debounce:
			#Attack player!
			attack(damage)
	
	#Check Health
	if health <= 0 and state[3]:#If health is 0 and can hit, DIE!
		state = states.values()[states.size()-1]#Turn to dead state
		values.cash_money += state[6]#The yield of the crop
		queue_free()


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
	if state[0] < states.size()-1:#Checks if current state is less than the total states
		state = states.values()[state[0]+1]
		health = state[2]
		$Sprite2D.texture = load(state[1])
		print("New State!!!")

		matureTimer.start(calcMatureTime())
func _on_attack_timer_timeout() -> void:
	if !debounce:
		debounce = true
