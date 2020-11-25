extends "res://Actors/Actor.gd"


class_name Player

export var able_to_pathfind = false
export var able_to_play = true

var path = Vector2.ZERO
var trees = []

var wood = 0

signal chop()

#CHANGE ALL REFERENCES TO ENEMIES TO MOBS
var priority = "mobs"

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("players")
	WhiteBoard.player = self

	#TESTING AREA FOR BEHAVIOR TREE
	
	BB.set("player", self)
	BB.set("player_position", self.position)

func _unhandled_input(event):
	if event.is_pressed():
		if  event.button_index == BUTTON_WHEEL_DOWN:
			$Camera2D.zoom += Vector2(.1,.1)
		elif event.button_index == BUTTON_WHEEL_UP:
			$Camera2D.zoom -= Vector2(.1,.1)
func reach_priority(priority:String):
	
	speed = max_speed
	var closest_enemy
	
	var enemies_distances = []
	
	var closest_distance = 100000
	
	for enemy in BB.get(priority):
		
		if enemy == null:
			continue
		
		if self.position.distance_to(enemy.position) < closest_distance:
			closest_enemy = enemy
			closest_distance = self.position.distance_to(enemy.position)
	
	target = closest_enemy
	var dir = position.direction_to(target.position).normalized()
	
	direction = dir
		

func avoid_mob_group():
	
	#In the future, measure this by individual squads of mobs not all mobs
	var sum_mob_postion = Vector2.ZERO
	var mob_number = 1
	var mean_mob_position = Vector2.ZERO
	
	for mob in get_tree().get_nodes_in_group("enemies"):
		
		if is_instance_valid(mob):
			continue
		else:
			mob_number += 1
			sum_mob_postion += mob.global_position

		
	mean_mob_position = sum_mob_postion/ mob_number
	
	direction = -global_position.direction_to(mean_mob_position).normalized()
	
func chop_tree():
	print("Player Chopped tree!")
	emit_signal("chop")
	
func add_to_inventory(item_name):
	var item = load("res://Stages/Items/%s.tres" % item_name)
	inventory.items.append(item)
	print(inventory.items)
	
func _process(delta):
	$TextureProgress.texture_progress
	$BehaviorTree.tick(self, BB)
	if direction != Vector2.ZERO:
		$AnimationPlayer.play("walk_left")
		
	trees = $Area2D.get_overlapping_bodies()
	
	if BB.get("time") >= 0.7:
		$Light2D2.enabled = true
	
	
