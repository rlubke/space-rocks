extends Area2D
class_name Bullet

const SPEED    := 200.0     # pixels / sec
var lifespan := 2.0  

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += cos(rotation - PI / 2) * delta * SPEED
	position.y += sin(rotation -  PI / 2) * delta * SPEED

	lifespan -= delta
	if lifespan < 0:
		queue_free()
