extends Area2D

@export var nextLevel = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.animation = "off"
	$AnimatedSprite2D.play()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$AnimatedSprite2D.animation = "lit"
		$AnimatedSprite2D.play()
		$PointLight2D.energy = 1
		$Speaker.play()

func _on_speaker_finished() -> void:
	get_tree().change_scene_to_file(nextLevel)
