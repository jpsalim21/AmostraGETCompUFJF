extends Node

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("P"):
		get_tree().change_scene_to_file("res://CenaPrincipal.tscn")
