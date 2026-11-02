extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Utils.open_file()
	#pass

func _on_world_pressed():
	get_tree().change_scene_to_file("res://World.tscn")


func _on_quit_pressed():
	get_tree().quit()

func _on_score_pressed():
	get_tree().change_scene_to_file("res://scoreboard.tscn")
