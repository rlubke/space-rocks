extends Wrappable
class_name Rock

const _ROCK := preload("res://Rock/Rock.tscn")

var speed     := 20
var direction := Vector2.ZERO
var velocity  := Vector2.ZERO
var type      := RockType.LARGE

enum RockType {
	LARGE,
	MEDIUM,
	SMALL
}

@onready
var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

static func newInstance(screenX: float, \
		screenY: float, rockType: RockType = RockType.LARGE) -> Rock:
	var rock := _ROCK.instantiate()
	
	rock.type = rockType

	var halfX:   float = screenX / 2
	var halfY:   float = screenY / 2

	var quad := randi_range(0, 3);
	if quad == 0:
		rock.position.x = randf_range(halfX + 64, screenX - 30)
		rock.position.y = randf_range(30, halfY - 64)
	elif quad == 1:
		rock.position.x = randf_range(30, halfX - 64)
		rock.position.y = randf_range(30, halfY - 64)
	elif quad == 2:
		rock.position.x = randf_range(30, halfX - 64)
		rock.position.y = randf_range(halfY - 64, screenY + 30)
	else:
		rock.position.x = randf_range(halfX + 64, screenX - 30)
		rock.position.y = randf_range(halfY - 64, screenY + 30)
		
	return rock


static func newInstancePos(pos: Vector2, rockType: RockType):
	var rock := _ROCK.instantiate()

	rock.type     = rockType
	rock.position = pos;
	
	if rock.type == RockType.MEDIUM:
		rock.scale *= .7
		rock.speed = 60
	elif rock.type == RockType.SMALL:
		rock.scale *= .4
		rock.speed = 120
	
	return rock;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !Signals.destroyed.is_connected(on_destroyed):
		Signals.destroyed.connect(on_destroyed)
	if !Signals.new_game.is_connected(on_new_game):
		Signals.new_game.connect(on_new_game)

	super._ready()

	direction = Vector2(randf_range(-1, 1), \
						randf_range(-1, 1))

	animated_sprite.frame = randi_range(0, animated_sprite.sprite_frames.get_frame_count("default"))

	$AnimatedSprite2D.rotation_degrees = randi_range(0, 360)
	
	# animated_sprite.frame = [0...n]
	#
	# use this in order to have a dynamic upper bound
	# if more frames added.
	animated_sprite.sprite_frames.get_frame_count("default")

	animated_sprite.modulate = Color.html(GameColors.COLORS[randi_range(0, 7)])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = direction * speed * delta
	position += velocity

	super._process(delta);
	

func on_new_game():
	get_tree().call_group("rocks", "queue_free")


func on_destroyed(destroyed: Object, destroyedBy: Object):
	if destroyed == self && destroyedBy is Bullet:
		var rock := destroyed as Rock
		var bullet := destroyedBy as Bullet

		## LARGE rock
		if rock.type == RockType.LARGE:
			if bullet.player != null:
				Signals.score_event.emit(10)
			for i in range(0, randi_range(2, 3)):
				get_parent().add_child.call_deferred(Rock.newInstancePos( \
						rock.position, RockType.MEDIUM))

		## MEDIUM rock
		elif rock.type == RockType.MEDIUM:
			if bullet.player != null:
				Signals.score_event.emit(20)
			for i in range(0, randi_range(2, 3)):
				get_parent().add_child.call_deferred(Rock.newInstancePos( \
						rock.position, RockType.SMALL))

		## SMALL rock
		else:
			if bullet.player != null:
				Signals.score_event.emit(30)

		rock.queue_free.call_deferred()

	if destroyedBy == self && (destroyed is Ship or destroyed is UFO):
		var rock := destroyedBy as Rock

		if rock.type == RockType.LARGE:
			for i in range(0, randi_range(2, 3)):
				get_parent().add_child.call_deferred(Rock.newInstancePos( \
						rock.position, RockType.MEDIUM))

		elif rock.type == RockType.MEDIUM:
			for i in range(0, randi_range(2, 3)):
				get_parent().add_child.call_deferred(Rock.newInstancePos( \
						rock.position, RockType.SMALL))

		rock.queue_free.call_deferred()
		
func _enter_tree() -> void:
	add_to_group("rocks")
	
func _exit_tree() -> void:
	remove_from_group("rocks")
	var rocks = get_tree().get_nodes_in_group("rocks")

	if rocks.is_empty():
		print("No more rocks, emitting new round event")
		Signals.new_round.emit();
	
