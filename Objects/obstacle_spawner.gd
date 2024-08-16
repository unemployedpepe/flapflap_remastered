extends Node2D
@export var obstacle : PackedScene
signal obstacle_created
@onready var timer = $Timer


func _ready():
	randomize()
	#start()


func _on_timer_timeout():
	spawn_obstacle()
	


func spawn_obstacle():
	var o = obstacle.instantiate()
	add_child(o)
	o.position.y = randi() % 355 + 185
	obstacle_created.emit(o)

func start():
	timer.start()
	
func stop():
	timer.stop()
