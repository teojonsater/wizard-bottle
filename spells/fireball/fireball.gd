extends BaseSpell

@export var spawn_offset := Vector2(30, 0)
@export var speed: float = 250
var direction: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	self.position = self.caster.position + self.spawn_offset
	randomize()
	var directions = [-1, 1]
	self.direction = directions.pick_random()


func _process(delta: float) -> void:
	self.position.x += speed * delta * direction


func _on_screen_exit() -> void:
	self.queue_free()
