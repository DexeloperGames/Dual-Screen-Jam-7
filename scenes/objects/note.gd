extends Node2D
class_name Note

@export var parent_column : NoteColumn
@export var hit_time : float = 0.0
@export_range(0,3,1) var note_index : int = 0
@export var note_snap : int = 0
@export var use_snap_colors : bool = false
@onready var mesh_instance : MeshInstance2D = $MeshInstance2D
var active : bool = false
var is_hit : bool = false
var hit_offset : float = 0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if parent_column.auto_play and parent_column.song_time >= hit_time:
		hit()
		pass
	pass

func hit():
	process_mode = Node.PROCESS_MODE_DISABLED
	visible = false
	active = false
	is_hit = true
	hit_offset = hit_time - parent_column.song_time
	parent_column.emit_signal("note_hit", self, hit_offset)
	pass

func update_note_index():
	mesh_instance.material.set_shader_parameter("Note_Index",note_index)

func update_note_snap():
	mesh_instance.material.set_shader_parameter("Use_Snap_Colors", use_snap_colors)
	modulate = Globals.snap_colors[note_snap]

func activate():
	process_mode = Node.PROCESS_MODE_INHERIT
	active = true
