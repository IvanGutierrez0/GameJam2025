extends Area2D

@export var path = [Vector2(100, 100), Vector2(300, 100), Vector2(300, 300), Vector2(100, 300)]
@export var speed = 100
@export var followDistance = 200
@export var health = 1

var current_point = 0
var initialPos

var player
var main

func _ready() -> void:
	show()
	$AnimatedSprite2D.animation  = "move"
	$AnimatedSprite2D.play()
	
	initialPos = position
	player = get_node("../../Player")
	main = get_node("../../")

func _process(delta):
	var direction
	
	if position.distance_to(player.position) < followDistance:
		direction = (player.position - position).normalized()
		position += direction * speed * delta
	else:
		var target = path[current_point] + initialPos
		direction = (target - position).normalized()
		position += direction * speed * delta

		if position.distance_to(target) < 5:
			current_point = (current_point + 1) % path.size()
	
	$AnimatedSprite2D.flip_h = direction.x > 0

func damage():
	health -= 1
	if health <= 0:
		main.pickedCoin(5)
		$AnimatedSprite2D.animation = "dead"
		speed = 0


func _on_animated_sprite_2d_animation_looped() -> void:
	if $AnimatedSprite2D.animation == "dead":
		queue_free()
