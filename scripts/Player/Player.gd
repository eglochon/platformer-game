extends CharacterBody2D
class_name Player

@onready var sprite: AnimatedSprite2D = $Sprite

var max_speed: int = 8000
var acceleration: int = 1000
var jump_height: int = 15000

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
		var target_vel: float = min(velocity.y + acceleration*delta, max_speed*delta)
		velocity.y = lerp(velocity.y, target_vel, 0.6)

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
