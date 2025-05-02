extends CharacterBody2D

#@export var velocidade: float = 100  # Velocidade de perseguição
#var protagonista: Node = null  # Para armazenar o protagonista
#@onready var area_de_deteccao: Area2D = $Area2D/detector
@export var caixmunic:PackedScene
@onready var protagonista = "res://chracter/protagotemp.tscn"
@export var atirar:PackedScene
var morreu = 0
var velocid = 150
var dpers = 50
var primeirotiro = 1
var direction = 1

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if direction == 1 and primeirotiro == 1:
		position.x += velocid * delta
		$detector/CollisionShape2D.position.x = 100
		#inimigo.play("walk")
		#inimigo.flip_h = false
	else:
		position.x -= velocid * delta
		$detector/CollisionShape2D.position.x = -100
		#inimigo.play("walk")
		#inimigo.flip_h = true

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

func _on_detector_body_entered(body: Node2D) -> void:
		if body.is_in_group("protagonista"):
			$temptiro.start()
			if primeirotiro == 1:
				_on_tiroinimigo()
				primeirotiro = 0
				velocid = 75

func _on_temptiro_timeout() -> void:
	_on_tiroinimigo()

func _on_tiroinimigo() -> void:
	var atiro = atirar.instantiate()
	atiro.position.x = position.x+4
	atiro.position.y = position.y+4
	atiro.z_index = -1
	get_tree().current_scene.add_child(atiro)


func _on_tempmoonwalk_timeout() -> void:
	direction *= -1

func paralizar():
	velocid == 0
