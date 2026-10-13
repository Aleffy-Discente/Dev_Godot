extends StaticBody2D

@export var jogador1 : bool
var velocidade_movimento : int = 500


func _process(delta: float) -> void:
	movimentar_jogador(delta)
	limitar_movimento()


func movimentar_jogador(delta : float) -> void:
	if jogador1:
		if Input.is_action_pressed("mv-cima-1"):
			position.y -= velocidade_movimento * delta	
		elif Input.is_action_pressed("mv-baixo-1"):
			position.y += velocidade_movimento * delta	
	else:
		if Input.is_action_pressed("mv-cima-2"):
			position.y -= velocidade_movimento * delta	
		elif Input.is_action_pressed("mv-baixo-2"):
			position.y += velocidade_movimento * delta	
			

func limitar_movimento() -> void:
	position.y = clamp(position.y, 64, 664)
	
	
