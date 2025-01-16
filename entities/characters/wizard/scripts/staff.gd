extends Sprite2D

const BOB_AMPLITUDE := 1.5
const ROT_AMPLITUDE := 0.1
const BOB_FREQUENCY := 2.0

const ATTACK_MOVE_DIST := 15
const ATTACK_MOVE_ROT := 60
const ATTACK_MOVE_DUR := 1.0

var default_pos := self.position
var time := 0.0
var is_idle = true

func _process(delta) -> void:
	if self.is_idle:
		self.time += delta * BOB_FREQUENCY
		self.position.y = self.default_pos.y + BOB_AMPLITUDE * sin(self.time * BOB_FREQUENCY)
		self.rotation = sin(self.time * BOB_FREQUENCY) * ROT_AMPLITUDE

func play_cast_animation() -> void:
	if self.is_idle == false: return
	self.is_idle = false
	
	const MOVE_OUT_TIME = ATTACK_MOVE_DUR * 0.3
	const PAUSE_TIME = ATTACK_MOVE_DUR * 0.3
	
	var target_pos = self.default_pos + Vector2(ATTACK_MOVE_DIST, 0)
	var target_rot = ATTACK_MOVE_ROT
	
	var tween = create_tween().set_parallel()
	tween.tween_property(self, "position", target_pos, MOVE_OUT_TIME)\
		.set_trans(Tween.TRANS_EXPO)\
		.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "rotation_degrees", target_rot, MOVE_OUT_TIME)\
		.set_trans(Tween.TRANS_EXPO)\
		.set_ease(Tween.EASE_OUT)
	tween.tween_callback(attack_back).set_delay(MOVE_OUT_TIME + PAUSE_TIME)

func attack_back() -> void:
	const MOVE_BACK_TIME = ATTACK_MOVE_DUR * 0.4
	
	var tween = create_tween().set_parallel()
	
	tween.tween_property(self, "position", default_pos, MOVE_BACK_TIME)\
		.set_trans(Tween.TRANS_CUBIC)\
		.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "rotation_degrees", 0, MOVE_BACK_TIME)\
		.set_trans(Tween.TRANS_CUBIC)\
		.set_ease(Tween.EASE_OUT)
	
	tween.tween_callback(func():
			self.is_idle = true
			self.time = 0
			self.position.y = default_pos.y
	).set_delay(MOVE_BACK_TIME)
