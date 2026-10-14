extends Area2D
class_name Ship

const TURN_SPEED := 180  # degrees / sec
const BULLET := preload("res://Bullet/Bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func fire() -> void:
	print("PEW! PEW!")
	var bullet := BULLET.instantiate()
	bullet.position = position
	bullet.rotation = rotation
	get_parent().add_child(bullet)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("fire"):
		fire();
	if Input.is_action_pressed("rotate-left"):
		rotation_degrees -= TURN_SPEED * delta
	if Input.is_action_pressed("rotate-right"):
		rotation_degrees += TURN_SPEED * delta
	if Input.is_action_pressed("pause"):
		print("PAUSED? " + str(get_tree().paused))
		get_tree().paused = !get_tree().paused	
	if Input.is_action_just_pressed("thrust"):
		print("Whhhooooosssh")
