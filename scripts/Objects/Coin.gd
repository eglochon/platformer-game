extends Node2D
class_name Coin

@export var sprite_node: AnimatedSprite2D
@export var sound_node: AudioStreamPlayer2D

func _on_body_entered(body: Node2D) -> void:
	if body is Player and visible:
		Game.add_score(1)
		sprite_node.hide()
		sound_node.play()

func _on_sound_finished() -> void:
	queue_free()
