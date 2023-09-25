extends Node2D
class_name Note

@export var parent_column : NoteColumn
@export var hit_time : float = 0.0
@export_range(0,3,1) var note_index : int = 0
@onready var mesh_instance : MeshInstance2D = $MeshInstance2D
var active : bool = false
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
	pass

func update_note_index():
	mesh_instance.material.set_shader_parameter("Note_Index",note_index)

func activate():
	process_mode = Node.PROCESS_MODE_INHERIT
	active = true
