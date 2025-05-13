extends Area2D

var velocidade = 800
var lado = 1



func _physics_process(delta :float) -> void:
	if lado > 0:
		position.x += velocidade * delta
	else:
		position.x -= velocidade * delta
		$Bala.flip_v = true

func setlado(novo_lado):
	lado = novo_lado

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("terreno"):
		queue_free()
	if body.has_method("inibaleado"):
		body.inibaleado()
		queue_free()

func _on_destruidor_timeout() -> void:
	queue_free()
