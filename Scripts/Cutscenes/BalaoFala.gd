class_name BalaoFala
extends MarginContainer

signal comecouCutscene(nomeRoteiro : StringName)
signal terminouRoteiro(nomeRoteiro : StringName)
signal novaFala(humor : String)

@onready var textLabel: RichTextLabel = $Panel2/MarginContainer/RichTextLabel

var roteiroAtual : Roteiro = null:
	set(value):
		roteiroAtual = value
		if value == null: return
		visible = true
		comecouCutscene.emit(roteiroAtual.nomeRoteiro)
		indexAtual = 0
var indexAtual : int = 0:
	set(value):
		if roteiroAtual == null: return
		if roteiroAtual.falas.size() > value:
			indexAtual = value
			displayText(roteiroAtual.falas[indexAtual].texto)
			novaFala.emit(roteiroAtual.falas[indexAtual].humor)
		else:
			terminouRoteiro.emit(roteiroAtual.nomeRoteiro)
			print("Rodei isso aqui com roteiro ", roteiroAtual.nomeRoteiro)
			roteiroAtual = null
			visible = false

var timePerCaracter = 0.025

var tween : Tween

func displayText(txt : String):
	textLabel.text = txt
	textLabel.visible_ratio = 0
	var tempoTotal = len(txt) * timePerCaracter
	tween = create_tween()
	tween.tween_property(textLabel, "visible_ratio", 1.0, tempoTotal)
	await tween.finished
	tween = null

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Cima"):
		if tween:
			tween.kill()
			tween = null
			textLabel.visible_ratio = 1
		else:
			indexAtual += 1
