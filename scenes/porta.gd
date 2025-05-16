extends Area2D

var tem_granada = false
var explodiu = false
@onready var jogador = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("fechado")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if tem_granada:
		$Bomba.visible = true
		if jogador && jogador.position.x < position.x - 600:
			explodiu = true
			$AnimatedSprite2D.play("aberto")
			tem_granada = false
	else:
		$Bomba.visible = false


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("protagonista") && body.pegou_granada:
		jogador = body
		body.pegou_granada = false
		tem_granada = true
