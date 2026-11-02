extends CharacterBody2D

var SPEED = 135
# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var player = get_node("../Player")

#intializse a variable to access the Enemies class
@export var stats: Enemies
#HP health of enemy
@onready var HP = stats.HEALTH
#DMG damage to player
@onready var DMG = stats.DAMAGE
#XP experience earned on kill
@onready var XP = 10
var chase = false


func _physics_process(_delta):
	if get_node("AnimatedSprite2D").animation == "Death":
		await get_node("AnimatedSprite2D").animation_finished
	elif get_node("AnimatedSprite2D").animation != "Death":
		if chase == true:
			#if get_node("AnimatedSprite2D").animation != "Death":
			get_node("AnimatedSprite2D").play("Running")
			var direction = (player.position - self.position).normalized()
			if direction.x > 0:
				get_node("AnimatedSprite2D").flip_h = true
			else:
				get_node("AnimatedSprite2D").flip_h = false
			velocity.x = direction.x * SPEED	# move on x-axis
			velocity.y = direction.y * SPEED	# move on y-axis
		move_and_slide()



func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true


@onready var gem = preload("res://Assets/Gems/gem.tscn")

func _on_enemy_death_body_entered(body):
	if body.is_in_group("attack"):
		body.queue_free()
		#if body.name == "Bullet":
		get_node("AnimatedSprite2D").play("Death")
		await get_node("AnimatedSprite2D").animation_finished
		
		# FOR EXP
		var gem_instance = gem.instantiate()
		get_parent().add_child(gem_instance)
		gem_instance.experience = XP
		print("Dog " + str(XP))
		gem_instance.setColor()
		gem_instance.position = self.global_position
		self.queue_free()
	elif body.is_in_group("Player"):
		body.hp -= 1
		#print("ZombieDog")
