extends CharacterBody2D

var speed = 400
var dir = Vector2(0, 1)
@export var attack: bool



# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(1.0).timeout
	queue_free()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var _collision_info = self.move_and_collide(dir.normalized() * delta * speed)
