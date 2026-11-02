extends CharacterBody2D

var SPEED = 50
# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var player = get_node("../Player")

@export var stats: Enemies
#HP health of enemy
@onready var HP = stats.HEALTH
#DMG damage to player
@onready var DMG = stats.DAMAGE
#XP experience earned on kill
@onready var XP = 5
var chase = false	#consider moving to enemy class


func _physics_process(_delta):
	if get_node("AnimatedSprite2D").animation != "Death":
		if chase == true:
			#if get_node("AnimatedSprite2D").animation != "Death":
			get_node("AnimatedSprite2D").play("Walking")
			var direction = (player.position - self.position).normalized()
			if direction.x > 0:
				get_node("AnimatedSprite2D").flip_h = true
			else:
				get_node("AnimatedSprite2D").flip_h = false
			velocity.x = direction.x * SPEED	# move on x-axis
			velocity.y = direction.y * SPEED	# move on y-axis
		move_and_slide()
		#print("Player")
	

# detects player and chases player
func _on_player_detection_body_entered(body):
	if body.name == "Player":
		#print(stats.DAMAGE)
		
		chase = true

# detects player leaving and sets chase to false
func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false
		
		


@onready var gem = preload("res://Assets/Gems/gem.tscn")

#hurtBox
#detects when body is in group "attack" to deal damage
func _on_enemy_death_body_entered(body):
	if body.is_in_group("attack"):
		HP -= 1
		body.queue_free()
	elif body.is_in_group("Player"):
		while body.is_in_group("Player"):
			body.hp -= 1
			#print("ZombiePerson")
	if HP <= 0:
		get_node("AnimatedSprite2D").play("Death")
		await get_node("AnimatedSprite2D").animation_finished
		
		# FOR EXP
		var gem_instance = gem.instantiate()
		get_parent().add_child(gem_instance)
		gem_instance.experience = XP
		gem_instance.setColor()
		gem_instance.position = self.global_position
		self.queue_free()
