extends CharacterBody2D


var SPEED = 100


@onready var nagivation_agent = $Navigation/NavigationAgent2D
@onready var player = get_node("../Player")
@onready var animPlayer = get_node("AnimationPlayer")
@onready var animSprite = get_node("AnimatedSprite2D")
@onready var zombieSprite = preload("res://Assets/StoneGolem/Zombie_Projectile.tscn")

#intializse a variable to access the Enemies class
@export var stats: Enemies
#HP health of enemy
@onready var HP = stats.HEALTH
#DMG damage to player
@onready var DMG = stats.DAMAGE
#XP experience earned on kill
@onready var XP = 15


var attack = false

# pauses the system to complete the setup of navigation server 2D
# the NavigationServer2D must synch with the physics frames
func _ready():
	# Wait one frame for the Navigation map to load, then give the Golem its first target immediately
	await get_tree().physics_frame
	if is_instance_valid(player):
		nagivation_agent.target_position = player.global_position

# Change _process to _physics_process for CharacterBody2D movement
func _physics_process(_delta):
	# Stop walking if the Golem is currently playing an attack animation
	if attack:
		return
		
	# Do not move if the Golem has reached the player or the path isn't ready
	if nagivation_agent.is_navigation_finished():
		return
		
	var next_path_position = nagivation_agent.get_next_path_position()
	var direction = global_position.direction_to(next_path_position)
	
	velocity = direction * SPEED
	move_and_slide()

@onready var gem = preload("res://Assets/Gems/gem.tscn")

func _on_bullet_detection_body_entered(body):
	if body.is_in_group("attack"):
		HP -= 1
		body.queue_free()
		#print(HP)
	if HP <= 0:
		animPlayer.play("Death")
		await animPlayer.animation_finished
		self.queue_free()
		
		
		# FOR EXP
		var gem_instance = gem.instantiate()
		get_parent().add_child(gem_instance)
		gem_instance.experience = XP
		gem_instance.set_color()
		gem_instance.position = self.global_position
		self.queue_free()


func _on_attack_timer_timeout():
	attack = true
	if attack == true:
		animPlayer.play("Attacking")
		await animPlayer.animation_finished
		throw()
		attack = false
	animPlayer.play("Walking")
	#animPlayer.play("Attack")
	
func throw():
		#print("SPITTING!!")
	var z_throw = zombieSprite.instantiate()
	get_parent().add_child(z_throw)
	z_throw.position = self.global_position # set position to market
	z_throw.dir = (player.global_position - self.global_position) # set direction to
	z_throw.look_at(player.global_position)





func _on_recalc_path_timeout():
	if is_instance_valid(player):
		nagivation_agent.target_position = player.global_position
