extends Node
class_name HealthComponent

signal health_changed(new_health: int)
signal died

@export var max_health: int:
	set(new_max):
		max_health = max(1, new_max)
		if health > 0:  # Bara uppdatera om health redan har ett värde
			health = min(health, max_health)
		

@onready var health: int = max_health:
	set(new_health):
		health = clampi(new_health, 0, max_health)
		if health == 0:
			health_zero()

func take_damage(amount: int) -> void:
	self.health -= amount
	self.health_changed.emit(self.health)

func health_zero():
	self.get_parent().queue_free()
	self.died.emit()
