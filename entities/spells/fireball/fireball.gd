extends BaseSpell

@export var spawn_offset := Vector2(30, 0)
@export var speed: float = 250

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	self.position = self.caster.position + self.spawn_offset * self.direction
	$Sprite.flip_h = self.direction < 0


func _process(delta: float) -> void:
	self.translate(Vector2(speed * delta * self.direction, 0))


func _on_screen_exit() -> void:
	self.queue_free()
