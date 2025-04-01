extends Area2D

var velocidade = 800
var lado = 0

func _physics_process(delta :float) -> void:
	if lado > 0:
		position.x += velocidade * delta
	else:
		position.x -= velocidade * delta

#func setlado(novo_lado):
	#lado = novo_ladod

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("danolev"):
		body.danolev()
		queue_free()
