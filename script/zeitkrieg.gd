extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_pressed("jump"):
		get_tree().change_scene_to_file("res://scenes/menudeentr.tscn")


func _on_nome_timeout() -> void:
	$AnimationPlayer.play("titulo")


func _on_subtitulo_timeout() -> void:
	$AnimationPlayer.play("subtitulo")


func _on_beta_timeout() -> void:
	$AnimationPlayer.play("beta")
