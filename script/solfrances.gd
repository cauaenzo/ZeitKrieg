extends CharacterBody2D

#@export var velocidade: float = 100  # Velocidade de perseguição
#var protagonista: Node = null  # Para armazenar o protagonista
#@onready var area_de_deteccao: Area2D = $Area2D/detector

@export var caixmunic:PackedScene
@export var atirar:PackedScene
var morreu = 0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()

func inibaleado():
	morreu += 1
	if morreu == 1:
		queue_free()
		var caixis = caixmunic.instantiate()
		caixis.position.x = position.x
		caixis.position.y = position.y+40
		caixis.z_index = -1
		get_tree().current_scene.add_child(caixis)
	else:
		pass


func _on_timertemporario_timeout() -> void:
	var atiro = atirar.instantiate()
	atiro.position.x = position.x+4
	atiro.position.y = position.y+4
	atiro.z_index = -1
	get_tree().current_scene.add_child(atiro)
