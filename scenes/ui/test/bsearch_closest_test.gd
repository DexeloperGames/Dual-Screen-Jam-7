extends Control

@export var array_thing : PackedFloat32Array
@export var label_array_thing : Array[Label]
@export var slidy_thing : HSlider
@export var slidy_label : Label
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func clear_highlights():
	for label in label_array_thing:
		label.modulate = Color.WHITE

func _on_h_slider_value_changed(value):
	slidy_label.text = "%3.4f"%value
	var closest_index = get_closest(value)
	clear_highlights()
	label_array_thing[closest_index].modulate = Color.CYAN
	pass # Replace with function body.

func get_closest(value):
	var index_1 = array_thing.bsearch(value)
	var index_2 = index_1-1
	return index_1 if abs(array_thing[index_1]-value) < abs(array_thing[index_2]-value) else index_2
