extends PanelContainer
class_name PauseMenu

@onready
var play_button := $VBox/PlayButton

@onready
var quit_button := $VBox/QuitButton

@onready
var cont_button := $VBox/ContinueButton

var main

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_button.pressed.connect(on_play_pressed)
	cont_button.pressed.connect(on_continue_pressed)
	quit_button.pressed.connect(on_quit)
	
	main = get_parent();
	show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# hook pause up here
	var tree = get_tree();
	if Input.is_action_just_pressed("pause"):
		tree.paused = true
		show();

func on_continue_pressed() -> void:
	get_tree().paused = false;
	hide()

func on_play_pressed() -> void:
	get_tree().paused = false;
	play_button.visible = false
	hide()
	Signals.new_game.emit()


func on_quit() -> void:
	print("quit")
	get_tree().quit();
