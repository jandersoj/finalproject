extends MeshInstance3D
@export var bo =true
@export var num =.01
@export var material := get_surface_override_material(0)
func _ready() -> void:
	pass

func _process(delta):
	var material := get_surface_override_material(0)
	material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA_HASH
	if material.alpha_hash_scale <=1:
		num =.01
	if material.alpha_hash_scale >= 2:
		num =-.01
	#print(material.alpha_hash_scale)
	material.alpha_hash_scale +=num
