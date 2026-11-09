extends Node

# Emitted when a scoring event has occurred.
signal score_event(delta: int, ui: UI)

# Emitted when an object is destroyed.
signal destroyed(destroyed: Object, destroyedBy: Object)

# Emitted when a new game begins.
signal new_game()

# Emitted when a new round begins.
signal new_round()

# Emitted when the game is over.
signal game_over()

# emitted when a new ship needs to be put into play.
signal new_ship();

# emitted when the player earns a one-up
signal one_up()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
