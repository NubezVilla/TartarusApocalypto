extends CharacterBody2D

@onready var animSprite = get_node("AnimatedSprite2D")
@onready var food_item = preload("res://Assets/food/food.tscn")

var hp = 4
var active = true


func _on_bullet_detection_body_entered(body):
	if body.is_in_group("attack"):
		hp -= 1
		body.queue_free()
	if hp <= 0 && active == true:
		animSprite.play("Death")
		await animSprite.animation_finished
		var food_instance = food_item.instantiate()
		food_instance.position = self.global_position + Vector2(30,45)
		get_parent().add_child(food_instance)
		animSprite.play("Lamppost_destroyed")
		active = false
	get_node("HitBox").set_deferred("disabled", true)
