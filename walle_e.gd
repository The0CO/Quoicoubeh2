extends CharacterBody3D

@export var player_path: NodePath
@export var speed: float = 3.0
@export var gravity: float = 9.8
@export var follow_distance: float = 1.5
@export var jump_strength: float = 6.0
@export var jump_threshold: float = 1.5  # Hauteur à partir de laquelle il saute

var player



func _ready():
	player = get_node_or_null(player_path)

func _physics_process(delta):
	if not player:
		return

	var direction = player.global_transform.origin - global_transform.origin
	direction.y = 0
	var distance = direction.length()

	# Mouvement horizontal
	if distance > follow_distance:
		direction = direction.normalized()
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	# Rotation pour qu'il regarde le joueur
	look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)

	# Gestion du saut
	var vertical_diff = player.global_position.y - global_position.y
	if is_on_floor():
		if vertical_diff > jump_threshold:
			velocity.y = jump_strength
		else:
			velocity.y = 0
	else:
		velocity.y -= gravity * delta

	move_and_slide()
