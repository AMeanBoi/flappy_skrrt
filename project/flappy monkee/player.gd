extends KinematicBody
export (float) var jump_strength=5
export (float) var gravity_amount=5
signal ded
var models=['default','dababy','cybertruck']
var collision
var velocity=Vector3.ZERO
func _ready():
	set_model(Global.active_model)
	pass
func set_model(model:String):
	Global.active_model=model
	for skin in $models.get_children():
		if skin.name==model:
			skin.visible=true
		else:
			skin.visible=false
	for hitbox in get_children():
		if hitbox is CollisionShape:
			if hitbox.name==model:
				hitbox.disabled=false
			else:
				hitbox.disabled=true
func _physics_process(delta):
	velocity.y-=gravity_amount*delta
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y=jump_strength
		$jump.play()
		#print('up')
	draw_vel()
	if get_slide_count()!=0:
		#print("coll")
		$ded.play()
		emit_signal("ded")
	velocity=move_and_slide(velocity)


func draw_vel():
	match Global.active_model:
		'default':
			rotation.z=-(Vector2(velocity.x,velocity.y)+Vector2(1,0)).angle_to(Vector2.RIGHT)*0.5
		'cybertruck':
			rotation.z=-(Vector2(velocity.x,velocity.y)+Vector2(1,0)).angle_to(Vector2.RIGHT)*0.25
			

