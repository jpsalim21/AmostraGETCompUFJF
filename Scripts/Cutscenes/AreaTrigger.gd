extends Area2D

@export var oneTime : bool = true
@onready var balao_fala: BalaoFala = %BalaoFala
@export var roteiro : Roteiro = null

func _ready() -> void:
	body_entered.connect(objEntered)

func objEntered(_body : Node2D):
	balao_fala.roteiroAtual = roteiro.duplicate()
	if oneTime:
		queue_free()
