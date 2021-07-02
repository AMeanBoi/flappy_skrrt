extends ColorRect

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and visible:
		visible=false
		get_tree().reload_current_scene()

	elif event.is_action_released("ui_accept") and get_parent().get_node("start").visible:
		get_tree().paused=false
		get_parent().get_node("start").visible=false
func _ready():
	if Global.disco:
		get_tree().root.get_node('main/UI/shop/stuff to buy/modifiers/disco/status2').text='ON'
	else:
		get_tree().root.get_node('main/UI/shop/stuff to buy/modifiers/disco/status2').text='OFF'
	get_parent().get_node("max_score").text= 'Personal Best: %s' % Global.max_score
	get_parent().get_node("total_points").text='Total Points: %s' % Global.total_points
	get_tree().root.get_node('main/UI/shop/stuff to buy/modifiers/dababy/status2').text=Global.active_model
	get_parent().pause_mode=Node.PAUSE_MODE_PROCESS



func _on_Button_pressed():
	visible=false
	get_parent().get_node("shop").visible=true
	get_parent().get_node("click").play()
	#print('pressed')


func _on_leave_pressed():
	get_parent().get_node("shop").visible=false
	visible=true
	get_parent().get_node("click").play()


func _on_cybertruck_pressed():
	Global.buy('cybertruck',150)
	get_parent().get_node("click").play()


func _on_default_pressed():
	Global.buy('default',0)
	get_parent().get_node("click").play()


func _on_dababy_pressed():
	if 'dababy' in Global.models_unlocked:
		Global.buy('dababy',0)
	get_parent().get_node("click").play()


func _on_night_mode_pressed():
	Global.buy_modifier('night',200)
	get_parent().get_node("click").play()


func _on_disco_pressed():
	if Global.disco_unlocked:
		Global.disco=not Global.disco
		if Global.disco:
					get_tree().root.get_node('main/UI/shop/stuff to buy/modifiers/disco/status2').text='ON'
		else:
					get_tree().root.get_node('main/UI/shop/stuff to buy/modifiers/disco/status2').text='OFF'
	get_parent().get_node("click").play()


func _on_sound_pressed():
	Global.toggle_sound()
	if not Global.muted:
					get_tree().root.get_node('main/UI/shop/stuff to buy/models/sound/status3').text='ON'
	else:
					get_tree().root.get_node('main/UI/shop/stuff to buy/models/sound/status3').text='OFF'
	get_parent().get_node("click").play()
