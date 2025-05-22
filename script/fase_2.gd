extends Node2D

var batalhacomeca = 0
var sombraver = 0
var bossult = 0
var velocidade = 800
var ligaravanco = 0
var avanco = 800
@onready var effects = $CanvasLayer/PostProcess

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$musica.stream.loop = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var cfg : PostProcessingConfiguration = effects.configuration as PostProcessingConfiguration
	
	if sombraver == 1:
		cfg.Glitch = true
	else:
		cfg.Glitch = false
	
	if bossult == 1:
		$bossult.position.x -= velocidade * delta
		$bossult2.position.x += velocidade * delta
	
	if ligaravanco == 1:
		$sombra/sombra2.position.x -= avanco * delta



func _on_tecelam_body_entered(body: Node2D) -> void:
	$falas/fala1.visible = true
	$tecelao1.play()
	$tecelam/CollisionShape2D.queue_free()
	$cruel.start()

func _on_cruel_timeout() -> void:
	$falas/fala1.visible = false
	$percepcao/CollisionShape2D.position.y = 381


func _on_percepcao_body_entered(body: Node2D) -> void:
	$sombra/sombra.visible = true
	$percepcao.queue_free()
	$tecelam/aranha.visible = false
	sombraver = 1
	$falas/fala2.visible = true
	$sombra1.play()
	$batalhainicio.start()
	$percepcao/CollisionShape2D.queue_free()
	

func _on_batalhainicio_timeout() -> void:
	sombraver = 0
	$falas/fala2.visible = false
	$sombra/sombra.visible = false
	$sombra2.visible = true
	$chao4.queue_free()
	$musica.stop()

func _on_ultimorecurso_body_entered(body: Node2D) -> void:
	if body.is_in_group("boss"):
		$sombra2.queue_free()
		bossult = 1
		$real.start()
		$musica.play()


func _on_real_timeout() -> void:
	$ColorRect.visible = true
	$grito.play()
	$protagotemp.queue_free()
	$Camera.enabled = true
	$cutsnece.start()


func _on_cutsnece_timeout() -> void:
	$ColorRect.visible = false
	$sombra/sombra2.visible = true
	$tecelam/aranha2.visible = true
	$protamachuca.visible = true
	$falas/fala3.visible = true
	$tecelao2.play()
	$cutsnece2.start()

func _on_cutsnece_2_timeout() -> void:
	$falas/fala3.visible = false
	$falas/fala4.visible = true
	$sombra3.play()
	sombraver = 1
	$cutsnece3.start()

func _on_cutsnece_3_timeout() -> void:
	$falas/fala4.visible = false
	ligaravanco = 1
	sombraver = 0
	$sombra/sombra2.play("walk")
	$cutscenefinal.start()

func _on_cutscenefinal_timeout() -> void:
	$ColorRect.visible = true
	$grito.play()
	$cutscenerealfinal.start()

func _on_cutscenerealfinal_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/fase_3.tscn")
