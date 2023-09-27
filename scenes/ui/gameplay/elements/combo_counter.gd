extends Node2D

@export var display_max_combo : bool = false
@export var combo_text : String = "Combo: {combo}"
@export var max_combo_text : String = "Max Combo: {max_combo}"

var combo = 0
var max_combo = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_combo_label():
	var new_text = max_combo_text if display_max_combo else combo_text
	$Label.text = new_text.format({"combo":combo,"max_combo":max_combo})

func recieve_player_hit(note,offset):
	var rating = Globals.get_rating(offset*1000)
	combo += 1
	if rating == 0:
		combo = 0
	max_combo = max(combo, max_combo)
	update_combo_label()
	pass
