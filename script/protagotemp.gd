extends CharacterBody2D

var velocidadedotempo: Vector2 = Vector2.ZERO
var dir: Vector2 = Vector2.ZERO
var accel: float = 10.0
var friction: float = 8.0
var velocidade = 250
var JUMP_VELOCITY = -200.0
var grav = 10
var lado = 1
var vida1 = 100
var energia = 30
var countdown = 1
var correndo = 0
var abaixado = 0
var jaacel = 0
var gambiarra = 0
@onready var rewinder = $"Time Rewinder"
@onready var effects = $CanvasLayer/PostProcess
# Função de inicialização
func _ready() -> void:
	pass

# Função de processamento de física (chamada a cada frame)
func _physics_process(delta: float) -> void:
	var cfg : PostProcessingConfiguration = effects.configuration as PostProcessingConfiguration
	if not is_on_floor():
		velocity.y += grav
	if rewinder.rewinding:
		return 

	if Input.is_action_just_pressed("timerewinding") and energia == 30:
		rewinder.rewind()

	move_and_slide()

	# Controle de pulo
	if Input.is_action_just_pressed("jump") and is_on_floor() and abaixado == 0:
		velocity.y = JUMP_VELOCITY

	# Pega a direção de movimento com base no input do usuário
	var direction := Input.get_axis("left", "right")
	
	# Se houver input de direção
	if direction:
		if is_on_floor():
			if Input.is_action_pressed("run"):
				velocity.x = direction * velocidade * 1.2  # Acelera se estiver correndo
			else:
				velocity.x = direction * velocidade  # Velocidade normal
		else:
			velocity.x = abs(velocity.x) * direction  # Mantém a direção mesmo no ar
	else:
		# Se não houver input, desacelera o personagem
		if is_on_floor():
			velocity.x = move_toward(velocity.x, 0, velocidade)  # Desacelera quando não estiver se movendo


	if Input.is_action_pressed("timerewinding") and energia == 30:  # Defina isso no Input Map (ex: tecla Z)
		_on_time_rewinder_done_rewinding()
		$tempodepoder.start()
		cfg.Glitch = true
		energia -= 30
		$CanvasLayer2/tempoenergia.value = energia
	# Aplica o movimento com a função move_and_slide (sem argumentos)
	move_and_slide()
	
	if Input.is_action_pressed("left") or Input.is_action_pressed("right") or Input.is_action_just_pressed("jump") and gambiarra == 1:
		cfg.Glitch = false
	
	# Controle de direção (lado do personagem)
	if Input.is_action_pressed("left"):
		lado = -1
		#$macacocinza1.flip_h = false
		#$macacocinza1.play("walk")

	if Input.is_action_pressed("right"):
		lado = 1
		#$macacocinza1.flip_h = true
		#$macacocinza1.play("walk")

	# Controle de agachar
	if Input.is_action_just_pressed("agachar") and jaacel == 0:
		if abaixado == 0:
			abaixado = 1
			$CollisionShape2D.disabled = true
			velocidade = 125

	if Input.is_action_just_pressed("jump") and jaacel == 0:
		if abaixado == 1:
			abaixado = 0
			$CollisionShape2D.disabled = false
			velocidade = 250
	
	#if Input.is_action_just_pressed("pararpoder"):
		#$paralisar/CollisionShape2D3.disabled = false
		#$temppoderpar.start()
		
		

	# Controle de aceleração
	if Input.is_action_just_pressed("acelerar") and jaacel == 0 and abaixado == 0:
		jaacel = 1
		velocidade = 750
		$tempdacel.start()
		cfg.particle_storm = true
		
	if Input.is_action_pressed("left") or Input.is_action_pressed("right") or Input.is_action_just_pressed("jump") and jaacel == 0:
		cfg.particle_storm = false
		
	
	if Input.is_action_just_pressed("ataque"):
		if lado == -1:
			$attesq/CollisionShape2D.disabled = false
			$attesqti.start()
		else:
			$attdir/CollisionShape2D.disabled = false
			$attdirti.start()
		
func danolev():
	vida1 -= 25
	if vida1 <= 0:
		queue_free()

# Funções para o controle de aceleração
func _on_tempdacel_timeout() -> void:
	jaacel = 0
	velocidade = 250

# Função para o controle de colisões de ataque
func _on_attesq_body_entered(body: Node2D) -> void:
	if body.has_method("inibaleado"):
		body.inibaleado()

func _on_attdir_body_entered(body: Node2D) -> void:
	if body.has_method("inibaleado"):
		body.inibaleado()

# Funções para o controle de animações de ataque
func _on_attesqti_timeout() -> void:
	$attesq/CollisionShape2D.disabled = true

func _on_attdirti_timeout() -> void:
	$attdir/CollisionShape2D.disabled = true


func _on_tempodepoder_timeout() -> void:
	gambiarra = 1


func _on_time_rewinder_done_rewinding() -> void:
	pass # Replace with function body.


func _on_paralisar_body_entered(body: Node2D) -> void:
	if body.has_method("paralizar"):
		body.paralizar()


func _on_temppoderpar_timeout() -> void:
	$paralisar/CollisionShape2D3.disabled = true
	$CanvasLayer2/tempoenergia.value = energia


func _on_recaregar_timeout() -> void:
	$CanvasLayer2/tempoenergia.value = energia
	if energia < 30:
		energia += 1
	if energia == 30:
		energia == energia
