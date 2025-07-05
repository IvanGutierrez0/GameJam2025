extends Area2D

@export var path = [Vector2(100, 100), Vector2(300, 100), Vector2(300, 300), Vector2(100, 300)]
var speed = 100
var current_point = 0
var initialPos

func _ready() -> void:
	show()
	$AnimatedSprite2D.animation  = "fly"
	$AnimatedSprite2D.play()
	initialPos = position

func _process(delta):
	var target = path[current_point] + initialPos
	var direction = (target - position).normalized()
	position += direction * speed * delta

	if position.distance_to(target) < 5:
		current_point = (current_point + 1) % path.size()
