extends Node2D

const game_overUI_scene : PackedScene = preload ("res://UI/game_over_ui.tscn")

@onready var hud = $HUD
@onready var obstacle_spawner = $ObstacleSpawner
@onready var obstacle: Obstacle
@onready var ground = $Ground

var game_overUI : GameOver

var score: int:
	get: 
		return score
	set(value):
		score= value
		hud.update_score(value)
	


func _ready(): 
	obstacle_spawner.connect("obstacle_created", _on_obstacle_created)
	DisplayServer.screen_set_orientation(DisplayServer.SCREEN_PORTRAIT)

func player_score():
	score += 1  
	print("score from playerscore")
	
func new_game():
	score = 0
	obstacle_spawner.start()
	
func game_over():
	obstacle_spawner.stop()
	ground.get_node("AnimationPlayer").stop()
	get_tree().call_group("obstacles", "set_physics_process", false)
	if not game_overUI:
		game_overUI = game_overUI_scene.instantiate()
		add_child(game_overUI)
		game_overUI.set_score(score)
	
	
	
func _on_obstacle_created(obs):
	obs.connect("score_obstacle", player_score)



func _on_death_zone_body_entered(body):
	if body == $Player: 
		if body.has_method("die"):
			body.die()


func _on_player_died():
	game_over()


func _on_menu_layer_start_game():
	new_game()
	
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
