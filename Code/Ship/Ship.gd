extends Wrappable
class_name Ship

const TURN_SPEED := 180  # degrees / sec
const BULLET := preload("res://Bullet/Bullet.tscn")
const FIRE := "fire";
const RLEFT := "rotate-left"
const RRIGHT := "rotate-right"
const PAUSE := "pause"
const THRUST := "thrust"

var thrust_factor := 10
var velocity := Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()

func fire() -> void:
	print("PEW! PEW!")
	var bullet := BULLET.instantiate()
	bullet.position = position
	bullet.rotation = rotation
	get_parent().add_child(bullet)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed(FIRE):
		fire();
	if Input.is_action_pressed(RLEFT):
		rotation_degrees -= TURN_SPEED * delta
	if Input.is_action_pressed(RRIGHT):
		rotation_degrees += TURN_SPEED * delta
	if Input.is_action_pressed(PAUSE):
		get_tree().paused = !get_tree().paused	
	if Input.is_action_pressed(THRUST):
		print("Whhhooooosssh")
		velocity.x += cos(rotation - PI / 2) * thrust_factor
		velocity.y += sin(rotation - PI / 2) * thrust_factor

	position += velocity

	super._process(delta);
