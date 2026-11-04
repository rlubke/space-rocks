extends Wrappable
class_name Ship

const _SHIP   := preload("res://Ship/Ship.tscn")

const BULLET     := preload("res://Bullet/Bullet.tscn")
const TURN_SPEED := 180  # degrees / sec
const FIRE       := "fire";
const RLEFT      := "rotate-left"
const RRIGHT     := "rotate-right"
const THRUST     := "thrust"

@onready
var animated_sprite := $AnimatedSprite2D;

var player: UI

var thrust_factor := 5
var velocity := Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !area_entered.is_connected(on_area_entered):
		area_entered.connect(on_area_entered)

	animated_sprite.modulate = Color.html(GameColors.PLAYER1)
	super._ready()


static func newInstance(screenX: float, screenY: float, ui: UI) -> Ship:
	var ship = _SHIP.instantiate()

	ship.position.x = screenX / 2
	ship.position.y = screenY / 2
	
	ship.player = ui

	return ship


func on_area_entered(collided_with: Area2D):
	if collided_with is Rock:
		Signals.destroyed.emit(self, collided_with)
		queue_free()


func on_destroyed(_destroyed: Object, _destroyedBy: Object):
	pass


func fire() -> void:
	var bullet := BULLET.instantiate()
	bullet.player = player
	bullet.position = position
	bullet.rotation = rotation
	get_parent().add_child(bullet)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed(FIRE):
		print("FIRE")
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
