class_name Obstacle
extends Node2D
signal score_obstacle
const SPEED = -200 
@onready var score_points = $ScorePoints

func _physics_process(delta):
	position.x += SPEED * delta 

		
	
	
	
func _on_walls_body_entered(body):
	if body.has_method("die"):
		body.die()


func _on_score_area_body_exited(_body):
	print("score from obstacle")
	score_points.play()
	score_obstacle.emit()
