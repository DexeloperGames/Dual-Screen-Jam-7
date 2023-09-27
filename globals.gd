extends Node

var note_colors : Array[Color] = [Color.MAGENTA, Color.CYAN, Color.GREEN, Color.RED]
var good_hit_time = 50
var great_hit_time = 30
var perfect_hit_time = 20
var marvelous_hit_time = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func get_rating(offset):
	if abs(offset) < Globals.marvelous_hit_time:
		return 4
	if abs(offset) < Globals.perfect_hit_time:
		return 3
	if abs(offset) < Globals.great_hit_time:
		return 2
	if abs(offset) < Globals.good_hit_time:
		return 1
	return 0
