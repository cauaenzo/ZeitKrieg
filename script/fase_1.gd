extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$musicsfsse1.stream.loop = true



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass





func _on_porta_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	get_tree().change_scene_to_file("res://scenes/transisaofass_1a_2.tscn")
