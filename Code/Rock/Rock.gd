extends Wrappable
class_name Rock

var speed     := 20
var direction := Vector2.ZERO
var velocity  := Vector2.ZERO

const Colors := preload("res://Colors/Colors.gd")

var main: Main;

var signals = preload("res://Signals/Signals.gd")

@onready
var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(on_area_entered)
	super._ready()
	direction = Vector2(randf_range(-1, 1), \
						randf_range(-1, 1))

	animated_sprite.frame = randi_range(0, animated_sprite.sprite_frames.get_frame_count("default"))

	$AnimatedSprite2D.rotation_degrees = randi_range(0, 360)
	
	# animated_sprite.frame = [0...n]
	#
	# use this in order to have a dynamic upper bound
	# if more frames added.
	animated_sprite.sprite_frames.get_frame_count("default")

	animated_sprite.modulate = Color.html(Colors.COLORS[randi_range(0, 7)])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = direction * speed * delta
	position += velocity

	super._process(delta);

func on_area_entered(collided_with: Area2D):
	if collided_with is Bullet:
		if collided_with.player != null:
			print("HERE")
			Signals.score_event.emit(10)

		collided_with.queue_free()
		queue_free()
