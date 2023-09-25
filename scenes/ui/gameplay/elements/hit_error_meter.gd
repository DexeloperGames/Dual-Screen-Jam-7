extends Node2D

@export var current_average : float = 0.0
@export var average_line_speed : float = 5.0
@export var max_width = 200
@onready var tween : Tween = create_tween()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func generate_line(x_pos, color):
	var line = Line2D.new()
	line.add_point(Vector2(0,40))
	line.add_point(Vector2(0,-40))
	line.modulate = color
	$"Hit Line Container".add_child(line)
	line.position.x = x_pos
	line.joint_mode = Line2D.LINE_JOINT_ROUND
	line.begin_cap_mode = Line2D.LINE_CAP_ROUND
	line.end_cap_mode = Line2D.LINE_CAP_ROUND
	var line_tween = create_tween()
#	tween.tween_property(line,"position",Vector2(0,100),0.1)
	line_tween.tween_property(line,"scale", Vector2(1.0,0.0),5).set_ease(Tween.EASE_OUT)
	line_tween.tween_property(line,"modulate", Color(line.modulate,0.0),5).set_ease(Tween.EASE_OUT)
	line_tween.tween_callback(line.queue_free)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$"Average Line".position.x = lerp($"Average Line".position.x, -max_width*current_average/Globals.good_hit_time, delta*average_line_speed)
	pass

func recieve_player_hit(rating, offset):
#	print("lol hit ", offset)
	offset = 1000.0*offset
	current_average = 0.9*current_average + 0.1*offset
	generate_line(-max_width*offset/Globals.good_hit_time,Color.GREEN)
	pass
