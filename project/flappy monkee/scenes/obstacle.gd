extends StaticBody
export var speed = 4.0
export (Color) var color
var velocity=Vector3.ZERO
var _is_passed = false
signal passed
func _ready():
	velocity=Vector3.LEFT * speed
	
	for node in $CSGCombiner.get_children():
		node.material=SpatialMaterial.new()
		node.material.albedo_color=color
func _physics_process(delta):
	translation+=velocity*delta



func _on_Area_body_entered(body):
	if body.name=='player' and !_is_passed:
		emit_signal("passed")
		_is_passed=true
