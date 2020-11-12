extends KinematicBody2D

class_name Actor

export (Resource) var save_file
export (Resource) var inventory
export (Resource) var flavor_text
export (float, 200)var speed = 30





export var shoot_arrows = true

var fire_time = 0.0
var FIRE_RATE = .75

var fsm = FiniteStateMachine.new()
var goap = GOAP.new()

onready var target = self

var direction
# Called when the node enters the scene tree for the first time.

signal update_hud(actor)
signal shoot(actor, target)


func _ready():
	
	#INCLUDES ACTORS IN LIST OF PICKABLE NODES
	add_to_group("clickable")
	#ALLOWS ACTORS TO BE ACCESIBLE
	#IMPORTANT FOR CERTAIN FUNCTIONS
	add_to_group("actors")

	for item in inventory.items:
		if !item == null:
			#flavor_text.abilities.insert(item.name, "\n")
			pass
			

func behavior():
	#THE FUNCTION WHOSE PURPOSE IS TO CALL THE DIFFERENT BEHAVIORS OF THE ACTOR
	for item in inventory.items:
		#ITERATE THRU ITEMS IN INVENTORY
		if !item == null:
			#IF THE ITEM EXISTS
			if "priority" in item.name:
				#CHECK IF THE ITEM NAME CONTAINS THIS KEYWORD
				#THIS IS TO IDENTIFY IT AS A PRIORITY SETTING BEHAVIOR
				search_for_priority(item.name.lstrip("priority_"))
			elif "sense" in item.name:
				#THIS DOES THE SAME, BUT WITH SENSED OBJECTS
				set_state(item.name.lstrip("sense_"))
			else:
				#ALL OTHER BEHAVIORS ARE CALLED HERE
				self.call(item.name)

func search_for_priority(priority:String):
	
	for enemy in get_tree().get_nodes_in_group(priority):
			target = enemy
			
			
	self.rotation = get_angle_to(target.global_position)
	
func set_state(objects:String):
	#THIS IS TO TRIGGER THE ENTRANCE INTO A NEW STATE
	pass
	
func arrow_attack():
	pass

func sword_attack():
	pass

func control_movement():
	var x = -int(Input.is_action_pressed("ui_left")) + int(Input.is_action_pressed("ui_right"))
	var y = -int(Input.is_action_pressed("ui_up")) + int(Input.is_action_pressed("ui_down"))
	direction = move_and_slide(Vector2(x,y) * speed)
	
	
func attraction_movement():
	var target_direction = (target.global_position - self.global_position).normalized()
	direction = move_and_slide(target_direction * speed)

	
func _physics_process(delta):
	self.behavior()
	
	if shoot_arrows:
	
		self.shoot()
	
func shoot():
	if get_time() - fire_time < FIRE_RATE:
		return
	fire_time = get_time()
	emit_signal("shoot", self, target)
	
func get_time():
	return OS.get_ticks_msec() / 1000.0

func _on_Actor_input_event(viewport, event, shape_idx):
	
	if event is InputEventMouseButton:
		emit_signal("update_hud", self)


func _on_Area2D_body_entered(body):
	if body:
		move_and_slide(position - body.position)
