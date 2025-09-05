extends VBoxContainer

@onready var velocidadeBox: SpinBox = $HBoxContainer/SpinBox
@onready var aceleracaoBox: SpinBox = $HBoxContainer3/SpinBox
@onready var desaceleracaoBox: SpinBox = $HBoxContainer4/SpinBox
@onready var puloBox: SpinBox = $HBoxContainer2/SpinBox

func _ready() -> void:
	_on_visibility_changed()

func _on_visibility_changed() -> void:
	if velocidadeBox: velocidadeBox.value = Player.SPEED
	if aceleracaoBox: aceleracaoBox.value = Player.aceleracao * 100
	if aceleracaoBox: desaceleracaoBox.value = Player.desaceleracao * 100
	var jumpValue = -(Player.JUMP_VELOCITY / 100.0)
	if puloBox: puloBox.value = jumpValue

func velocidade_changed(value: float) -> void:
	Player.SPEED = value

func aceleracao_changed(value: float) -> void:
	Player.aceleracao = value / 100.0

func desaceleracao_changed(value: float) -> void:
	Player.desaceleracao = value / 100.0

func pulo_changed(value: float) -> void:
	Player.JUMP_VELOCITY = value * -100
