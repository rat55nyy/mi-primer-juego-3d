extends CharacterBody3D
signal squashed

@export var min_speed: float = 10.0
@export var max_speed: float = 18.0

func initialize(start_position: Vector3, player_position: Vector3) -> void:
	look_at_from_position(start_position, player_position, Vector3.UP)
	rotate_y(randf_range(-PI / 4.0, PI / 4.0))

	var random_speed: float = randf_range(min_speed, max_speed)
	velocity = Vector3.FORWARD * random_speed
	velocity = velocity.rotated(Vector3.UP, rotation.y)

	
	if $AnimationPlayer.has_animation("float"):
		$AnimationPlayer.play("float")
	else:
		var anims = $AnimationPlayer.get_animation_list()
		if anims.size() > 0:
			$AnimationPlayer.play(anims[0])

	$AnimationPlayer.speed_scale = random_speed / min_speed

func _physics_process(_delta: float) -> void:
	move_and_slide()

func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	queue_free()

func squash() -> void:
	squashed.emit()
	queue_free()
