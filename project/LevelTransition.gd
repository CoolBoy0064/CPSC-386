extends Area2D

@export var next_scene : PackedScene


func _on_body_entered(body: Node2D) -> void:
	call_deferred("_physics_process()")
	get_tree().change_scene_to_packed(next_scene)
