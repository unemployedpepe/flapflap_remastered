class_name GameOver
extends CanvasLayer

@onready var score_label = $VBoxContainer2/MarginContainer/GridContainer/ScoreLabel
@onready var restart_button = $VBoxContainer2/MarginContainer/GridContainer/RestartButton
@onready var high_score_label = %HighScoreLabel
var highscore: int = Globals.save_data.high_score

func _ready():
	high_score_label.text = "Best: " + str(highscore)

func _input(event) -> void:
	if event.is_action_pressed("flap"):
		_on_restart_button_pressed()


func set_score(n:int):
	score_label.text = "Score: " + str(n)
	if n > Globals.save_data.high_score: 
		Globals.save_data.high_score = n
		Globals.save_data.save()
	if n > highscore: 
		high_score_label.text = "Best: " + str(n)
func _on_restart_button_pressed():
	get_tree().reload_current_scene()
