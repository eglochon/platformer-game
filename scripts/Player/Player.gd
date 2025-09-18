extends CharacterBody2D
class_name Player

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var jump_sound: AudioStreamPlayer2D = $Jump
@onready var hit_sound: AudioStreamPlayer2D = $Hit

var max_speed: int = 8000
var acceleration: int = 1000
var jump_height: int = 18000

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var friction: float = 0.22
var weight: float = 1

# States
var current_state: State
var can_dash: bool = true
var max_jumps: int = 3
var jump_count: int = 0

@onready var states: Dictionary[String, State] = {
	"idle": $States/Idle,
	"dash": $States/Dash,
	"fall": $States/Fall,
	"jump": $States/Jump,
	"move": $States/Move,
}

func _ready() -> void:
	change_state("idle")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	var direction := Input.get_axis("move_left", "move_right")
	if direction < 0:
		sprite.flip_h = false
	elif direction > 0:
		sprite.flip_h = true

	current_state.physics_process(delta, self)
	move_and_slide()

func change_state(state_name: String) -> void:
	if state_name in states:
		var new_state = states.get(state_name)
		current_state = new_state
		current_state.reset_node(self)
