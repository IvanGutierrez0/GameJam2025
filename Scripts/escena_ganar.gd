extends Control

func _ready():
	# Iniciar música
	var musica = $AudioStreamPlayer
	musica.play()
	musica.finished.connect(_on_musica_finished)

	# Conectar botones
	var btn_jugar = get_node("Jugar")
	var btn_salir = get_node("Salir")

	if btn_jugar:
		btn_jugar.pressed.connect(_on_jugar_pressed)
	else:
		print("No se encontró el botón Jugar")

	if btn_salir:
		btn_salir.pressed.connect(_on_salir_pressed)
	else:
		print("No se encontró el botón Salir")


func _on_jugar_pressed():
	print("¡Botón JUGAR pulsado!")
	get_tree().change_scene_to_file("res://escena_principal.tscn")


func _on_salir_pressed():
	print("¡Botón SALIR pulsado!")
	get_tree().quit()


func _on_musica_finished():
	$AudioStreamPlayer.play()


