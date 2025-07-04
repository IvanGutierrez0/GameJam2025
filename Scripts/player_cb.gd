extends CharacterBody2D
signal hit

#Esto deberán de ser constantes, hecho así para las pruebas
@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@export var health = 3
@export var inmuneTime = 2.0

var isInmune = false

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


func _on_damage_area_body_entered(_body: Node2D) -> void:
	if not isInmune:
		health -= 1
		if health <= 0:
			hide()
		
		var timer = Timer.new()
		add_child(timer)
		
		isInmune = true
		timer.wait_time = inmuneTime
		timer.timeout.connect(func(): isInmune = false)
		timer.start()
