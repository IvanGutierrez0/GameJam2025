extends Node2D

var health = 3
var hud

func _ready() -> void:
	hud = get_node("./Player/HUD")
	$ParallaxBackground.offset.x = 2 * $Player.position.x
	$ParallaxBackground.offset.y = 1.5 * $Player.position.y

func _process(delta: float) -> void:
	pass

func playerLosesLife() -> void:
	health -= 1
	hud.updateLife(health)

func playerGainsLife() -> void:
	health += 1
	hud.updateLife(health)

func pickedCoin(tipo: int) -> void:
	hud.pickedCoin(tipo)
