extends RigidBody2D


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
	lock_rotation = true
	rotation_degrees = 0.0
	#$Omnicheeks.rotation_degrees = -rotation_degrees
	#$Omnicheeks.show()
	
