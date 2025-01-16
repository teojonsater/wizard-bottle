extends Node2D
class_name BaseSpell

var spell_resource: SpellResource
var caster: Node2D

func cast() -> void:
	self.caster.get_tree().root.add_child(self)
