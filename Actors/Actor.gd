extends KinematicBody2D

class_name Actor

export (Resource) var save_file
export (Resource) var inventory
export (Resource) var flavor_text

export (int) var max_speed = 100
export (float, 1, 700, 1)var speed = 30

export (float, 200) var running_speed = 60

onready var slow_mo_speed = speed / 2

export (int, 1, 500) var health_points = 1
onready var current_health = health_points

var arrow_number = 10

export var shoot_arrows = false

var fire_time = 0.0
var FIRE_RATE = 0.1

onready var BB = get_node("../BlackBoard")
var goap = GOAP.new()

onready var target = self

var direction = Vector2.ZERO
# Called when the node enters the scene tree for the first time.

signal update_hud(actor)
signal shoot(actor, target)


func _ready():
		
	if inventory == null:
		push_error("Actors should have Inventories.")
	
	$Label.set_text(self.name)
	

	
	#INCLUDES ACTORS IN LIST OF PICKABLE NODES
	add_to_group("clickable")
	#ALLOWS ACTORS TO BE ACCESIBLE
	#IMPORTANT FOR CERTAIN FUNCTIONS
	add_to_group("actors")
	#THE SAME GROUP AS TOOLS SO THAT BOTH TOOLS AND ACTORS
	#WILL BE AFFECTED BY SLOWDOWN
	add_to_group("moving objects")
	
	if inventory != null:
		for item in inventory.items:
			if !item == null:
				#flavor_text.abilities.insert(item.name, "\n")
				pass
			
	$AnimationPlayer.playback_speed = WhiteBoard.world_speed
	speed *= WhiteBoard.world_speed


func _draw():
	if $Label.visible == true:
		draw_arc(Vector2.ZERO, $Sprite.texture.get_width(), 0, 3.14, 1, Color.white)

func slow_motion(slowdown:=false):
	$AnimationPlayer.playback_speed -= (.5 * int(slowdown))
	speed -= (speed * .5 * int(slowdown)) 

func behavior():
	#THE FUNCTION WHOSE PURPOSE IS TO CALL THE DIFFERENT BEHAVIORS OF THE ACTOR
	"""
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
				#set_state(item.name.lstrip("sense_"))
				pass
			else:
				#ALL OTHER BEHAVIORS ARE CALLED HERE
				self.call(item.name)
				"""
	pass

func search_for_priority(priority:String):
	
	for enemy in get_tree().get_nodes_in_group(priority):
			target = enemy
			
	
func arrow_attack():
	pass

func sword_attack():
	pass

func control_movement():
	var x = -int(Input.is_action_pressed("ui_left")) + int(Input.is_action_pressed("ui_right"))
	var y = -int(Input.is_action_pressed("ui_up")) + int(Input.is_action_pressed("ui_down"))
	direction = Vector2(x,y)
	
	
func attraction_movement():
	if target != null:
		var target_direction = (target.global_position - self.global_position).normalized()
		direction = target_direction

	
func _physics_process(delta):
	self.behavior()
	
	$TextureProgress.value = (current_health / health_points) * 100
	
	move_and_slide(direction * speed)
	
	if shoot_arrows and arrow_number > 0:
	
		self.shoot_arrows()
		
	if current_health <= 0:
		queue_free()
	
func shoot_arrows():
	if get_time() - fire_time < FIRE_RATE:
		return
	fire_time = get_time()
	
	if arrow_number >0 and is_instance_valid(target):
		arrow_number -= 1
		emit_signal("shoot", self, target)
	
func swing():
	pass
	
func get_time():
	return OS.get_ticks_msec() / 1000.0

func _on_Actor_input_event(_viewport, event, _shape_idx):
	
	if event is InputEventMouseButton:
		emit_signal("update_hud", self)

func _on_Area2D_body_entered(body):
	current_health -= 1
	$AnimationPlayer2.play("damaged")

func _on_Actor_mouse_entered():
	$Label.visible = true


func _on_Actor_mouse_exited():
	$Label.visible = false
