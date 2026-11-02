extends CharacterBody2D

var speed = 250
var dir = Vector2(0, 1)
@onready var animSprite = get_node("AnimatedSprite2D")
@export var attack = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.s
func _process(delta):
	var _collision_info = self.move_and_collide(dir.normalized() * delta * speed)
	


func _on_area_2d_body_entered(body):
	#get_node("Area2D/HurtBox").set_disabled(true)
	#get_node("HitBox").set_disabled(true)
	if body.is_in_group("Player") && attack == true:
		get_node("HitBox").set_deferred("disabled",true)
		attack = false
		body.hp -= 5
		#print("SPIT!!")
		animSprite.play("Splat")
		await animSprite.animation_finished
		self.queue_free()
