extends Area2D
class_name HurtboxComponent

@export var health_component: HealthComponent
@export var hitbox_component: HitboxComponent


func _on_hit(body: Area2D) -> void:
	if body is HitboxComponent and health_component and body != hitbox_component:
		self.health_component.take_damage(body.damage)
		
