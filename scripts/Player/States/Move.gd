extends State
class_name PlayerMoveState

func reset_node(player: Player) -> void:
	player.sprite.play("move")

func physics_process(delta: float, player: Player) -> void:
	if Input.is_action_pressed("move_right"):
		var target_vel: float = min(player.velocity.x + player.acceleration*delta, player.max_speed*delta)
		player.velocity.x = lerp(player.velocity.x, target_vel, player.weight)
	elif Input.is_action_pressed("move_left"):
		var target_vel: float = max(player.velocity.x - player.acceleration*delta, -player.max_speed*delta)
		player.velocity.x = lerp(player.velocity.x, target_vel, player.weight)
	else:
		player.change_state("idle")

	if Input.is_action_just_pressed("move_jump") and player.jump_count < player.max_jumps:
		player.jump_count += 1
		player.velocity.y = -player.jump_height * delta
		player.change_state("jump")
	if Input.is_action_just_pressed("move_dash") and player.can_dash and player.is_on_floor():
		player.change_state("dash")
