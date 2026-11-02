extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if (get_global_mouse_position().x - get_global_position().x) < 0:
		get_node("weaponSprite").flip_v = true
		look_at((get_global_mouse_position()))
		
	elif (get_global_mouse_position().x - get_global_position().x) >= 0:
		get_node("weaponSprite").flip_v = false;
		look_at(get_global_mouse_position())
