extends CharacterBody2D
signal hit

#Esto deberán de ser constantes, hecho así para las pruebas
@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@export var health = 3
@export var inmuneTime = 2.0
var lastDirection = 1

@export var lightEnergy = 0.5
var transparency = 0

var main

var flashbang_scene = preload("res://Scenes/flashbang.tscn")
var flashbang
var projectiles_container

func _start() -> void:  
	show()

func _ready():
	main = get_node("../")
	$AnimatedSprite2D.flip_h = true
	$Flash.hide()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("moveLeft", "moveRight")
	if direction:
		velocity.x = direction * SPEED
		lastDirection = direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x > 0
	if not is_on_floor():
		if velocity.y > 0:
			$AnimatedSprite2D.animation = "jumpDown"
		else:
			$AnimatedSprite2D.animation = "jumpUp"
	
	if velocity.length() == 0:
		$AnimatedSprite2D.animation = "idle"
	
	$AnimatedSprite2D.play()
	move_and_slide()
	
	if not $Timers/FlashedTimer.is_stopped(): 
		transparency -= 0.005
		$Flash.modulate.a = transparency
	
	if Input.is_action_pressed("useHab") and $Timers/PowerTimer.is_stopped():
		spawnFlashbang(lastDirection) 
		$Timers/PowerTimer.start()

func spawnFlashbang(direction) -> void:
	flashbang = flashbang_scene.instantiate()
	flashbang.position.x = global_position.x + 10 * direction
	flashbang.position.y = global_position.y + 5
	flashbang.linear_velocity = Vector2(250 * direction + velocity.x, -250)
	
	projectiles_container = get_tree().get_root().get_node("Main/Projectiles")
	projectiles_container.add_child(flashbang)

func _on_inmunity_timer_timeout() -> void:
	$Timers/InmunityTimer.stop()

func _on_power_timer_timeout() -> void:
	$Timers/PowerTimer.stop()

func _on_damage_area_area_entered(area: Area2D) -> void:
	if $Timers/InmunityTimer.is_stopped() and area.is_in_group("Enemy"):
		health -= 1
		main.playerLosesLife()
		
		if health <= 0: 
			hide()
		
		$Timers/InmunityTimer.start()
	elif area.is_in_group("Item"):
		if area.name == "HeartItem":
			if health < 3:
				health += 1
				main.playerGainsLife()

func blind() -> void:
	transparency = 1
	$Flash.show()
	$Timers/FlashedTimer.start()

func _on_flashed_timer_timeout() -> void:
	$Timers/FlashedTimer.stop()
	$Flash.hide()
	transparency = 0
