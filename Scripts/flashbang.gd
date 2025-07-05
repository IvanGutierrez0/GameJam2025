extends RigidBody2D

var isPlayerInArea = false
var areaList = []

# Called when the node enters the scene tree for the first time.
func _start() -> void:
	#$Omnicheeks.hide()
	$PointLight2D.hide()
	$Timer.start()

func _ready() -> void:
	$Animation.animation = "flashbang"
	$Animation.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	if $Timer.is_stopped():
		$PointLight2D.energy -= 0.005


func _on_timer_timeout() -> void:
	$Speaker.play()
	$Timer.stop()
	$PointLight2D.show()
	$Animation.animation = "explosion"
	$Animation.play()
	
	if isPlayerInArea:
		var player = get_node("../../Player")
		player.blind()
	if areaList.size() > 0:
		for it in areaList:
			var enemy = get_node("../../Enemies/" + it.name)
			enemy.damage()
	
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


func _on_flashed_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		areaList.append(area)


func _on_flashed_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		areaList.erase(area)
