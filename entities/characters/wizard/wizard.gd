extends CharacterBody2D

const ACCELERATION := 300.0
const MAX_SPEED := 90.0

signal cast

func _ready() -> void:
	self.motion_mode = CharacterBody2D.MOTION_MODE_FLOATING
	
	for child in self.get_children():
			if child.has_method("_on_cast"):
				self.connect("cast", Callable(child, "_on_cast"))

func _physics_process(delta: float) -> void:
	var movement_dir := Input.get_axis("player_up", "player_down")
	if movement_dir:
		self.velocity.y = clamp(self.velocity.y + ACCELERATION * movement_dir * delta, -MAX_SPEED, MAX_SPEED)
	else:
		self.velocity.y = move_toward(velocity.y, 0, ACCELERATION * delta)

	self.move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("player_cast"):
		cast.emit()
