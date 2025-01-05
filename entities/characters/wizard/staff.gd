extends Sprite2D

@export var bobbingAmplitude := 1.5
@export var rotAmplitude := 0.1
@export var frequency := 2.0
var default_pos := self.position
var time := 0.0

func _process(delta):
	time += delta * frequency
	position.y = default_pos.y + bobbingAmplitude * sin(time * frequency)
	rotation = sin(time * frequency) * rotAmplitude
