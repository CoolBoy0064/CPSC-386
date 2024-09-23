extends Area2D

@export var range = 7500
@export var damage = 50
var speed = 750
var distanceTraveled = 0
var direction

func _physics_process(delta):
	direction = Vector2.RIGHT.rotated(rotation)
	global_position += speed * direction * delta
	distanceTraveled += speed
	if (distanceTraveled > range):
		queue_free()

func destroy():
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("handle_hit"):
			body.handle_hit(damage)
	destroy()
