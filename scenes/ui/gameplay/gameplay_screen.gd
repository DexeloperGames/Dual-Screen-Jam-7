extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	var hit_recievers = get_tree().get_nodes_in_group("Player Hit Recievers")
	for node in hit_recievers:
		connect("player_hit", node.recieve_player_hit)
	pass # Replace with function body.

signal player_hit(note, offset)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_playfeild_note_hit(note, offset):
#	print("lol")
	emit_signal("player_hit", note, offset)
	pass # Replace with function body.
