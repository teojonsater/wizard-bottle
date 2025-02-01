extends Node2D
class_name BaseSpell

var spell_resource: SpellResource
var caster: Node2D
var direction: int:
	set(value):
		direction = 1 if value == 0 else sign(value)

func _ready() -> void:
	print(caster.to_string() + " cast " + self.spell_resource.name)

func cast() -> void:
	self.caster.get_tree().root.add_child(self)
