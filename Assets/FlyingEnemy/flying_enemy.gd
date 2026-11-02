extends CharacterBody2D

var SPEED = 125

# get Navigation region
@onready var navigation_agent = $Navigation/NavigationAgent2D
# get Navigation agent. This is neded to work with the NavigationRegion2D
#@onready var navigation_agent = get_node("NavigationAgent2D")
#@onready var nav_region_2d = get_node_and_resource("World/NavigationRegion2D")

@onready var player = get_node("../Player")
@onready var animPlayer = get_node("AnimationPlayer")
@onready var animSprite = get_node("AnimatedSprite2D")
@onready var spitting = preload("res://Assets/FlyingEnemy/Spit.tscn")

#intializse a variable to access the Enemies class
@export var stats: Enemies
#HP health of enemy
@onready var HP = stats.HEALTH
#DMG damage to player
@onready var DMG = stats.DAMAGE
#XP experience earned on kill
@onready var XP = 20
var chase = false
var attack = false
var first_pass = true

# process is where the movement will occur
func _process(_delta):
	# If the enemy hasn't spotted the player yet, don't do anything
	if not chase:
		return

	# Get the next point on the path from the NavigationAgent2D
	var next_path_position = navigation_agent.get_next_path_position()
	
	# Figure out which direction to fly
	var direction = global_position.direction_to(next_path_position)
	
	# CharacterBody2D uses velocity and move_and_slide() to handle movement and collisions automatically
	velocity = direction * SPEED
	move_and_slide()


func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true

@onready var gem = preload("res://Assets/Gems/gem.tscn")
var xp = 20

#hurtBox
func _on_enemy_death_body_entered(body):
	if body.is_in_group("attack"):
		HP -= 1
		body.queue_free()
		#print(HP)
	if HP <= 0:
		animPlayer.play("Death")
		await animPlayer.animation_finished
		
				# FOR EXP
		var gem_instance = gem.instantiate()
		get_parent().add_child(gem_instance)
		gem_instance.experience = XP
		gem_instance.setColor()
		gem_instance.position = self.global_position
		self.queue_free()
	elif body.is_in_group("Player"):
		body.hp -= 1
		#print("FlyingZombie")

#on timeout, play the attack animation
func _on_attack_timer_timeout():
	attack = true
	if attack == true:
		animPlayer.play("Attack")
		spit()
		await animPlayer.animation_finished
		attack = false
	animPlayer.play("Flying")
	#animPlayer.play("Attack")

func spit():
	#print("SPITTING!!")
	var spit_instance = spitting.instantiate()
	get_parent().add_child(spit_instance)
	spit_instance.position = self.global_position # set position to market
	spit_instance.dir = (player.global_position - self.global_position) # set direction to
	spit_instance.look_at(player.global_position)



func _on_recalc_time_timeout():
	if chase:
			navigation_agent.target_position = player.global_position
