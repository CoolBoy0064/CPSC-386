extends CharacterBody2D

@onready var Attack = preload("res://AttackScenes/RadialSwipe.tscn")
@onready var main = get_tree().get_root().get_node("Overworld")
@export var health = 100
@export var speed = 200
@export var attackSpeed = 3 #how fast (in seconds) this enemy will attack
var attackInterval = 0
var direction = Vector2(1, 0)
var range = 16000
var distance = 0

func _process(delta: float) -> void:
	if(health <= 0):
		destroy()
	velocity = direction * speed
	move_and_slide()
	distance += speed
	if(distance >= range):
		distance = 0
		direction *= -1
		$Sprite2D.flip_h = direction.x - 1
	attackInterval += delta
	if(attackInterval >= attackSpeed):
		swing(3)
		swing(1.5)
		swing(-1.5)
		swing(0)
		swing(1)
		swing(-1)
		swing(2)
		swing(-2) #Shoots projectiles in 8 directions at once
		attackInterval = 0
	if(attackInterval >= attackSpeed - .5):
		$Sprite2D.play("Attack") #to line up the appearance of the projectiles with the animation
		
		
	
	



func destroy():
	queue_free()

func handle_hit(dmg):
	health -= dmg


func swing(direction):
	var swipe = Attack.instantiate() #Create a swing instance
	var spawnPoint = global_position
	swipe.global_position = spawnPoint
	swipe.global_rotation = direction
	swipe.setDamage(45)
	main.add_child.call_deferred(swipe) #make the swipe a child of the main scene, so that the swing does not follow the player
