extends Node2D

var health = 3
var hud

func _ready() -> void:
	hud = get_node("./Player/HUD")

func _process(delta: float) -> void:
	pass

func playerLosesLife() -> void:
	health -= 1
	hud.updateLife(health)

func playerGainsLife() -> void:
	health += 1
	hud.updateLife(health)
