extends CharacterBody2D
class_name Wizard

const ACCELERATION := 9.0
const MAX_SPEED := 100.0

signal cast_spell

func _ready() -> void:
	self.motion_mode = CharacterBody2D.MOTION_MODE_FLOATING

func _physics_process(_delta: float) -> void:
	var movement_dir := Input.get_axis("player_up", "player_down")
	if movement_dir:
		self.velocity.y = clamp(self.velocity.y + ACCELERATION * movement_dir, -MAX_SPEED, MAX_SPEED)
	else:
		self.velocity.y = move_toward(velocity.y, 0, ACCELERATION)
	self.move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("player_cast"):
		var success = $SpellHandler.on_spell_cast(self)
		if success:
			$Staff.play_cast_animation()
