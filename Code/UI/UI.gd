extends PanelContainer
class_name UI

@onready
var score_ui := $VBox/ScoreUI

@onready
var lives_ui := $VBox/LivesUI

@onready
var LIFE := preload("res://UI/assets/life.tscn")

@onready
var SHIP := preload("res://Ship/Ship.tscn")

var score := 0
var lives := 0

func update_score(delta: int):
	print(delta)
	score += delta
	score_ui.text = str(score);


func spawn_ship():
	var ship = SHIP.instantiate()
	ship.player = self
	add_child(ship)


func update_lives(delta: int):
	clear_lives()
	build_lives(delta)
	lives += delta
	
	
func clear_lives():
	lives_ui.get_children().map(func(child) : child.queue_free())


func build_lives(count: int):
	for i in range(0, count):
		var life = LIFE.instantiate()
		lives_ui.add_child(life);


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !Signals.score_event.is_connected(update_score):
		Signals.score_event.connect(update_score)
	if !Signals.destroyed.connect(on_destroyed):
		Signals.destroyed.connect(on_destroyed)
	update_score(0)
	update_lives(3)


func on_destroyed(destroyed: Object, destroyedBy: Object) -> void:
	if destroyed is Ship:
		update_lives(lives_ui.get_child_count() - 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
