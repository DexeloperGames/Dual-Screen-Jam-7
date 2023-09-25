extends Node2D

@export var chart : Chart
@export var note_columns : Array[NoteColumn]
# Called when the node enters the scene tree for the first time.
func _ready():
	load_chart()
	pass # Replace with function body.

signal note_hit(note : Note,offset : float)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var songtime = get_song_time()
	for note_column in note_columns:
		note_column.song_time = songtime
	pass

func get_song_time():
	var playback_time = $AudioStreamPlayer.get_playback_position() + AudioServer.get_time_since_last_mix()
	playback_time -= AudioServer.get_output_latency()
	return playback_time

func _input(event):
	pass
#	print(event.as_text())
#	if event.is_action_pressed("note_0"):
#		print("note0")

func load_chart():
	for data in chart.data:
		var index = data[0]
		var hit_time = data[1]
		var note_column = note_columns[index]
		note_column.note_hit_time_array.append(hit_time)
	for note_column in note_columns:
		note_column.spawn_notes()


func _on_note_column_0_note_hit(note, offset):
	emit_signal("note_hit",note,offset)
	pass # Replace with function body.


func _on_note_column_1_note_hit(note, offset):
	emit_signal("note_hit",note,offset)
	pass # Replace with function body.


func _on_note_column_2_note_hit(note, offset):
	emit_signal("note_hit",note,offset)
	pass # Replace with function body.


func _on_note_column_3_note_hit(note, offset):
	emit_signal("note_hit",note,offset)
	pass # Replace with function body.
