extends Area3D

var parent = get_parent()
@export var x = 400
@export var y = 300
@export var z = 200
@export var duration = 1500
@onready var hitbox = get_node("Jab_Collision")
var frames = 0.0

func set_parameters(length, height, width, dur, hit, f, pos, parent=get_parent()):
	self.position = Vector3(0, 0, 0)
	x = length
	y = height
	z = width
	duration = dur
	self.position = pos
	hitbox.shape.extents = Vector3(x, y, z)
	set_physics_process(true)

# Called when the node enters the scene tree for the first time.
func _ready():
	
	hitbox.shape = BoxShape3D.new()
	set_physics_process(false)
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if frames < duration:
		frames += 1
	elif frames == duration:
		Engine.time_scale = 1
		queue_free()
		return
		
		
	
	
	
