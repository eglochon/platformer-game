extends CharacterBody2D

const SPEED = 300.0

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var ray_top: RayCast2D = $RayCast1
@onready var ray_bottom: RayCast2D = $RayCast2
@onready var ray_left: RayCast2D = $RayCast4
@onready var ray_right: RayCast2D = $RayCast3

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var change_dir: bool = true

func _physics_process(delta: float) -> void:
	#if not is_on_floor():
	#	velocity.y += gravity * delta

	if not ray_bottom.is_colliding():
		change_dir = !change_dir
	if change_dir:
		velocity.x = -SPEED
		sprite.flip_h = false
	else:
		velocity.x = SPEED
		sprite.flip_h = true
	
	move_and_slide()
