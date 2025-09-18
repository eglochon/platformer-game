extends CanvasLayer

@export var player: Player
@onready var score_label: Label = $Panel/VBox/Score

var last_health: int = -1
var heart_full: CompressedTexture2D = preload("res://assets/tiles/tile_0044.png")
var heart_empty: CompressedTexture2D = preload("res://assets/tiles/tile_0046.png")

@onready var hearts: Array[TextureRect] = [
	$Panel/VBox/HealthBar/Heart1,
	$Panel/VBox/HealthBar/Heart2,
	$Panel/VBox/HealthBar/Heart3,
	$Panel/VBox/HealthBar/Heart4,
]

func _process(delta: float) -> void:
	score_label.text = "Score: " + str(Game.score)
	if player and player.health != last_health:
		last_health = player.health
		for i in range(len(hearts)):
			if i < player.health:
				hearts[i].texture = heart_full
			else:
				hearts[i].texture = heart_empty
