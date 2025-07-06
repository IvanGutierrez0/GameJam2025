extends Node2D

@export var offsetX = 2.0
@export var offsetY = 1.5


var health = 3
var hud

func _ready() -> void:
	hud = get_node("./Player/HUD")
	$ParallaxBackground.offset.x = offsetX * $Player.position.x
	$ParallaxBackground.offset.y = offsetY * $Player.position.y

func _process(delta: float) -> void:
	pass

func setPlayerLifes(lifes : int) -> void:
	health = lifes
	hud.updateLife(health)

func pickedCoin(tipo: int) -> void:
	hud.pickedCoin(tipo)
