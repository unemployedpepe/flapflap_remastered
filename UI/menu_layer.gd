class_name MenuLayer
extends CanvasLayer
@onready var start_message = $StartMenu/StartMessage

signal start_game 
var game_started = true 


func _input(event):
	if event.is_action_pressed("flap") and game_started:
		start_game.emit()
		
		var tween = create_tween()
		tween.tween_property(start_message, "modulate:a",0, 0.5 )
		game_started = false 
