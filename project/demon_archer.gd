extends CharacterBody2D

@onready var Attack = preload("res://AttackScenes/EnemyArrow.tscn")
@onready var main = get_tree().get_root().get_node("Overworld")
@export var health = 100
@export var speed = 100
@export var attackSpeed = 2 #how fast (in seconds) this enemy will attack
var attackInterval = 0
var direction = Vector2(1, 0)
var range = 16000
var directionTimer = 0 
var rng = RandomNumberGenerator.new()
var player : Node2D
var attacking = false

func _process(delta: float) -> void:
	if(health <= 0):
		destroy()
	if(directionTimer > .6):
		direction = Vector2(rng.randf_range(-1.0, 1.0), rng.randf_range(-1.0, 1.0))
		directionTimer = 0
	velocity = direction * speed
	move_and_slide()
	attackInterval += delta
	directionTimer += delta
	if(attackInterval >= attackSpeed && attacking):
		var attackDir = global_position.angle_to_point(player.global_position)
		swing(attackDir)
		if (attackDir < 1 && attackDir > -2):
			$AnimatedSprite2D.flip_h = 1
		else:
			$AnimatedSprite2D.flip_h = 0
		$AnimatedSprite2D.play("Attack")
		attackInterval = 0
		
		
	
	



func destroy():
	queue_free()

func handle_hit(dmg):
	health -= dmg
	$HitSound.play()


func swing(direction):
	var swipe = Attack.instantiate() #Create a swing instance
	var spawnPoint = global_position
	swipe.global_position = spawnPoint
	swipe.global_rotation = direction
	swipe.setRange(range)
	swipe.setDamage(50)
	main.add_child.call_deferred(swipe) #make the swipe a child of the main scene, so that the swing does not follow the player


func _on_player_detector_body_entered(body: Node2D) -> void:
		player = body
		attacking = true


func _on_player_detector_body_exited(body: Node2D) -> void:
		attacking = false
