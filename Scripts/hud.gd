extends CanvasLayer

func _ready() -> void:
	$Heart0.animation = "Alive"
	$Heart1.animation = "Alive"
	$Heart2.animation = "Alive"

func _process(_delta: float) -> void:
	$Heart0.play()
	$Heart1.play()
	$Heart2.play()	

func updateLife(health: int) -> void:
	if health == 3:
		$Heart0.animation = "Alive"
		$Heart1.animation = "Alive"
		$Heart2.animation = "Alive"
	elif health == 2:
		$Heart0.animation = "Alive"
		$Heart1.animation = "Alive"
		$Heart2.animation = "Dead"
	elif health == 1:
		$Heart0.animation = "Alive"
		$Heart1.animation = "Dead"
		$Heart2.animation = "Dead"
	elif health == 0:
		$Heart0.animation = "Dead"
		$Heart1.animation = "Dead"
		$Heart2.animation = "Dead"

func pickedCoin(tipo: int) -> void:
	var currentScore = int($ScorePoints.text)
	currentScore += tipo * 100
	$ScorePoints.text = str(currentScore)
