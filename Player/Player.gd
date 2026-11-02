extends CharacterBody2D
@onready var anim = get_node("AnimationPlayer")

var movement_speed = 175
var bullet_speed = 4000
var bullet = preload("res://Player/Bullet/Bullet.tscn")

#@export var stats: playerStats


# Called when the node enters the scene tree for the first time.
func _ready():
	self.z_index = 1
	set_expbar(experience, calculate_exp_cap())
	healthBar.max_value = 12
	#var score_output = "res://scores/scores.txt"
	#var file = FileAccess.open(score_output, FileAccess.WRITE)

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	movement()
	# Animate movement
	if abs(velocity.x) > 0 || abs(velocity.y) > 0:
		anim.play("Running")
	else:
		anim.play("Idle")
		
	# fire
	if Input.is_action_just_pressed("LMB"):
		fire()
	
	healthBar.value = hp
	
	if hp <= 0:
		queue_free()
		# final print to scoreboard here
		get_tree().change_scene_to_file("res://main.tscn")
	
	

		

func movement():
	var x_mov = Input.get_action_strength("Right") - Input.get_action_strength("Left") # East -1, West 1
	var y_mov = Input.get_action_strength("Down") - Input.get_action_strength("Up") # North -1, South 1
	var mov = Vector2(x_mov, y_mov)
	velocity = mov.normalized() * movement_speed
	
	# Flip
	#var direction = x_mov
	#if direction == -1:
	if (get_global_mouse_position().x - get_global_position().x) < 0:
		get_node("AnimatedSprite2D").flip_h = true
		
	#elif direction == 1:
	elif (get_global_mouse_position().x - get_global_position().x) >= 0:
		get_node("AnimatedSprite2D").flip_h = false;
	

	
	move_and_slide() # causes character to move
	
func fire():
	#print("FIRING!!")
	var bullet_instance = bullet.instantiate()
	get_parent().add_child(bullet_instance)
	bullet_instance.position = $WeaponHandler/weaponSprite/Marker2D.global_position # set position to market
	bullet_instance.dir = (get_global_mouse_position() - get_global_position()) # set direction to
	bullet_instance.look_at((get_global_mouse_position()))
	
	
	
	
# #Xp
var experience = 0
var level = 1
var collected_exp = 0
var score = 0

#exp gui
@onready var expBar = get_node("%ExpBar")
@onready var lblLevel = get_node("%Label_Level")




func _on_grab_area_area_entered(area):
	if area.is_in_group("loot"):
		area.target = self


func _on_collect_area_area_entered(area):
	if area.is_in_group("loot"):
		var gem_exp = area.collect()
		calculate_exp(gem_exp)
		
func calculate_exp(gem_exp):
	var exp_required = calculate_exp_cap()
	score += gem_exp
	collected_exp+= gem_exp
	# check if level
	if (experience + collected_exp) >= exp_required: # levelup
		collected_exp -= exp_required - experience
		level += 1
		lblLevel.text = str("Level: ", level) # adjust ui
		experience = 0
		exp_required = calculate_exp_cap()
		calculate_exp(0)
	else:
		experience += collected_exp
		collected_exp = 0
		
	set_expbar(experience, exp_required) # adjust UI
	PlayerStats.scores_exp += 1
	Utils.saveScore()
	
	#if gem_exp != 0:
	#	print("level: ", level) #debug
	
	
func calculate_exp_cap():
	var exp_cap = level
	if level < 20:
		exp_cap = exp_cap * 5
	elif level < 40:
		exp_cap = 95 + exp_cap
	else:
		exp_cap = 255 + (level-39) * 12
	return exp_cap

func set_expbar(set_value = 1, set_max_value = 100):
	expBar.value = set_value
	expBar.max_value = set_max_value

#hp gui
@export var hp = 12
@onready var healthBar = get_node("%HealthBar")




func _on_hurt_box_body_entered(_body):
	#if body.name == "ZombieDog" || body.name == "FlyingEnemy" || body.name == "ZombiePerson":
	#	hp -= 1
	#	healthBar.value -= 1
		
	#healthBar.value = hp
	pass
		
