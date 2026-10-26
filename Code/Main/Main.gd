extends Node
class_name Main

const PAUSE := "pause"

const _UFO  := preload("res://UFO/UFO.tscn")
const _ROCK := preload("res://Rock/Rock.tscn")
const _UI   := preload("res://UI/UI.tscn")
const _SHIP   := preload("res://Ship/Ship.tscn")

var players: Array[UI]

@onready
var timer := $UfoTimer

func just_score(delta):
	players[0].update_score(delta)

func on_ufo_spawn():
	var ufo := _UFO.instantiate()
	ufo.position.x = 0.0 if randi() % 2 else get_viewport().size.x
	ufo.position.y = randf_range(0, get_viewport().size.x)
	add_child(ufo)
	
func spawn_player():
	var player =_UI.instantiate()
	players.append(player)
	add_child(player)
	
func spawn_rocks(count: int):
	var screenX: float = get_viewport().size.x
	var screenY: float = get_viewport().size.y
	var halfx: float = screenX / 2
	var halfy: float = screenY / 2

	var quad = 0
	for i in count:
		var rock = _ROCK.instantiate()
		rock.main = self

		if quad == 0:
			rock.position.x = randf_range(halfx + 64, screenX - 30)
			rock.position.y = randf_range(halfy + 64, screenY - 30)
		elif quad == 1:
			rock.position.x = randf_range(halfx - 64, screenX - 30)
			rock.position.y = randf_range(halfy + 64, screenY - 30)
		elif quad == 2:
			rock.position.x = randf_range(halfx - 64, screenX - 30)
			rock.position.y = randf_range(halfy - 64, screenY + 30)
		else:
			rock.position.x = randf_range(halfx + 64, screenX - 30)
			rock.position.y = randf_range(halfy - 64, screenY + 30)

		quad += 1;
		if (quad > 3):
			quad = 0

		add_child(rock)

func _ready() -> void:
	timer.timeout.connect(on_ufo_spawn)	
	spawn_player()
	spawn_rocks(11)
	

func _process(delta: float) -> void:
	if Input.is_action_pressed(PAUSE):
		get_tree().quit()
