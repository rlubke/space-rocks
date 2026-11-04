extends Wrappable
class_name Bullet

const SPEED    := 250.0     # pixels / sec
var   lifespan := 1.2       # lifespan - 2 sec
var   player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	if !area_entered.is_connected(on_area_entered):
		area_entered.connect(on_area_entered)


func on_area_entered(collided_with: Area2D):
	if "player" in collided_with:
		return
		
	Signals.destroyed.emit(collided_with, self)
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += cos(rotation - PI / 2) * delta * SPEED
	position.y += sin(rotation -  PI / 2) * delta * SPEED
	
	super._process(delta);

	lifespan -= delta
	if lifespan < 0:
		queue_free()
