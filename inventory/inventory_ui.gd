extends Control
var is_open=false
@onready var progress_bar: ProgressBar = $"../hud/ProgressBar"
func _ready() -> void:
	close()
func close():
	visible=false
	is_open=false
	progress_bar.visible=true
func open():
	visible=true
	is_open=true
	progress_bar.visible=false
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("open"):
		if is_open:
			close()
		else:
			open()
