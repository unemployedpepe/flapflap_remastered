extends RigidBody2D
signal died
var playing = false 
@export var flap_force = -520
@onready var hit = $Hit
@onready var flap_sound = $flap

const MAX_ROTATION = -10
var is_playing = true

func _physics_process(delta):
	if Input.is_action_just_pressed("flap") and is_playing:
		start()
		flap(delta)
	else:
		$AnimationPlayer.play("idle")
	
	if rotation_degrees <= MAX_ROTATION:
		angular_velocity = 0
		rotation_degrees = MAX_ROTATION
	if linear_velocity.y > 0 :
		if rotation_degrees <= 90:
			angular_velocity = 40  * delta
		else:
			angular_velocity = 0
	
func start():
	if playing : return 
	playing = true
	gravity_scale = 2
	
	
func flap(delta):
	linear_velocity.y = flap_force
	angular_velocity = -40 * delta
	flap_sound.play()

func die():
	if !is_playing: return # adding this prevents 2nd sound in death 
	is_playing = false
	$AnimationPlayer.stop()
	died.emit()
	hit.play()
	print("dead")
