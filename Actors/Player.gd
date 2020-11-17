extends "res://Actors/Actor.gd"


class_name Player

export var able_to_pathfind = false
export var able_to_play = true

var path = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("players")
	WhiteBoard.player = self

	#TESTING AREA FOR BEHAVIOR TREE
	
	BB.set("player", self)
	BB.set("player_position", self.position)

func avoid_mob_group():
	
	#In the future, measure this by individual squads of mobs not all mobs
	var sum_mob_postion = Vector2.ZERO
	var mob_number = 0
	var mean_mob_position = Vector2.ZERO
	
	for mob in get_tree().get_nodes_in_group("enemies"):
		mob_number += 1
		sum_mob_postion += mob.global_position

		
	mean_mob_position = sum_mob_postion/ mob_number
	
	
	
	direction = (global_position - mean_mob_position).normalized()
	
	
func _process(delta):
	$TextureProgress.texture_progress
	$BehaviorTree.tick(self, BB)

	
	
