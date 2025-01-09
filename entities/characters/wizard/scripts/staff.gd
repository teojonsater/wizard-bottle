extends Sprite2D

const BOB_AMPLITUDE := 1.5
const ROT_AMPLITUDE := 0.1
const BOB_FREQUENCY := 2.0
const ATTACK_MOVE_DIST := 15
const ATTACK_MOVE_ROT := 60
const ATTACK_MOVE_DUR := 0.5

var default_pos := self.position
var time := 0.0
var is_idle = true

func _process(delta) -> void:
	if is_idle:
		time += delta * BOB_FREQUENCY
		position.y = default_pos.y + BOB_AMPLITUDE * sin(time * BOB_FREQUENCY)
		rotation = sin(time * BOB_FREQUENCY) * ROT_AMPLITUDE

func _on_spell_cast() -> void:
	play_cast_animation()

func play_cast_animation() -> void:
	if is_idle == false: return
	is_idle = false
	var target_pos = default_pos + Vector2(ATTACK_MOVE_DIST, 0)
	var target_rot = ATTACK_MOVE_ROT
	
	var tween = create_tween().set_parallel()
	tween.tween_property(self, "position", target_pos, ATTACK_MOVE_DUR)\
		.set_trans(Tween.TRANS_EXPO)\
		.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "rotation_degrees", target_rot, ATTACK_MOVE_DUR)\
		.set_trans(Tween.TRANS_EXPO)\
		.set_ease(Tween.EASE_OUT)
	tween.tween_callback(attack_back).set_delay(ATTACK_MOVE_DUR * 1.5)

func attack_back() -> void:
	var tween = create_tween().set_parallel()
	
	tween.tween_property(self, "position", default_pos, ATTACK_MOVE_DUR)\
		.set_trans(Tween.TRANS_CUBIC)\
		.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "rotation_degrees", 0, ATTACK_MOVE_DUR)\
		.set_trans(Tween.TRANS_CUBIC)\
		.set_ease(Tween.EASE_OUT)
	
	tween.tween_callback(func():
			is_idle = true
			time = 0
			position.y = default_pos.y
	).set_delay(ATTACK_MOVE_DUR)
