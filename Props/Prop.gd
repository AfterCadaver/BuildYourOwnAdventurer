extends StaticBody2D

class_name Prop

export (float, -1, 25, 1) var max_strength = -1
export (Resource) var flavor_text
onready var BB = get_tree().get_root().find_node("BlackBoard")

signal update_hud(prop)

func _ready():
	add_to_group("clickable")

func _process(delta):
	pass


func _on_Prop_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		emit_signal("update_hud", self)

func _physics_process(delta):
	pass

