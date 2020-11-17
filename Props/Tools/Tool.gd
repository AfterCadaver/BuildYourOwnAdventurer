extends KinematicBody2D

export var speed = 0

func _ready():
	speed *= WhiteBoard.world_speed

func slow_motion(slowdown:=false):
	speed -= (speed * .5 * int(slowdown) )
