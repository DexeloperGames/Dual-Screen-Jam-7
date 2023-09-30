extends Node

var note_colors : Array[Color] = [Color.MAGENTA, Color.CYAN, Color.GREEN, Color.RED]
var good_hit_time = 50
var great_hit_time = 30
var perfect_hit_time = 20
var marvelous_hit_time = 10
var snap_colors : Array[Color] = [Color.GRAY,Color.RED,Color.BLUE,Color.GREEN,Color.YELLOW,Color.AQUA,Color.MAGENTA,Color.ORANGE,Color.CYAN]
var beat_fractions : Array
var beat_fraction_factors : PackedFloat32Array
# Called when the node enters the scene tree for the first time.
func _ready():
	var fractions : Array = generate_reduced_fractions([[0,1],[1,1]],8)
	print(fractions)
	beat_fraction_factors.resize(len(fractions))
	for i in range(fractions.size()):
		beat_fraction_factors[i] = fractions[i][0]/float(fractions[i][1])
	print(beat_fraction_factors)
	beat_fractions = fractions
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

func generate_reduced_fractions(fractions : Array, dinominator_limit : int):
	var new_fraction_array = [fractions[0]]
	for i in range(1,len(fractions)):
		var fraction_1 = fractions[i-1]
		var fraction_2 = fractions[i]
		var new_fraction = [fraction_1[0]+fraction_2[0],fraction_1[1]+fraction_2[1]]
		if new_fraction[1] <= dinominator_limit:
			new_fraction_array += [new_fraction, fraction_2]
		else:
			new_fraction_array += [fraction_2]
	if len(fractions) == len(new_fraction_array):
		return new_fraction_array
	return generate_reduced_fractions(new_fraction_array, dinominator_limit)


func get_nearest_index(array : Variant, value : Variant):
	var index_1 : int = array.bsearch(value)
	if array.size() < 2: return index_1
	var index_2 : int = index_1 - 1
	if index_1 >= array.size(): return index_2
	return index_1 if abs(array[index_1] - value) < abs(array[index_2] - value) else index_2


func get_beat_snap(beat_factor : float):
	return beat_fractions[get_nearest_index(beat_fraction_factors,beat_factor)][1]
