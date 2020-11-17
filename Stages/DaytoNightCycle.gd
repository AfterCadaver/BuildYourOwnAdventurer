extends CanvasModulate

export (Gradient) var day_or_night

onready var time = WhiteBoard.global_time 

func _ready():
	pass
	
func _process(delta):
	
	color = day_or_night.interpolate(time)
	

	
	
