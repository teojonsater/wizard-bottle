extends Node2D
class_name BaseSpell

var spell_resource: SpellResource
var caster: Node2D

func _ready() -> void:
	print("Casting " + self.spell_resource.name)

func cast() -> void:
	self.caster.get_tree().root.add_child(self)
