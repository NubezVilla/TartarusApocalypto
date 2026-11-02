extends Node2D

@onready var time = 10000
@onready var player = get_node("../Player")
@onready var zombiePerson = preload("res://Assets/ZombiePerson/zombie_person.tscn")
@onready var zombieDog = preload("res://Assets/ZombieDog/zombie_dog.tscn")
@onready var flyingZombie = preload("res://Assets/FlyingEnemy/flying_enemy.tscn")
@onready var stoneGolem = preload("res://Assets/StoneGolem/stone_golem.tscn")

#enviornment 
@onready var food = preload("res://Assets/food/food.tscn")
@onready var lamp = preload("res://Assets/LampPost/lamppost.tscn")
@onready var mailBox = preload("res://Assets/Mailbox/mail_box.tscn")

func _on_spawn_timer_timeout():
	#print(time)
	time -= 1
	var spawn
	if time % 7 == 0:
		spawn = flyingZombie.instantiate()
	elif time % 9 == 0:
		spawn = zombieDog.instantiate()
		#spawn = flyingZombie.instantiate()
	elif time % 31 == 0:
		spawn = food.instantiate()
	elif time % 50 == 0:
		spawn = stoneGolem.instantiate()
	else:
		spawn = zombiePerson.instantiate()
		#spawn = stoneGolem.instantiate()
		#spawn = flyingZombie.instantiate()
	var vpr = get_viewport_rect().size * randf_range(1.1,1.5)
	spawn = spawn_location(spawn, vpr)
	get_parent().add_child(spawn)
		#print(get_viewport_rect().size)
		
		
		
		
		
func spawn_location(spawn, vpr):
	var spawn_left = Vector2(player.global_position.x - vpr.x/2, 0)
	var spawn_right = Vector2(player.global_position.x + vpr.x/2, 0)
	var spawn_top = Vector2(0, player.global_position.y - vpr.y/2)
	var spawn_bottom = Vector2(0, player.global_position.y + vpr.y/2)
	#spawn.position = spawn_bottom
	var spawn_locations = randi_range(1,4)
	#print("Spawn location: "+str(spawn_location))
	match spawn_locations:
		1:
			spawn.position = spawn_top
		2:
			spawn.position = spawn_left
		3:
			spawn.position = spawn_bottom
		4:
			spawn.position = spawn_right
	return spawn
		#print(spawn.position)
		#spawn.look_at(player.position)
	
