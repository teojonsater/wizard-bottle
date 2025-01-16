extends BaseSpell

# @export var spawn_offset := Vector2(30, 0)
# @export var speed: float = 250

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# self.position = self.caster.position + self.spawn_offset
	print("Fireball!")


func _process(delta: float) -> void:
	# self.position.x += speed * delta
	pass
