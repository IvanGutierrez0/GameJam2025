extends Area2D

var main
const VALOR_FUEGO_AZUL = 2

func _ready() -> void:
	main = get_node("../../")
	$AnimatedSprite2D.animation = "spin"
	$AnimatedSprite2D.play()


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$AnimatedSprite2D.animation = "pickup"
		$AnimatedSprite2D.play()
		main.pickedCoin(VALOR_FUEGO_AZUL)


func _on_animated_sprite_2d_animation_looped() -> void:
	if $AnimatedSprite2D.animation == "pickup":
		queue_free()
