extends State
class_name PlayerIdleState

func reset_node(player: Player) -> void:
	player.jump_count = 0
	player.can_dash = true
	player.sprite.play("idle")

func physics_process(delta: float, player: Player) -> void:
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		player.change_state("move")
	if Input.is_action_just_pressed("move_jump") and player.jump_count < player.max_jumps:
		player.jump_count += 1
		player.velocity.y = -player.jump_height * delta
		player.change_state("jump")
	if Input.is_action_just_pressed("move_dash") and player.can_dash and player.is_on_floor():
		player.change_state("dash")

	player.velocity.x = lerp(player.velocity.x, 0.0, player.friction)
