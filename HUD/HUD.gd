extends CanvasLayer

func _ready():
	for prop in get_tree().get_nodes_in_group("clickable"):
		print(prop)
		prop.connect("update_hud", self, "display_hud")
		
		
func display_hud(prop):
	$Tween.interpolate_property($Panel,
								"rect_position",
								null,
								Vector2.ZERO,
								.5,
								Tween.TRANS_QUINT,
								Tween.EASE_OUT)
								
	$Tween.start()
	
	$Timer.start()
	
	self.display_flavor_text(prop)
	
func hide_hud():
	$Tween.interpolate_property($Panel,
								"rect_position",
								null,
								Vector2(-182, 0),
								.5,
								Tween.TRANS_QUINT,
								Tween.EASE_OUT)
								
	$Tween.start()
	
func display_flavor_text(prop):
	$Panel/TextureRect.texture = prop.flavor_text.picture
	$Panel/RichTextLabel.text = prop.flavor_text.description
	$Panel/Label.text = prop.flavor_text.name
	


func _on_Timer_timeout():
	hide_hud()
	$Timer.stop()
