extends Wrappable
class_name Ship

const BULLET     := preload("res://Bullet/Bullet.tscn")
const TURN_SPEED := 180  # degrees / sec
const FIRE       := "fire";
const RLEFT      := "rotate-left"
const RRIGHT     := "rotate-right"
const THRUST     := "thrust"

var thrust_factor := 5
var velocity := Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()

func fire() -> void:
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
	if Input.is_action_pressed(THRUST):
		velocity.x += cos(rotation - PI / 2) * thrust_factor
		velocity.y += sin(rotation - PI / 2) * thrust_factor

	#TODO fix max velocity
	# var clamp_value: float = 1000
	# velocity = velocity.clamp(Vector2(-clamp_value, clamp_value), \
	# 					Vector2(-clamp_value, clamp_value))
	position += velocity * delta

	super._process(delta);
