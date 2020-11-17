extends CanvasLayer

func _ready():
	for prop in get_tree().get_nodes_in_group("clickable"):
		prop.connect("update_hud", self, "display_hud")


func _process(delta):
	
	var time_name = "Evening"
	
	var time_now = WhiteBoard.global_time
	
	if time_now >= 0.5:
		time_name = "Evening"
	else:
		time_name = "Daytime"
	
	$Label.set_text("TIME: %s" % time_name)
		
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

	$Panel/CenterContainer/TextureRect.texture = prop.flavor_text.picture
	$Panel/CenterContainer/RichTextLabel.text = prop.flavor_text.description
	$Panel/CenterContainer/Label.text = prop.flavor_text.name
	


func _on_Timer_timeout():
	hide_hud()
	$Timer.stop()
