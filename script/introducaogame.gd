extends Node


func _on_aparece_timeout() -> void:
	$animacao.play("aparecer")


func _on_desaparece_timeout() -> void:
	$animacao.play("desaparece")


func _on_irmenu_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/menudeentr.tscn")
