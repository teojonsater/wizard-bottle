extends Node

var equipped_spells: Array[SpellResource]
var spell_cooldowns: Dictionary # {SpellResource: Timer}
var selected_spell := 0

func _ready() -> void:
	self.equipped_spells = SpellsManager.equipped_spells
	
	for spell in equipped_spells:
		var timer = Timer.new()
		timer.one_shot = true
		self.add_child(timer)
		self.spell_cooldowns[spell] = timer


func cycle_spells(direction: int):
	self.selected_spell = (self.selected_spell + direction + equipped_spells.size()) % equipped_spells.size()
	print("Selected " + self.equipped_spells[self.selected_spell].name)

func on_spell_cast(caster: Node2D) -> bool:
	var equipped_spell: SpellResource = self.equipped_spells[selected_spell]
	var spell_timer: Timer = self.spell_cooldowns[equipped_spell]
	
	if !spell_timer.is_stopped():
		return false
	
	var equipped_spell_node: BaseSpell = equipped_spell.spell_scene.instantiate()
	
	if (equipped_spell_node is not BaseSpell):
		print(equipped_spell.name + " resource har fel node")
		return false
	
	spell_timer.start(equipped_spell.cooldown)
	equipped_spell_node.caster = caster
	equipped_spell_node.spell_resource = equipped_spell
	equipped_spell_node.cast()
	
	return true
