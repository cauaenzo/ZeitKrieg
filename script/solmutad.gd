extends CharacterBody2D

#@export var velocidade: float = 100  # Velocidade de perseguição
#var protagonista: Node = null  # Para armazenar o protagonista
#@onready var area_de_deteccao: Area2D = $Area2D/detector
@onready var protagonista = "res://chracter/protagotemp.tscn"
@export var atirar:PackedScene
var morreu = 0
var speed = 150
var dpers = 50
var primeirotiro = 1
var direction = 1

var numero = randi() % 2 + 1
var nome_sprite = "spritemud" + str(numero)
@onready var inimigo = get_node(nome_sprite)

func _ready() -> void:
	#$temptiro.stop()
	#var numero = randi() % 4 + 1
	#inimigo = "$spritefrances" + str(numero)
	print(nome_sprite)
	inimigo.visible = true
	pass
	

func _physics_process(delta: float) -> void:
	if direction == 1 and primeirotiro == 1:
		position.x += speed * delta
		$detector/CollisionShape2D.position.x = 100
		inimigo.play("walk")
		inimigo.flip_h = false
	else:
		position.x -= speed * delta
		$detector/CollisionShape2D.position.x = -100
		inimigo.play("walk")
		inimigo.flip_h = true

	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()

func inibaleado():
	morreu += 1
	if morreu == 1:
		queue_free()
	else:
		pass

func _on_detector_body_entered(body: Node2D) -> void:
		if body.is_in_group("protagonista"):
			$temptiro.start()
			primeirotiro = 0
			if primeirotiro == 1:
				_on_tiroinimigo()
				primeirotiro = 0
				speed = 75

func _on_temptiro_timeout() -> void:
	_on_tiroinimigo()

func _on_tiroinimigo() -> void:
	var atiro = atirar.instantiate()
	atiro.position.x = position.x+4
	atiro.position.y = position.y+36
	atiro.z_index = -1
	get_tree().current_scene.add_child(atiro)


func _on_tempmoonwalk_timeout() -> void:
	direction *= -1
