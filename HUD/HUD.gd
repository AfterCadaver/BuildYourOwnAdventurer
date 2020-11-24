extends CanvasLayer

onready var BB = get_node("../BlackBoard")

func _ready():
	$Tween.interpolate_property($Label2, 
								"modulate",
								Color(1, 1, 1, 1),
								Color(1, 1, 1, 0),
								1.5,
								5,
								2)
								
	$Tween.start()
	
func pause_game():
	$Desaturate.visible = !$Desaturate.visible

func set_props_to_clickable():
	for prop in get_tree().get_nodes_in_group("clickable"):
		prop.connect("update_hud", self, "display_hud")


func _process(delta):
	
	if Input.is_action_just_pressed("ui_cancel"):
		pause_game()
	
	#Continually Recalculate and display time
	#the below doesn't work yet
	var time_name = "Evening"
	
	var time_now = BB.get("time")
	
	if time_now <= 0.49:
		time_name = "Morning"
	elif time_now >= 0.5 and time_now <= 0.7:
		time_name = "Midday"
		
	elif time_now >= 0.5 and time_now <= 0.7:
		time_name = "Evening"
	else:
		time_name = "Night"
	
	$Label.set_text("TIME: %s" % time_name)
	

		
func display_hud(prop):
	
	#Use a tween node to roll out the Flavortext display
	#Reminder: Change function name
	$Tween.interpolate_property($TextureRect,
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
	$Tween.interpolate_property($TextureRect,
								"rect_position",
								null,
								Vector2(-182, 0),
								.5,
								Tween.TRANS_QUINT,
								Tween.EASE_OUT)
								
	$Tween.start()
	
func display_flavor_text(prop):
	
	#Actually display the flavortext
	#Change name to update Flavor Text

	$TextureRect/TextureRect.texture = prop.flavor_text.picture
	$TextureRect/RichTextLabel.text = prop.flavor_text.description
	$TextureRect/Label.text = prop.flavor_text.name
	
func _on_Timer_timeout():
	hide_hud()
	$Timer.stop()


func _on_ShoworHide_pressed():
	hide_hud()


func _on_Button_pressed():
	$ColorRect.visible = true
