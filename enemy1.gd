extends Node2D




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var speed = 300.0
	$PathFollow2D.progress += speed * delta
	
