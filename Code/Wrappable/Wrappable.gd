extends Area2D
class_name Wrappable

# safe to store as view-port re-sizing not implemented.
var vx
var vy

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	vx = get_viewport().size.x
	vy = get_viewport().size.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if position.x < 0:
		position.x = vx
	if position.y < 0:
		position.y = vy
	if position.x > vx:
		position.x = 0;
	if position.y > vy:
		position.y = 0;
