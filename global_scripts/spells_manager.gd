extends Node

var equipped_spells: Array[SpellResource] = []
var all_spells: Array[SpellResource] = []

func _ready():
	load_spells()
	
	# TODO: Ta bort när huvudmeny implementeras
	for spell: SpellResource in self.all_spells:
		equip_spell(spell)

func equip_spell(spell: SpellResource):
	self.equipped_spells.append(spell)

func unequip_spell(spell: SpellResource):
	self.equipped_spells.remove_at(self.equipped_spells.find(spell))

func load_spells():
	var base_dir: String = "res://spells/"
	var spell_folders: DirAccess = DirAccess.open(base_dir)
	
	if spell_folders == null:
		print("Could not open spells directory")
		return
	
	for directory: String in spell_folders.get_directories():
		var spell_directory: DirAccess = DirAccess.open(base_dir + directory)
		
		if spell_directory == null:
			print("Could not open " + directory + " directory")
			return
		
		spell_directory.list_dir_begin()
		var file_name: String = spell_directory.get_next()
		while file_name != "":
			if !spell_directory.current_is_dir() && file_name.ends_with(".tres"):
				var loaded_resource: String = base_dir + directory + '/' + file_name
				print("Loaded spell: " + loaded_resource)
				self.equipped_spells.append(load(loaded_resource))
			file_name = spell_directory.get_next()
