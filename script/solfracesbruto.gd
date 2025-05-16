extends CharacterBody2D

#@export var velocidade: float = 100  # Velocidade de perseguição
#var protagonista: Node = null  # Para armazenar o protagonista
#@onready var area_de_deteccao: Area2D = $Area2D/detector
var morreu = 0
var velocidade = -300
var vida = 100
var avanco = 0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if avanco == 1:
		velocity.x = velocidade
		$sprbruto.play("walk")
		
	if avanco == 0:
		$sprbruto.play("idle")
		
	
	move_and_slide()

func inibaleado():
	vida -= 25
	if vida == 0:
		queue_free()
	else:
		pass

func _on_detector_body_entered(body: Node2D) -> void:
	if body.is_in_group("protagonista"):
		avanco = 1


func _on_lamina_body_entered(body: Node2D) -> void:
	if body.has_method("danolam"):
		body.danolam()
