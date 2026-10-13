extends Node2D


@onready var bola : Area2D = $"../Bola"
var pontuação_jogador1 : int = 0
var pontuação_jogador2 : int = 0
@onready var pontuação_jogador1_texto : Label = $"../UI/PainelDePontuação/Pontuação1"
@onready var pontuação_jogador2_texto : Label = $"../UI/PainelDePontuação/Pontuação2"
@onready var som_gol : AudioStreamPlayer = $SomGol


func _ready() -> void:
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	receber_inputs()


func receber_inputs() -> void:
	if Input.is_action_just_pressed("reiniciar"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("sair"):
		get_tree().quit()


func _on_gol_1_area_entered(area: Area2D) -> void:
	pontuação_jogador2 += 1
	pontuação_jogador1_texto.text = str(pontuação_jogador2)
	bola.rodar_timer()
	som_gol.play()


func _on_gol_2_area_entered(area: Area2D) -> void:
	pontuação_jogador1 += 1
	pontuação_jogador2_texto.text = str(pontuação_jogador1)
	bola.rodar_timer()
	som_gol.play()
