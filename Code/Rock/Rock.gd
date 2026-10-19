extends Wrappable
class_name Rock

var speed     := 100
var direction := Vector2.ZERO
var velocity  := Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(on_area_entered)
	super._ready()
	direction = Vector2(randf_range(-1, 1), \
						randf_range(-1, 1))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = direction * speed * delta
	position += velocity

	super._process(delta);

func on_area_entered(collided_with: Area2D):
	if collided_with is Bullet:
		collided_with.queue_free()
		queue_free()