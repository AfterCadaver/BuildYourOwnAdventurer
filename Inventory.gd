extends Resource

class_name Inventory

var drag_data = null

signal items_changed(indexes)
export (Array, Resource) var items = [null,null,null,null,null,null,null,null,null]

func _ready():
	pass
