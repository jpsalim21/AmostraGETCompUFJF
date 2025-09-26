class_name PanelScript
extends Panel


@onready var animation: AnimationPlayer = $"../AnimationPlayer"
var v = false


func mudarVisibilidade(visivel : bool):
	if visivel:
		animation.play("Aparecer")
		v = true
	else:
		v = false
		animation.play("Desaparecer")

func alternarVisibilidade():
	mudarVisibilidade(!v)
