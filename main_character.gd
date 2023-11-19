extends CharacterBody2D


var speed = 300.0
var dashspeed = 800
const dashlength = .2
var normalspeed = 300

@onready var dash = $Dash

@onready var sprite_2d = $Sprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_count = 0
var extrajumps = 100
const jump = -400.0

func _physics_process(delta):
	#Animations
	if (velocity.x > 1 || velocity.x < -1):
		sprite_2d.animation = "bat"
	else:
		sprite_2d.animation = "bat"
	
	if Input.is_action_just_pressed("dash"):
		dash.start_dash(dashlength)
	var speed = dashspeed if dash.is_dashing() else normalspeed
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		sprite_2d.animation = "bat_flying"


	if Input.is_action_just_pressed("ui_accept") && jump_count < extrajumps:
		velocity.y = jump
		jump_count += 1
		
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump
		jump_count = 0

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)


	move_and_slide()
	
	var isLeft = velocity.x < 0
	sprite_2d.flip_h = isLeft


func _on_area_2d_body_entered(body):
	if body.get_name() == 'player':
		body.respawn()
		
		
func respawn():
	position.x = 421
	position.y = 389
