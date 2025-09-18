extends State
class_name PlayerDashState

@onready var dash_animation: PackedScene = preload("res://scenes/Player/DashAnimation.tscn")

var direction: bool

func reset_node(player: Player) -> void:
	direction = player.sprite.flip_h
	player.can_dash = false
	player.sprite.play("dash")
	if direction:
		player.velocity.x = 300
	else:
		player.velocity.x = -300
	await get_tree().create_timer(0.2).timeout
	player.change_state("idle")

func physics_process(_delta: float, player: Player) -> void:
	var dash_node: Node = dash_animation.instantiate()
	dash_node.flip_h = direction
	dash_node.position = player.global_position
	player.get_parent().add_child(dash_node)
