class_name State_Attack extends State


var attackin : bool = false
@onready var walk : State = $"../walk"
@onready var idle : State = $"../idle"
@onready var animation_player : AnimationPlayer = $"../../AnimationPlayer"
@onready var attack_anim : AnimationPlayer = $"../../Sprite2D/AttackEffect/AnimationPlayer"
@onready var audio : AudioStreamPlayer2D = $"../../AudioStreamPlayer2D"
@export var attack_sound : AudioStream
@export_range(1, 20, 0.5) var decelerate_speed : float = 5


func _ready() -> void:
	animation_player.animation_finished.connect( EndAttack )


func Enter() -> void:
	player.UpdateAnimation('attack')
	attack_anim.play("attack_" + player.AnimDirection())
	
	audio.stream = attack_sound
	audio.pitch_scale = randf_range(0.9, 1.1)
	audio.play()
	attackin = true
	

func Exit() -> void:
	attackin = false


func Process(_delta: float) -> State:
	player.velocity -= player.velocity * decelerate_speed * _delta
	if attackin == false:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return walk
	
	return null
	
	
func Physics(_delta: float) -> State:
	return null
	
	
func HandleInput(_event: InputEvent) -> State:
	return null


func EndAttack( _newAnimName : String ) -> void:
	attackin = false
