extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_manopla_body_entered(body: Node2D) -> void:
	$comandante.visible = true
	$paralizacao/CollisionShape2D.position.y = 0
	$manopla.queue_free()


func _on_paralizacao_body_entered(body: Node2D) -> void:
	$dialogo.play()
	$falas.visible = true
	$tempo1.start()
	if body.has_method("animat"):
		body.animat()

func _on_tempo_1_timeout() -> void:
	$falas.visible = false
	$comandante.play("atirar")
	$fase2.start()

func _on_fase_2_timeout() -> void:
	$tiro.play()
	$escuridao.visible = true
	$finalmesmo.start()

func _on_finalmesmo_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/fase_2.tscn")


func _on_desaparecer_body_entered(body: Node2D) -> void:
	if body.has_method("trassiao"):
		body.trassiao()
