extends Sprite2D

@export var bobbing_amplitude := 1.5
@export var rot_amplitude := 0.1
@export var bobbing_frequency := 2.0
@export var attack_move_distance := 10
@export var attack_move_rotation := 360 + 60
@export var attack_move_duration := 0.4

var default_pos := self.position
var time := 0.0
var is_idle = true

func _process(delta):
	if is_idle:
		time += delta * bobbing_frequency
		position.y = default_pos.y + bobbing_amplitude * sin(time * bobbing_frequency)
		rotation = sin(time * bobbing_frequency) * rot_amplitude

func _input(event):
	if event.is_action_pressed("ui_accept"):
			attack_out_and_back()

func attack_out_and_back():
	if is_idle == false: return
	is_idle = false
	var target_pos = default_pos + Vector2(attack_move_distance, 0)
	var target_rot = attack_move_rotation
	
	var tween = create_tween().set_parallel()
	tween.tween_property(self, "position", target_pos, attack_move_duration)\
		.set_trans(Tween.TRANS_QUINT)\
		.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "rotation_degrees", target_rot, attack_move_duration)\
		.set_trans(Tween.TRANS_QUINT)\
		.set_ease(Tween.EASE_OUT)
	tween.tween_callback(attack_back).set_delay(attack_move_duration * 2)

func attack_back():
	var tween = create_tween().set_parallel()
	
	tween.tween_property(self, "position", default_pos, attack_move_duration)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "rotation_degrees", 0, attack_move_duration)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)
	
	tween.tween_callback(func():
			is_idle = true
			time = 0
			position.y = default_pos.y
	).set_delay(attack_move_duration)
