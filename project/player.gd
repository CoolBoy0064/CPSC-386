extends CharacterBody2D

@onready var Sword = preload("res://Swipe.tscn")
@export var speed = 200
@onready var main = get_tree().get_root().get_node("Overworld")
@export var attackSpeed = 30
var attackInterval = 0
var face = 1 #tracks the direction the player is facing for idle animations
var paused = 0
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("Pause")):
		pause()
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = direction * speed
	move_and_slide()
	attackInterval += 1
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
		if(attackInterval >= attackSpeed):
			swing()
			attackInterval = 0
# tutorial from Net Ninja on youtube followed for some of the code


func swing():
	var swipe = Sword.instantiate()
	var spawnPoint = $Origin.global_position
	var spawnDirection = spawnPoint.angle_to_point(get_global_mouse_position())
	swipe.global_position = spawnPoint
	swipe.global_rotation = spawnDirection
	main.add_child.call_deferred(swipe)
		
		
func pause():
	if paused:
		$PauseMenu.hide()
		paused = 0
	else:
		$PauseMenu.show()
		paused = 1
	pass
