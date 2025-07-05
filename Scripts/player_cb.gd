extends CharacterBody2D
signal hit

#Esto deberán de ser constantes, hecho así para las pruebas
@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@export var health = 3
@export var inmuneTime = 2.0

var flashbang_scene = preload("res://Scenes/flashbang.tscn")
var flashbang

func _start() -> void:  
	show()

func _ready():
	pass

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("moveLeft", "moveRight")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	if not is_on_floor():
		$AnimatedSprite2D.animation = "jump"
	
	if velocity.length() == 0:
		$AnimatedSprite2D.animation = "idle"
	
	$AnimatedSprite2D.play()
	move_and_slide()
	
	if Input.is_action_pressed("useHab") and $Timers/PowerTimer.is_stopped():
		spawnFlashbang(direction) 
		$Timers/PowerTimer.start()

func spawnFlashbang(direction) -> void:
	flashbang = flashbang_scene.instantiate()
	flashbang.position = Vector2.ZERO
	#flashbang.linear_velocity = Vector2(200 * direction, -200.0)
	add_child(flashbang)
	$Timers/FlashbangTimer.start()

func _on_damage_area_body_entered(body: Node2D) -> void:
	if $Timers/InmunityTimer.is_stopped() and body.is_in_group("Enemy"):
		health -= 1
		if health <= 0: 
			hide()
		
		$Timers/InmunityTimer.start()


func _on_inmunity_timer_timeout() -> void:
	$Timers/InmunityTimer.stop()

func _on_power_timer_timeout() -> void:
	$Timers/PowerTimer.stop()


func _on_flashbang_timer_timeout() -> void:
	$Timers/FlashbangTimer.stop()
	remove_child(flashbang)
