extends Area2D

func _ready() -> void:
	show()
	$AnimatedSprite2D.animation  = "fly"
	$AnimatedSprite2D.play()

func _process(delta: float) -> void:
	pass
