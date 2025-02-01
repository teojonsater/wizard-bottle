extends CharacterBody2D
class_name Player

@export var direction: int:
	set(value):
		direction = 1 if value == 0 else sign(value)

@export_enum("player_one", "player_two") var input_mappings: String

const ACCELERATION := 9.0
const MAX_SPEED := 100.0

func _ready() -> void:
	flip()

func _physics_process(_delta: float) -> void:
	var movement_dir := Input.get_axis(input_mappings + "_up", input_mappings + "_down")
	if movement_dir:
		self.velocity.y = clamp(self.velocity.y + ACCELERATION * movement_dir, -MAX_SPEED, MAX_SPEED)
	else:
		self.velocity.y = move_toward(velocity.y, 0, ACCELERATION)
	self.move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(input_mappings + "_cast"):
		var success = $SpellHandler.on_spell_cast(self)
		if success:
			$Staff.play_cast_animation()
	elif event.is_action_pressed(input_mappings + "_cycle_left"):
		$SpellHandler.cycle_spells(-1)
	elif event.is_action_pressed(input_mappings + "_cycle_right"):
		$SpellHandler.cycle_spells(1)

func flip():
	$SpellHandler.direction = self.direction
	$Staff.set_flip(self.direction)
	$Sprite.flip_h = self.direction < 0
