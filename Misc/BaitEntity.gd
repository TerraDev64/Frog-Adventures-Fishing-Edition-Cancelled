extends RigidBody2D


onready var player = get_tree().get_nodes_in_group("player")[0]
onready var aP = $AnimationPlayer

#var frogSprite = player.get_node("Player/FrogSprite")

var motion = Vector2()
var speed = 15
var jump_force = 80
#var player = is_in_group("player")


enum {
	IDLE,
	MOVING,
	BAITED,
	CATCHING
}

var state = IDLE

func _physics_process(delta):
	match state:
		IDLE:
			sleeping = true
		MOVING:
			#$Camera2D.current = true
			sleeping = false
			move(delta)
			#motion.y += gravity
		BAITED:
			baited()
		CATCHING:
			catching()
		

	#motion = move_and_slide(motion)

func move(delta):
	if Input.is_action_just_pressed("a_button"):
		#check if x coords is smaller than the frog x coords and otherwise
		print("player pos: ", player.position.x, " Bait Pos: ", global_position.x)
		if global_position.x > player.position.x - 1:
			apply_impulse(Vector2(0,0), Vector2(-speed, 0))
			$Sprite.flip_h = true
		if global_position.x < player.position.x + 1:
			apply_impulse(Vector2(0,0), Vector2(speed, 0))
			$Sprite.flip_h = false
		apply_central_impulse(Vector2.UP * jump_force)

	#sets sprite to y velocity
	if get_linear_velocity().y < 0.1:
		$Sprite.frame = 0
	elif get_linear_velocity().y > 0.1:
		$Sprite.frame = 1
	elif get_linear_velocity().y == 0:
		$Sprite.frame = 1




func baited():
	pass

func catching():
	pass



func _ready():
	pass


func activate_bait():
	$CollisionShape2D.disabled = false
	state = MOVING

