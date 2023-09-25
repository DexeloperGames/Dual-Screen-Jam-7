extends Control

@export var menu_screen : PackedScene = preload("res://scenes/ui/menus/menu_manager.tscn")
@export var gameplay_screen : PackedScene = preload("res://scenes/ui/gameplay/gameplay_screen.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func clear():
	for child in $"Current Screen".get_children():
		child.queue_free()

func switch_to(scene : PackedScene):
	clear()
	$"Current Screen".add_child(scene.instantiate())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func switch_to_menu():
	switch_to(menu_screen)

func switch_to_gameplay():
	switch_to(gameplay_screen)
