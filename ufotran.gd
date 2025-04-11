extends MeshInstance3D
@export var bo =true
@export var num =.1
@export var material := get_surface_override_material(0)
func _ready() -> void:
	pass

func _process(delta):
	var material := get_surface_override_material(0)
	material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA_HASH
	if material.alpha_hash_scale <=.5:
		num =.1
	if material.alpha_hash_scale >= 1.5:
		num =-.1
	#print(material.alpha_hash_scale)
	material.alpha_hash_scale +=num
