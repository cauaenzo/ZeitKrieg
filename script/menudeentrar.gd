extends Control



func _ready() -> void:
	pass



func _on_butao_inicio_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/fase_1.tscn")

func _on_butao_sair_pressed() -> void:
	get_tree().quit()


func _on_butao_controles_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/controlesdojogo.tscn")

# mouse entrar

func _on_butao_inicio_mouse_entered() -> void:
	pass


func _on_butao_controles_mouse_entered() -> void:
	pass # Replace with function body.


func _on_butao_sair_mouse_entered() -> void:
	pass # Replace with function body.

# mouse sair 

func _on_butao_inicio_mouse_exited() -> void:
	pass


func _on_butao_controles_mouse_exited() -> void:
	pass # Replace with function body.


func _on_butao_sair_mouse_exited() -> void:
	pass # Replace with function body.
