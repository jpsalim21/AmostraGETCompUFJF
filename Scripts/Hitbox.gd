extends Area2D

@export var player : Player
@onready var timer: Timer = $Timer

var invulneravel : bool = false

var estaEncostando : bool = false

func _ready() -> void:
	timer.timeout.connect(timerTerminou)

func timerTerminou():
	invulneravel = false
	if estaEncostando:
		tomouHit()

func _on_body_entered(body: Node2D) -> void:
	if invulneravel: 
		estaEncostando = true
		return
	tomouHit()

func tomouHit():
	player.velocity = Vector2.UP * 300
	player.flashSprite()
	timer.start()
	invulneravel = true

func _on_body_exited(body: Node2D) -> void:
	estaEncostando = false
