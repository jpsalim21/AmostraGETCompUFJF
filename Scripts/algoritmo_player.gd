extends VBoxContainer


@onready var velocidadeValue: CustomValue = $HBoxContainer/CustomValue
@onready var puloValue: CustomValue = $HBoxContainer2/CustomValue2


@onready var balao_fala: BalaoFala = %BalaoFala
@onready var player: Player = %Player
@onready var panelPai: PanelScript = $"../.."

@onready var custom_value: CustomValue = $HBoxContainer/CustomValue
@onready var custom_value_2: CustomValue = $HBoxContainer2/CustomValue2

var estado : String = ""
var liberado = false

func _ready() -> void:
	_on_visibility_changed()
	balao_fala.terminouRoteiro.connect(terminouCutscene)
	velocidadeValue.valorMudou.connect(velocidade_changed)
	puloValue.valorMudou.connect(pulo_changed)

func terminouCutscene(nome : StringName):
	if nome == "inicial":
		player.ativo = false
		panelPai.mudarVisibilidade(true)
		puloValue.habilitar(false)
		estado = "esperandoVelocidade"
		custom_value.materialButton2.set_shader_parameter("isActive", true)
	elif nome == "pular":
		player.ativo = false
		panelPai.mudarVisibilidade(true)
		velocidadeValue.habilitar(false)
		estado = "esperandoPulo"
		custom_value_2.materialButton2.set_shader_parameter("isActive", true)
	elif nome == "diminuirPulo":
		estado = "diminuindoPulo"
		player.ativo = false
		panelPai.mudarVisibilidade(true)
		velocidadeValue.habilitar(false)
		custom_value_2.materialButton1.set_shader_parameter("isActive", true)
	elif nome == "Final":
		liberado = true
		velocidadeValue.habilitar(true)
		puloValue.habilitar(true)

func _on_visibility_changed() -> void:
	if velocidadeValue: velocidadeValue.valor = int(Player.SPEED)
	var jumpValue = -(Player.JUMP_VELOCITY / 100.0)
	if puloValue: puloValue.valor = jumpValue

func velocidade_changed(value: float) -> void:
	Player.SPEED = value
	if estado == "esperandoVelocidade" and value == 200:
		terminarCutscene()
		puloValue.habilitar(true)
		estado = ""

func pulo_changed(value: float) -> void:
	Player.JUMP_VELOCITY = value * -100
	if estado == "esperandoPulo" and value == 4:
		terminarCutscene()
		velocidadeValue.habilitar(true)
		estado = ""
	elif estado == "diminuindoPulo" and value == 3:
		terminarCutscene()
		velocidadeValue.habilitar(true)
		estado = ""

func terminarCutscene():
	panelPai.mudarVisibilidade(false)
	custom_value.materialButton1.set_shader_parameter("isActive", false)
	custom_value.materialButton2.set_shader_parameter("isActive", false)
	custom_value_2.materialButton1.set_shader_parameter("isActive", false)
	custom_value_2.materialButton2.set_shader_parameter("isActive", false)
	player.ativo = true

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("J") and liberado:
		panelPai.alternarVisibilidade()
		player.ativo = !player.ativo
