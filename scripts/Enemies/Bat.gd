extends CharacterBody2D

const SPEED = 30.0

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var death_sound: AudioStreamPlayer2D = $DeathSound
@onready var shape: CollisionShape2D = $Shape
@onready var ray_top: RayCast2D = $RayCast1
@onready var ray_bottom: RayCast2D = $RayCast2
@onready var ray_horizontal: RayCast2D = $RayCast3

# var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var pos_y: float
var change_dir: bool = true

func _ready() -> void:
	pos_y = position.y

func _physics_process(_delta: float) -> void:
	#if not is_on_floor():
	#	velocity.y += gravity * delta
	if position.y != pos_y:
		velocity.y = pos_y - position.y

	if not ray_bottom.is_colliding() or ray_horizontal.is_colliding():
		change_dir = !change_dir

	if change_dir:
		velocity.x = -SPEED
		ray_horizontal.target_position = Vector2(-16, 0)
		sprite.flip_h = false
	else:
		velocity.x = SPEED
		ray_horizontal.target_position = Vector2(16, 0)
		sprite.flip_h = true
	
	move_and_slide()

func _on_hit_box_body_entered(body: Node2D) -> void:
	if body is Player:
		collision_layer = 0
		collision_mask = 0
		sprite.hide()
		position = Vector2(-10, -10)
		Game.add_score(5)
		death_sound.play()

func _on_damage_box_body_entered(body: Node2D) -> void:
	if body is Player:
		if body.current_state.name == "Dash":
			death_sound.play()
		else:
			body.take_damage(1)

func _on_death_sound_finished() -> void:
	queue_free()
