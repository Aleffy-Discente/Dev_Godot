class_name Player extends CharacterBody2D


var direction : Vector2 = Vector2.ZERO
var cardinal_direction : Vector2 = Vector2.DOWN

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
@onready var state_machine : PlayerStateMachine = $StateMachine


func _ready() -> void:
	state_machine.Initialize(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	direction = Vector2(
		Input.get_axis("esquerda", "direita"),
		Input.get_axis("cima", "baixo")
	).normalized()
	
	
func _physics_process(delta: float) -> void:
	move_and_slide()
	
	
func SetDirection() -> bool:
	var new_dir : Vector2 = cardinal_direction
	if direction == Vector2.ZERO:
		return false 
	if direction.y == 0:
		new_dir = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	elif direction.x == 0:
		new_dir = Vector2.UP if direction.y < 0 else Vector2.DOWN
	
	if cardinal_direction == new_dir:
		return false
	
	cardinal_direction = new_dir
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true
	
	
#func setState(state : String) -> bool:
#	var new_state : String = "idle" if direction == Vector2.ZERO else "walk"
#	if new_state == state:
#		return false
#	state = new_state
#	return true

func AnimDirection() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"	
	else:
		return "side"


func UpdateAnimation(state : String) -> void:
	animation_player.play("{0}_{1}".format([state, AnimDirection()]))
	
