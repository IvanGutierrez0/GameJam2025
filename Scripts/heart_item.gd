extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.animation = "spin"
	$AnimatedSprite2D.play()


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		queue_free()
