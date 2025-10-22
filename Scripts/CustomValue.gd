class_name CustomValue
extends HBoxContainer

@onready var label: Label = $Panel/Label

@export var step : float = 1
@export var minValue : float = 0
@export var maxValue : float = 800
@onready var button: Button = $Button
@onready var button_2: Button = $Button2

var materialButton1 : ShaderMaterial
var materialButton2 : ShaderMaterial

func _ready() -> void:
	materialButton1 = button.material
	materialButton2 = button_2.material
	pass

signal valorMudou(valor)

var valor : float = 0:
	set(value):
		value = max(minValue, value)
		value = min(maxValue, value)
		valor = value
		label.text = str(valor)
		valorMudou.emit(valor)

func diminuir() -> void:
	valor -= step

func aumentar() -> void:
	valor += step

func habilitar(valor : bool):
	button.disabled = !valor
	button_2.disabled = !valor
