extends CharacterBody2D

var speed = 300
var dir = Vector2(0, 1)
@onready var animSprite = get_node("AnimatedSprite2D")
@export var attack: bool
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.s
func _process(delta):
	var _collision_info = self.move_and_collide(dir.normalized() * delta * speed)
	


func _on_area_2d_body_entered(body):
	get_node("HitBox").set_deferred("disabled", true)
	if body.is_in_group("Player"):
		body.hp -= 1
		#print("SPIT!!")
		animSprite.play("Splat")
		await animSprite.animation_finished
		self.queue_free()
		
