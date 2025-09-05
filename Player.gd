class_name Player
extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

static var SPEED : float = 200.0
static var JUMP_VELOCITY : float = -300.0

static var aceleracao : float = 0.1
static var desaceleracao : float = 0.1

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("Cima") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	var direction := Input.get_axis("Esquerda", "Direita")
	if direction:
		velocity.x = move_toward(velocity.x, direction * SPEED, aceleracao * SPEED)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * desaceleracao)
	
	atualizaSprite()
	move_and_slide()

func atualizaSprite():
	if velocity != Vector2.ZERO:
		sprite.flip_h = velocity.x < 0
		if velocity.y == 0:
			sprite.play("Run")
		else:
			if velocity.y > 0:
				sprite.play("Descer")
			else:
				sprite.play("Pular")
	else:
		sprite.play("Idle")
