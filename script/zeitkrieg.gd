extends Control

@onready var effects = $PostProcess
var efeito = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$musica.stream.loop = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var cfg : PostProcessingConfiguration = effects.configuration as PostProcessingConfiguration
	
	if Input.is_action_pressed("jump"):
		get_tree().change_scene_to_file("res://scenes/menudeentr.tscn")
	
	if efeito == 1:
		cfg.Glitch = true


func _on_nome_timeout() -> void:
	$AnimationPlayer.play("titulo")


func _on_subtitulo_timeout() -> void:
	$AnimationPlayer.play("subtitulo")


func _on_beta_timeout() -> void:
	$AnimationPlayer.play("beta")


func _on_timer_timeout() -> void:
	efeito = 1
