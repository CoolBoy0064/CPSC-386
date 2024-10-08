extends CharacterBody2D

@onready var Sword = preload("res://AttackScenes/Swipe.tscn")
@export var speed = 200
@onready var main = get_tree().get_root().get_node("Overworld")
@export var attackSpeed = 0.5 #how fast in seconds we can attack
@export var MAX_HEALTH = 200
var attackInterval = 0
var face = 1 #tracks the direction the player is facing for idle animations
var paused = 0
var health = MAX_HEALTH
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HealthBar.value = MAX_HEALTH


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("Pause")):
		pause()
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = direction * speed
	move_and_slide()
	
	if (velocity == Vector2.ZERO && !Input.is_action_pressed("Attack")):
		if(face == 1):
			$Sprite.play("IdleRight")
		elif(face == 2):
			$Sprite.play("IdleUp")
		elif(face == 3):
			$Sprite.play("IdleDown")
	if (Input.is_action_pressed("Right") && !Input.is_action_pressed("Attack")):
		$Sprite.flip_h = 0
		$Sprite.play("MoveRight")
		face = 1
	elif (Input.is_action_pressed("Left") && !Input.is_action_pressed("Attack")):
		$Sprite.flip_h = 1
		$Sprite.play("MoveRight")
		face = 1
	elif (Input.is_action_pressed("Up") && !Input.is_action_pressed("Attack")):
		$Sprite.flip_h = 0
		$Sprite.play("MoveUp")
		face = 2
	elif (Input.is_action_pressed("Down") && !Input.is_action_pressed("Attack")):
		$Sprite.flip_h = 0
		$Sprite.play("MoveDown")
		face = 3
	if (Input.is_action_pressed("Attack")):
		var SpawnDirectionA = global_position.angle_to_point(get_global_mouse_position())
		if(SpawnDirectionA < 1 && SpawnDirectionA > -1):
			$Sprite.flip_h = 0
			$Sprite.play("AttackRight")
			face = 1
		elif(SpawnDirectionA < -1 && SpawnDirectionA > -2):
			$Sprite.flip_h = 0
			$Sprite.play("AttackUp")
			face = 2
		elif(SpawnDirectionA < 2 && SpawnDirectionA > 1):
			$Sprite.flip_h = 0
			$Sprite.play("AttackDown")
			face = 3
		else:
			$Sprite.flip_h = 1
			$Sprite.play("AttackRight")
			face = 1
		if(attackInterval <= 0): #if attackSpeed seconds has passed
			swing()
			attackInterval = attackSpeed 
		attackInterval -= delta #subtract the attack interval from the amount of time that has elapsed sinse the last frame
# tutorial from Net Ninja on youtube followed for some of the code


func swing():
	var swipe = Sword.instantiate() #Create a swing instance
	var spawnPoint = $Origin.global_position
	var spawnDirection = spawnPoint.angle_to_point(get_global_mouse_position())
	swipe.global_position = spawnPoint
	swipe.global_rotation = spawnDirection
	swipe.setDamage(50)
	main.add_child.call_deferred(swipe) #make the swipe a child of the main scene, so that the swing does not follow the player
	

		
		
func pause():
	if paused:
		$PauseMenu.hide()
		paused = 0
	else:
		$PauseMenu.show()
		paused = 1
	pass

func handle_hit(dmg):
	health -= dmg
	if (health <= 0):
		health = 200
	$HealthBar.value = health
	
