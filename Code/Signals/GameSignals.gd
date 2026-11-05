extends Node

signal score_event(delta: int, ui: UI)
signal destroyed(destroyed: Object, destroyedBy: Object)
signal new_game()
signal new_round()
signal life_event(detla: int, ui: UI)
signal game_over()
signal new_ship()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
