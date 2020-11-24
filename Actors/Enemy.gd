extends "res://Actors/Actor.gd"

class_name Enemy

var sleeping = true

func _ready():
	target = BB.get("player")
	add_to_group("enemies")
	
func swarm():
	#IMPLEMENT BOIDS ALGORTITHM HERE
	var sum_mob_postion = Vector2.ZERO
	var mob_number = 0
	var mean_mob_position = Vector2.ZERO
	
	var c = Vector2.ZERO
	var percieved_velocity = Vector2.ZERO
	
	for mob in get_tree().get_nodes_in_group("enemies"):
		if mob != self and mob != null:
			sum_mob_postion += mob.global_position
			mob_number += 1
			
			
			percieved_velocity += mob.direction
			
			if self.position.distance_to(mob.position) <= 100:
				c -= (mob.position - self.position)
				
				
	percieved_velocity /= mob_number
				
	mean_mob_position = sum_mob_postion/ mob_number
	

	var a = position.direction_to(mean_mob_position).normalized()
	
	direction += c.normalized() * 2 + a


"""
	
	PROCEDURE rule3(boid bJ)

		Vector pvJ

		FOR EACH BOID b
			IF b != bJ THEN
				pvJ = pvJ + b.velocity
			END IF
		END

		pvJ = pvJ / N-1

		RETURN (pvJ - bJ.velocity) / 8

	END PROCEDURE
	
"""
	
func _process(delta):
	$BehaviorTree.tick(self, BB)
	
func sleep():
	self.modulate = Color.blue


func _on_Enemy_tree_exiting():
	
	#This is a Duct Tape Solution
	#come back to this later
	#must focus on important testing
	var array = BB.get("enemies")
	var index = 0
	for i in array:
		index += 1
		if i == self:
			array.remove(index)
