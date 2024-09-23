extends CharacterBody2D


@export var health = 100
@export var speed = 200
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
	
	



func destroy():
	queue_free()

func handle_hit(dmg):
	health -= dmg
	
