extends SpotLight3D


var velocity_vector
var rotation_vector_x = Vector3(1, 0, 0)
var rotation_vector_z= Vector3(0, 0, 1)
var rotation_vector_y= Vector3(0, 1, 0)

var shake = 0.005
var rotation_speed = 0.007
var rotation_speedx = 0.004
var rotation_speedz = 0.002

func _ready():
	#rotation_speed*=-1
	$Timer.start()
	$Timer2.start()
	#if Input.is_action_just_pressed("move_forward"):
		#var rotation_speedx = 0.04
		#if rotation_speedx==.017||rotation_speedx==-.002:
			#shake*=-1
	#if Input.is_action_pressed("move_backward"):
		#rotation_speedx*=-1
	#if Input.is_action_pressed("move_left"):
		#rotation_speedx*=-1
	#if Input.is_action_pressed("move_right"):
		#rotation_speedx*=-1
	
func _on_timer_timeout():
	
	rotate(rotation_vector_y, -rotation_speed)
	rotation_speed*=-1

func _on_timer_2_timeout() -> void:
	rotate(rotation_vector_x, -rotation_speedx)
	rotation_speedx*=-1


func _on_timer_3_timeout() -> void:
	rotate(rotation_vector_z, -rotation_speedz)
	rotation_speedz*=-1
