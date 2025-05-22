extends CharacterBody2D

var vidasombra = 100
var comezarbatalha = 0
var tipoataque = -1
var pular = 0
var JUMP_VELOCITY = -200
var speed = 500
@onready var rewinder = $"Time Rewinder"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass 
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("timerewinding"):
		rewinder.rewind()
		vidasombra += 10
		$sombravida/bosslife.value = vidasombra
	
	if Input.is_action_pressed("timerewinding"):
		_on_time_rewinder_done_rewinding()
	
	if pular == 1 and comezarbatalha == 1:
		velocity.y = JUMP_VELOCITY
		
	if comezarbatalha == 1 and tipoataque == 1:
		position.x += speed * delta
		$sombra.play("dash")
		$sombra.flip_h = false
		$soco2/CollisionShape2D.disabled = false
		$soco/CollisionShape2D.disabled = true
		
	if comezarbatalha == 1 and tipoataque == -1:
		position.x -= speed * delta
		$sombra.play("dash")
		$sombra.flip_h = true
		$soco/CollisionShape2D.disabled = false
		$soco2/CollisionShape2D.disabled = true
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	if rewinder.rewinding:
		return 

	move_and_slide()

func sombralevadano():
	vidasombra -=10
	$sombravida/bosslife.value = vidasombra
	if vidasombra == 50:
		$CollisionShape2D.position.y = -400

func _on_detector_body_entered(body: Node2D) -> void:
	if body.is_in_group("protagonista"):
		comezarbatalha = 1
		$sombravida.visible = true
		$Timer.autostart = true
		$detector.queue_free()
		
		
func _on_timer_timeout() -> void:
	pular = 1
	$Timer2.start()

func _on_timer_2_timeout() -> void:
	pular = 0

func _on_algoafrente_body_entered(body: Node2D) -> void:
	if body.is_in_group("protagonista"):
		tipoataque *= -1
	if body.is_in_group("terreno"):
		tipoataque *= -1


func _on_soco_body_entered(body: Node2D) -> void:
	if body.has_method("danolev"):
		body.danolev()
		

func _on_time_rewinder_done_rewinding() -> void:
	pass # Replace with function body.
