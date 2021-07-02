extends Spatial
var obstacle_scene=preload("res://flappy monkee/scenes/obstacle.tscn")
var difficulty=1.0
var score=0
var rgb_colors=['#91ff00','#00a5ff','#eb00ff','#ff0000','#ffb300']
var colors=['#7c1111','#26578a','#7e268a','#297a1b']
func _ready():
	randomize()
	if Global.night:
		get_tree().root.get_node('main/UI/shop/stuff to buy/modifiers/night mode/status').text='ON'
		for light in get_tree().root.get_node('main/lights').get_children():
			light.visible=not light.visible
	get_tree().paused=false
	if Global.disco:
		$lights.play("disco")
	if Global.first_play:
		$UI/start.visible=true
		get_tree().paused=true
		Global.first_play=false
	spawn_obstacle()
func spawn_obstacle():
	var obstacle=obstacle_scene.instance()
	difficulty+=0.1
#	if Global.disco:
#		$lights.playback_speed
	#print(difficulty)
	obstacle.speed=difficulty*obstacle.speed
	colors.shuffle()
	obstacle.color=Color(colors.front())
	#print(obstacle.speed)
	obstacle.translation=Vector3(9,0,3)
	obstacle.translation.y+=rand_range(-3.5,2)
	obstacle.get_node("light").visible=Global.night
	rgb_colors.shuffle()
	for light in obstacle.get_node('light').get_children():
		light.light_color=Color(rgb_colors.front())
	$obstacle_spawner.wait_time=2.0/difficulty
	obstacle.connect("passed",self,'scored')
	$obstacles.add_child(obstacle)
func _on_Timer_timeout():
	spawn_obstacle()
func ded():
	$UI/ded.visible=true
	get_tree().paused=true
	pass
	
func scored():
	score+=1
	$player/score.play()
	$UI/score.text='Score: %s' % score


func _on_player_ded():
	Global.max_score=max(score,Global.max_score)
	$UI/max_score.text='Personal Best: %s' % Global.max_score
	Global.total_points+=score
	$UI/total_points.text='Total Points: %s' % Global.total_points
	if score>24 and Global.active_model=='default':
		Global.models_unlocked.append('dababy')
	if score>19 and not (Global.active_model in Global.models_done):
		Global.models_done.append(Global.active_model)
		if Global.models_done.size()==3:
			Global.disco_unlocked=true
	print('ded')
	ded()
