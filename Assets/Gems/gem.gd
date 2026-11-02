extends Area2D
@onready var anim  = get_node("AnimatedGem")

@export var experience = 1 # gives 1 exp

var target = null
var speed = -1
 
@onready var collision = $CollisionShape2D
@onready var sound = $snd_collected


# Called when the node enters the scene tree for the first time.
func _ready():
	#setColor()
		
	
	await get_tree().create_timer(10.0).timeout
	queue_free()
	pass # Replace with function body.
	
func setColor():
	if experience <= 5:
		anim.play("White")
	elif experience <= 15:
		anim.play("Orange")
	else:
		anim.play("Red")

	
func _physics_process(delta):
	if target != null:
		global_position = global_position.move_toward(target.global_position, speed)
		speed += 2*delta

func collect():
	sound.play()
	anim.play("none")
	$CollisionShape2D.set_deferred("disabled", true)
	return experience

func _on_snd_collected_finished():
	queue_free()
