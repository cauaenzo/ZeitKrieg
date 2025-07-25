extends CharacterBody2D


var velocidade = 250
const JUMP_VELOCITY = -200.0
var grav = 10
var lado = 1
var vida1 = 100
var countdown = 1
var correndo = 0
var municao = 6
var caixademuni = 0
var abaixado = 0
var pegou_granada = false
@export var tiro:PackedScene
var animation = 0
#@export var hit:PackedScene
#@export var hit2:PackedScene

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	
	#Logica de visualizar granada no jogador
	#print(pegou_granada)
	if pegou_granada:
		$Bomba.visible = true
	else:
		$Bomba.visible = false
		
	if not is_on_floor():
		velocity.y += grav

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and abaixado == 0 and animation == 0:
		velocity.y = JUMP_VELOCITY
		$prosprite.play("jump")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction and animation == 0:
		if is_on_floor():
			if Input.is_action_pressed("run"):
				velocity.x = direction * velocidade * 1.5
			else:
				velocity.x = direction * velocidade
		else:
			velocity.x = abs(velocity.x) * direction
			
	else:
		if (is_on_floor()):
			velocity.x = move_toward(velocity.x, 0, velocidade)

	move_and_slide()

	if Input.is_action_pressed("left") and abaixado == 0 and animation == 0:
		$prosprite.flip_h = true
		lado = -1
		$prosprite.play("walk")
		
	if Input.is_action_pressed("right") and abaixado == 0 and animation == 0:
		$prosprite.flip_h = false
		lado = 1
		$prosprite.play("walk")
	
	if not Input.is_action_pressed("right") and not Input.is_action_pressed("left") and abaixado == 0 and animation == 0:
		$prosprite.play("idle")
	#if Input.is_action_just_pressed("ataque") and municao > 0:
		#var bala = tiro.instantiate()
		#
	
	if Input.is_action_just_pressed("ataque") and municao > 0 and abaixado == 0 and animation == 0:
		municao -= 1
		var atiro = tiro.instantiate()
		atiro.position.x = position.x+4
		atiro.position.y = position.y+36
		atiro.z_index = -1
		atiro.setlado(lado)
		get_tree().current_scene.add_child(atiro)
		$CanvasLayer/nummuni.text = str(municao)
		
	if Input.is_action_just_pressed("recaregar") and caixademuni > 0:
		if municao == 0:
			municao += 6
			caixademuni -= 1
			$CanvasLayer/nummuni.text = str(municao)
		if municao == 1:
			municao += 5
			caixademuni -= 1
			$CanvasLayer/nummuni.text = str(municao)
		if municao == 2:
			municao += 4
			caixademuni -= 1
			$CanvasLayer/nummuni.text = str(municao)
		if municao == 3:
			municao += 3
			caixademuni -= 1
			$CanvasLayer/nummuni.text = str(municao)
		if municao == 4:
			municao += 2
			caixademuni -= 1
			$CanvasLayer/nummuni.text = str(municao)
		if municao == 5:
			municao += 1
			caixademuni -= 1
			$CanvasLayer/nummuni.text = str(municao)
		else:
			municao += 0
		
	if Input.is_action_just_pressed("agachar") and animation == 0:
		if abaixado == 0:
			abaixado = 1
			$CollisionShape2D.disabled = true
			velocidade = 125
			$prosprite.play("down")
			
	
	if Input.is_action_pressed("left") and abaixado == 1 and animation == 0:
		$prosprite.flip_h = true
		lado = -1
		
	if Input.is_action_pressed("right") and abaixado == 1 and animation == 0:
		$prosprite.flip_h = false
		lado = 1
	
	if Input.is_action_just_pressed("jump") and animation == 0:
		if abaixado == 1:
			abaixado = 0
			$CollisionShape2D.disabled = false
			velocidade = 250

	if animation == 1:
		$prosprite.play("idle")

func ligacao():
	var municaoi = get_parent().get_node("hud").get_var("municao")
	municaoi.value = municao

func pegarmuni():
	caixademuni += 1

func danolev():
	vida1 -= 25
	$CanvasLayer/vida.value = vida1
	if vida1 == 0:
		get_tree().change_scene_to_file("res://scenes/telademorrte.tscn")

func danolam():
	get_tree().change_scene_to_file("res://scenes/telademorrte.tscn")

func animat():
	animation = 1

func trassiao():
	$CanvasLayer.visible = false

func existe():
	pass
