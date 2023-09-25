extends Node2D
class_name NoteColumn

@export_range(0,3,1) var note_index : int = 0
@export var auto_play : bool = false
@export var song_time : float = 0.0
@export var note_scroller : Marker2D
@export var note_scroll_speed_scaler : Marker2D
@export var note_hit_time_array : PackedFloat32Array
@export var scroll_speed = 384.0*2
@export var note_scene : PackedScene = preload("res://scenes/objects/note.tscn")

var note_action_array : Array = ["note_0","note_1","note_2","note_3"]
var note_array : Array[Note]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	note_scroller.position.y = -song_time
	update_active_notes()
	pass

func update_scroll_speed():
	note_scroll_speed_scaler.scale.y = scroll_speed
	for note in note_array:
		note.scale.y = 1.0/scroll_speed

func update_active_notes():
	var starting_index = note_hit_time_array.bsearch(song_time)
	var ending_index = note_hit_time_array.bsearch(song_time+1)
	for i in range(starting_index,ending_index):
		var note = note_array[i]
		if not note.active:
			note.activate()

func clear():
	for child in note_scroller.get_children():
		child.queue_free()

func spawn_notes():
	clear()
	note_array.resize(note_hit_time_array.size())
	var i : int = 0
	for hit_time in note_hit_time_array:
		var new_note : Note = note_scene.instantiate()
		
		new_note.process_mode = Node.PROCESS_MODE_DISABLED
		new_note.hit_time = hit_time
		new_note.parent_column = self
		new_note.note_index = note_index
		note_scroller.add_child(new_note)
		new_note.position.y = hit_time
		note_array[i] = new_note
		i += 1
	update_scroll_speed()

func _input(event):
	if event.is_action_pressed(note_action_array[note_index]):
		print("\n\n",note_action_array[note_index])
		print($"Note Receptacle".modulate)
		$"Note Receptacle".modulate = Globals.note_colors[note_index]
		print($"Note Receptacle".modulate)
	if event.is_action_released(note_action_array[note_index]):
		$"Note Receptacle".modulate = Color.WHITE
