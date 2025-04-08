extends Node3D
func _process(delta: float) -> void:
	if Input.is_action_pressed("quit"):
		get_tree().quit()
	if Input.is_action_pressed("pause"):
		if get_tree().paused==false:
			set_process_input(true)
			set_process_unhandled_input(true)
			get_tree().paused=true
		elif get_tree().paused==true:
			set_process_input(true)
			set_process_unhandled_input(true)
			get_tree().paused=false
