extends Node

const save_path = "res://savedgames.bin"
#@onready var player = get_parent().get_node("res://Player/Player.gd")
@onready var player = get_tree().get_first_node_in_group("Player")
var content
func open_file():
	var file_in = FileAccess.open(save_path, FileAccess.READ) 
	content = file_in.get_as_text()
	#print("OLD SCORE: " + content)
	file_in.close()

func saveScore():
	var file_out = FileAccess.open(save_path, FileAccess.WRITE)
	var data = PlayerStats.scores_exp
	file_out.store_line(content + str(data))	# adds most recent playthroughs score to the end
	
	#file_in.close()
	#file_out.close()
