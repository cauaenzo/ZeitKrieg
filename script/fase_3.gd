extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$musicafim.stream.loop = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_chamarrobo_body_entered(body: Node2D) -> void:
	if body.is_in_group("protagonista"):
		$StaticBody2D/CollisionShape2D3.position.x = 55236


func _on_zeitkrieg_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://scenes/zeitkrieg.tscn")
