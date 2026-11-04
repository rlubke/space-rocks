extends Node
class_name Main

const PAUSE := "pause"

const _UFO  := preload("res://UFO/UFO.tscn")
const _ROCK := preload("res://Rock/Rock.tscn")
const _UI   := preload("res://UI/UI.tscn")
const _SHIP := preload("res://Ship/Ship.tscn")

var players: Array[UI]

var starting_rock_count := 6

@onready
var timer := $UfoTimer

func just_score(delta, _player):
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
	return player


func spawn_rocks(count: int):
	var screenX = get_viewport().size.x
	var screenY = get_viewport().size.y

	for i in count:
		add_child(Rock.newInstance(screenX, screenY))


func _ready() -> void:
	timer.timeout.connect(on_ufo_spawn)
	Signals.new_game.connect(on_new_game)


func on_new_game() -> void:
	var screenX: float = get_viewport().size.x
	var screenY: float = get_viewport().size.y
	
	var player: UI = spawn_player()
	var ship      := Ship.newInstance(screenX, screenY, player)
	add_child(ship)
	spawn_rocks(6)


func _process(_delta: float) -> void:
	pass


func start_new_round():
	pass
