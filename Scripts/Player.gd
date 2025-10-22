class_name Player
extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer
@onready var balao_fala: BalaoFala = %BalaoFala

var animationLock : bool = false

static var SPEED : float = 50.0
static var JUMP_VELOCITY : float = -200.0

static var aceleracao : float = 0.1
static var desaceleracao : float = 0.1

var elapsedTime : float = 0
var maxTime : float = 1
var anchorPos : Vector2

var ativo : bool = true

func _ready() -> void:
	SPEED = 50.0
	JUMP_VELOCITY = -200
	anchorPos = global_position
	balao_fala.comecouCutscene.connect(comecouCutscene)
	balao_fala.terminouRoteiro.connect(terminouCutscene)
	balao_fala.novaFala.connect(comecaFala)

func comecaFala(humor : String):
	match humor:
		"normal": sprite.play("Acenar")
		"assustado": sprite.play("Acenar2")

func comecouCutscene(nome : StringName):
	ativo = false
	sprite.play("Acenar2")

func terminouCutscene(nome : StringName):
	ativo = true

func _physics_process(delta: float) -> void:
	elapsedTime += delta

	if not is_on_floor():
		velocity += get_gravity() * delta
	elif elapsedTime > maxTime:
		anchorPos = global_position
		elapsedTime = 0
	
	if global_position.y > 80:
		global_position = anchorPos
	
	if !ativo:
		velocity.x = 0
		move_and_slide()
		return
	
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
	if animationLock: return
	if velocity.x < 0:
		sprite.flip_h = true
	elif velocity.x > 0:
		sprite.flip_h = false
	
	if velocity != Vector2.ZERO:
		if velocity.y == 0:
			sprite.play("Run")
		else:
			if velocity.y > 0:
				sprite.play("Descer")
			else:
				sprite.play("Pular")
	else:
		sprite.play("Idle")

func flashSprite():
	animationLock = true
	set_physics_process(false)
	sprite.play("TomarDano")
	timer.start(0.5)
	await timer.timeout
	animationLock = false
	set_physics_process(true)
	
	for i in range(5):
		sprite.self_modulate.a = 0.2
		timer.start(0.2)
		await timer.timeout
		sprite.self_modulate.a = 1
		timer.start(0.2)
		await timer.timeout
