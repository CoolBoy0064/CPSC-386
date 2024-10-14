extends Area2D

#Universal script for all projectiles that should spin. Relies on a spinning projectiles sprite being named "Sprite"

@export var range = 750000
@export var damage = 50
var speed = 300
var distanceTraveled = 0
var direction

func _physics_process(delta):
	direction = Vector2.RIGHT.rotated(rotation)
	global_position += speed * direction * delta
	distanceTraveled += speed
	$Sprite.rotate(.1)
	if (distanceTraveled > range):
		queue_free()

func destroy():
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("handle_hit"):
			body.handle_hit(damage)
	destroy()
	
func setDamage(dmg):
	damage = dmg
	
func setRange(rng):
	range = rng

func setSpeed(spd):
	speed = spd
