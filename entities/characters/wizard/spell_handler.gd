extends Node

var equipped_spells: Array[Spell]
var selected_spell = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	equipped_spells = [
		load("res://spells/fireball/fireball.tres")
	]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_spell_cast() -> void:
	add_child(equipped_spells[selected_spell].spell_node.instantiate())
