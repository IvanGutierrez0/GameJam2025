extends RigidBody2D

var isPlayerInArea = false

# Called when the node enters the scene tree for the first time.
func _start() -> void:
	#$Omnicheeks.hide()
	$PointLight2D.hide()
	$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	if $Timer.is_stopped():
		$PointLight2D.energy -= 0.005


func _on_timer_timeout() -> void:
	$Timer.stop()
	$PointLight2D.show()
	
	if isPlayerInArea:
		var player = get_node("../../Player")
		player.blind()
	
	lock_rotation = true
	rotation_degrees = 0.0
	#$Omnicheeks.rotation_degrees = -rotation_degrees
	#$Omnicheeks.show()
	


func _on_flashed_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		isPlayerInArea = true


func _on_flashed_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		isPlayerInArea = false
