extends Area2D


var velocidade_bola : int = 700
var posição_inicial : Vector2 = Vector2(640, 360)
var direção_inicial : Vector2 = Vector2(0, 0)
var nova_direção : Vector2 = Vector2(0, 0)
var y_minimo : float = 0
var y_maximo : float = 720
@onready var timer : Timer = $Timer
@onready var som_barreira : AudioStreamPlayer = $SomImpactobarreira
@onready var som_player : AudioStreamPlayer = $SomPlayer



func _ready() -> void:
	rodar_timer()


func _process(delta: float) -> void:
	movimentar_bola(delta)
	colidir_com_as_paredes()


func rodar_timer() -> void:
	timer.start()


func resetar_posição() -> void:
	position = posição_inicial
	escolher_posição_inicial()


func escolher_posição_inicial() -> void:
	var x_aleatorio = [-1, 1].pick_random()
	var y_aleatorio = [-1, 1].pick_random()
	
	direção_inicial = Vector2(x_aleatorio, y_aleatorio)
	nova_direção = direção_inicial


func movimentar_bola(delta : float) -> void:
	position += nova_direção * velocidade_bola * delta
	
	
func colidir_com_as_paredes() -> void:
	if position.y >= y_maximo or position.y <= y_minimo:
		nova_direção.y *= -1
		
		if position.x >= 0 and position.x <= 1280:
			som_barreira.play()


func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.is_in_group("jogadores"):
		nova_direção.x *= -1
		som_player.play()


func _on_timer_timeout() -> void:
	resetar_posição()
