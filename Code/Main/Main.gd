extends Node
class_name Main

const PAUSE := "pause"

const _UFO:= preload("res://UFO/UFO.tscn")

@onready
var timer := $UfoTimer

func on_ufo_spawn():
	var ufo := _UFO.instantiate()
	ufo.position.x = 0.0 if randi() % 2 else get_viewport().size.x
	ufo.position.y = randf_range(0, get_viewport().size.x)
	add_child(ufo)

func _ready() -> void:
	timer.timeout.connect(on_ufo_spawn)

func _process(delta: float) -> void:
	if Input.is_action_pressed(PAUSE):
		get_tree().quit()
