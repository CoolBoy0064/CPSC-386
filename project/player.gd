extends KinematicBody2D

export var speed = 2
var velocity = Vector2(0,0);
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(100, 200)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = direction * speed
	if (Input.is_action_pressed("Right")):
		$Sprite.flip_h = 0
	if (Input.is_action_pressed("Left")):
		$Sprite.flip_h = 1
	move_and_slide(velocity)
# tutorial from Net Ninja on youtube followed for some of the code

