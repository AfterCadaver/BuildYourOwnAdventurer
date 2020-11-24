extends CanvasModulate

export (Gradient) var day_or_night

onready var BB = get_node("../BlackBoard")

func _ready():
	pass
	
func _process(delta):
	
	color = day_or_night.interpolate(BB.get("time"))
	

	
	
