extends Area3D
@export var num =.2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#pass
	if position.z <=-20.5:
		num =.2
	if position.z >= 40.5:
		num =-.2
	#print(material.alpha_hash_scale)
	position.z +=num
