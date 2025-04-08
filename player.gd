extends CharacterBody3D

@export var speed: float = 20.0  # Movement speed
@export var sensitivity: float = 0.002  # Mouse look sensitivity
@export var jump_velocity: float = 18.0  # Jump force
@export var gravity: float = 40.0  # Gravity strength
@onready var progress_bar: ProgressBar = $"hud/ProgressBar"
var health=100.0
#var current_room: String= "res://room_1.tscn"
var direction = Vector3.ZERO
var mouse_input = Vector2.ZERO
#@export var couchscript = preload("res://couch.gd")
@onready var camera = $Camera3D  # Reference to Camera3D
#var script1=couchscript.new()

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)  # Lock mouse
	add_to_group("player")
	progress_bar.value=health

func _process(delta):
	handle_movement(delta)
	#if $AudioStreamPlayer.playing==false:
	#	$AudioStreamPlayer.play()
	if Input.is_action_pressed("quit"):
		get_tree().quit()
	#if Input.is_action_pressed("pause"):
		#if get_tree().paused==false:
		#	set_process_input(true)
		#	set_process_unhandled_input(true)
		#	get_tree().paused=true
		#elif get_tree().paused==true:
			#set_process_input(true)
			#set_process_unhandled_input(true)
			#get_tree().paused=false

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		mouse_input = event.relative * sensitivity
		rotate_y(-mouse_input.x)  # Rotate left/right
		camera.rotate_x(-mouse_input.y)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-89), deg_to_rad(89))  # Prevent flipping

func handle_movement(delta):
	direction = Vector3.ZERO
# Apply gravity
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Jumping
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
		
	if Input.is_action_pressed("move_up"):
		direction -= transform.basis.z  # Move forward
	if Input.is_action_pressed("move_down"):
		direction += transform.basis.z  # Move backward
	if Input.is_action_pressed("move_left"):
		direction -= transform.basis.x  # Move left
	if Input.is_action_pressed("move_right"):
		direction += transform.basis.x  # Move right

	direction = direction.normalized() * speed
	velocity.x = direction.x
	velocity.z = direction.z
	move_and_slide()

func _physics_process(delta: float) -> void:
	
	var overlapping_mobs=%Hitbox.get_overlapping_bodies()
	while overlapping_mobs.size()>0 && $DamageTimer.is_stopped():
		for body in overlapping_mobs:
			if body.is_in_group("enemy"):
				#health-=script1.damage() * overlapping_mobs.size() 
				progress_bar.value=health
				$DamageTimer.start()
				move_and_collide(direction)
				#print("got here")
		#print(overlapping_mobs)
		#print(health)
		if health<=0:
			#queue_free()
			#if $resettimer.is_stopped():
			#	$resettimer.start()
			#if $resettimer.is_stopped():
			#get_tree().change_scene_to_file(Counter.current_room)
			pass
				
