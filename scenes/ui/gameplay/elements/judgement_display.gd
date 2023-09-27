extends Node2D

@export var judgement_colors : Array[Color] = [Color.RED,Color.GREEN_YELLOW,Color.GREEN,Color.GOLD,Color.LIGHT_SKY_BLUE]
@export var judgement_text : Array[String] = ["Miss -_-", "Good", "Great!", "Perfect!!", "Marvelous!!!"]
var tween : Tween
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func animate_judgement():
	if tween:
		tween.kill()
	tween = create_tween()
	
	tween.tween_property($Pivot,"scale",Vector2.ONE,10.0/60.0).from(Vector2.ONE*1.3).set_trans(Tween.TRANS_ELASTIC)

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
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func recieve_player_hit(note, offset):
	var rating = get_rating(offset*1000.0)
	$Pivot/Label.modulate = judgement_colors[rating]
	$Pivot/Label.text = judgement_text[rating]
	animate_judgement()
	pass
