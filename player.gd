extends Area2D
signal hit

@export var speed = 400 # How fast the player will move (pixels/sec).
@export var jumpSpeed: float = -400.0
@export var Gravity: float = 900.0

var screen_size # Size of the game window.
var isGrounded

@onready var ground_ray_cast = $GroundRayCast2D

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO # The player's movement vector.
	
	if ground_ray_cast.is_colliding():
		var collider = ground_ray_cast.get_collider()
		if collider.is_in_group("floor"):
			isGrounded = true
	else:
		isGrounded = false
	
	if Input.is_action_pressed("moveRight"):
		velocity.x += speed
	elif Input.is_action_pressed("moveLeft"):
		velocity.x -= speed
	
	if not isGrounded:
		velocity.y += Gravity * delta * 100
	else:
		if velocity.y > 0:
			velocity.y = 0

	if Input.is_action_pressed("jump") and isGrounded:
		velocity.y = jumpSpeed
	
	if velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
	elif velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	
	if velocity.length() > 0:
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)


func _on_body_entered(body: Node2D) -> void:
	hide() # Player disappears after being hit.
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)
