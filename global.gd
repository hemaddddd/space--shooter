extends Node

var VP = Vector2.ZERO
var score = 0
var lives = 0
var tine = 0

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	randomize()
	VP = get_viewport().size
	var _signal = get_tree().get_root().size_changed.connect(_resize)
	reset()

func _process(_delta):
	if Input.is_action_just_pressed("Quit"):
		var menu = get_node_or_null("/root/Game/UI/Menu")
		if menu == null:
			get_tree().quit()
		else:
			if menu.visible:
				get_tree().paused = false
				menu.hide()
			else:
				get_tree().paused = true
				menu.show()
	var Astroid_Container = get_node_or_null("/root/Game/Astroid_Container")
	var Enemy_Container = get_node_or_null("/root/Game/Enemy_Container")
	if Astroid_Container.get_child_count() == 0 and Enemy_Container.get_child_Count() == 0:
		get_tree().change_scene_to_file("res://UI/end_game.tscn")

func update_lives(l):
	lives += l
	var hud = get_node_or_null("/root/Game/UI/HUD")
	if hud != null:
		hud.update_lives()
	if lives < 0:
		get_tree().change_scene_to_file("res://UI/end_game.tscn")
	
func update_score(s):
	score += s
	var hud = get_node_or_null("/root/Game/UI/HUD")
	if hud != null:
		hud.update_score()
	
func update_tine(t):
	tine += t

func _resize():
	VP = get_viewport().size
	var hud = get_node_or_null("/root/Game/UI/HUD")
	if hud != null:
		hud.update_lives()

func reset():
	get_tree().paused = false
	score = 0
	tine = 38
	lives = 5
	
