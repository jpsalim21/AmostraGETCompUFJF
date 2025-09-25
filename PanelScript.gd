class_name PanelScript
extends Panel


@onready var animation: AnimationPlayer = $"../AnimationPlayer"

func mudarVisibilidade(visivel : bool):
	if visivel:
		animation.play("Aparecer")
	else:
		animation.play("Desaparecer")
