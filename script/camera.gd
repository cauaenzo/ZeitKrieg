extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var sim = 1


func _physics_process(delta: float) -> void:
	if sim == 1:
		velocity.x = SPEED 

	move_and_slide()
