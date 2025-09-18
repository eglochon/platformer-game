extends Sprite2D

var tween: Tween

func _ready() -> void:
	tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 0, 0.2)

func _process(_delta: float) -> void:
	if modulate.a < 0.01:
		queue_free()
