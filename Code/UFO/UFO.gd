extends Area2D
class_name UFO

var speed := 10.0 # px / sec
var velocity_y := 0.0

@onready
var timer := $Timer

@onready
var f_timer := $FireTimer

const BULLET := preload("res://Bullet/Bullet.tscn")

func on_timeout() -> void:
	if velocity_y != 0:
		velocity_y = 0
	else:
		var rando := randi_range(0, 1)
		if rando:
			velocity_y = -speed
		else:
			velocity_y = speed;
			
func on_fired() -> void:
	var bullet := BULLET.instantiate()
	bullet.position = position
	bullet.rotation_degrees = randf_range(0, 360)
	get_parent().add_child(bullet)
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.timeout.connect(on_timeout)
	f_timer.timeout.connect(on_fired)
	
	var viewport_size = get_viewport().size;
	if position.x > viewport_size.x - viewport_size.x / 2:
		speed *= -1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += speed * delta
	position.y += velocity_y * delta

	var height = get_viewport().size.y
	if position.y < 0:
		position.y = height
	elif position.y > height:
		position.y = 0;

	position.x += speed * delta
	position.y += velocity_y * delta
	
