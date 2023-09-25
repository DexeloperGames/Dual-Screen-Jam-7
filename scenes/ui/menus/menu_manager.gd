extends Control

@export var main_menu : PackedScene = preload("res://scenes/ui/menus/main_menu.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func clear():
	for child in $"Current Menu".get_children():
		child.queue_free()

func switch_to(scene : PackedScene):
	clear()
	$"Current Menu".add_child(scene.instantiate())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func switch_to_main():
	pass
