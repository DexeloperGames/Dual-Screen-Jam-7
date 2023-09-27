extends Node2D

@export var chart : Chart
@export var note_columns : Array[NoteColumn]
@export var auto_play : bool = false
@export var scroll_speed : float = 384*2
@export_range(0.01, 10, 0.01) var speed_scale : float = 1.0
var song_start_time : float = 0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	scroll_speed /= speed_scale
	$AudioStreamPlayer.pitch_scale = speed_scale
	load_chart()
	for note_column in note_columns:
		note_column.auto_play = auto_play
		note_column.scroll_speed = scroll_speed
		note_column.update_scroll_speed()
	song_start_time = Time.get_ticks_usec()/1.0e+6
	pass # Replace with function body.

signal note_hit(note : Note,offset : float)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var songtime = get_song_time()*speed_scale
	for note_column in note_columns:
		note_column.song_time = songtime
	pass

func get_song_time():
	return (Time.get_ticks_usec()/1.0e+6)-song_start_time
	
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
