extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 10

#Variables for animation 
@onready var model = $Rig
@onready var animtree = $AnimationTree
@onready var animstate = $AnimationTree.get("parameters/playback")

#Hitbox var
@export var hitbox: PackedScene

#Flags for falling
var falling = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

#Function for handling for jump and landing animations
func handle_jump_and_land():
	
	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animstate.travel("Jump")
		animtree.set("parameters/conditions/JumpLand", false)
	
	if not is_on_floor():
		falling = true
	
	if falling and is_on_floor():
		animtree.set("parameters/conditions/JumpLand", true)
		falling = false
		
	
#Function for handling jab
func jab():
	if Input.is_action_just_pressed("Jab") and is_on_floor():
		animstate.travel("Jab")
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	handle_jump_and_land()
	
	jab()
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("WalkLeft", "WalkRight", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func _on_jab_hitbox_body_entered(body):
	pass # Replace with function body.
