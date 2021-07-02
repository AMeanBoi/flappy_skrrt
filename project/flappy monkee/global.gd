extends Node

var max_score = 0
var first_play = true
var total_points=0
var inventory=[]
var models_unlocked=['default']
var active_model='default'
var disco_unlocked=false
var disco
var night=false
var models_done=[]
var muted=false
func _ready():
	var music=AudioStreamPlayer.new()
	music.stream=load('res://flappy monkee/sounds/music.mp3')
	music.autoplay=true
	add_child(music)
	pause_mode=Node.PAUSE_MODE_PROCESS
func add_points(pts:int):
		total_points+=pts
		get_tree().root.get_node('main/UI/total_points').text='Total Points: %s' % total_points
		get_tree().root.get_node('main/UI/shop/buy').play()
func buy(model:String,price:int):
	if model in models_unlocked:
		get_tree().root.get_node('main/player').set_model(model)
		get_tree().root.get_node('main/UI/shop/stuff to buy/modifiers/dababy/status2').text=active_model
		
		#active_model=model
	elif total_points< price:
		pass
	elif total_points>=price:
		#active_model=model
		add_points(-price)
		models_unlocked.append(model)
		buy(model,0)
func buy_modifier(item:String,price:int):
	if item in inventory:
		match item:
			'night':
				night=not night
				if night:
					get_tree().root.get_node('main/UI/shop/stuff to buy/modifiers/night mode/status').text='ON'
				else:
					get_tree().root.get_node('main/UI/shop/stuff to buy/modifiers/night mode/status').text='OFF'
	elif price>total_points:
		pass
	else:
		add_points(-price)
		inventory.append(item)
		buy_modifier(item,0)
func toggle_sound():
	muted=not muted
	AudioServer.set_bus_mute(0,muted)	
