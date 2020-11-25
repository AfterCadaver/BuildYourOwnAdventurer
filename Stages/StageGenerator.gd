extends Node

var tiles
var points = []



export (Vector2) var map_dimensions

export (NoiseTexture) var noise

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func create_pathway(tilemap: TileMap, points_array:Array, dimensions: Vector2):
	
	var new_points = []
	
	for point in range(points_array.size() -1):
		new_points.append(points_array[point])
		
		for in_between_point in get_in_between_points(points_array[point], points_array[point+1]):
			new_points.append(in_between_point)
		
	for point in new_points:
		
		for a in range(dimensions.x):
			for b in range(dimensions.y):
				tilemap.set_cell(point.x + a, point.y + b, 2)
				
	print(points_array)
				
	tilemap.update_bitmask_region(points_array[0], points_array[-1])

func get_in_between_points(a, b):
	
	#CURRENTLY ABLE TO draw a line  from point a to point b about one pixel thick
	
	var tiles = []
	
	var now_tile = a
	var end_tile = b
	
	var end_direction = (b-a).normalized()
	
	var next_tile = Vector2(round(end_direction.x), round(end_direction.y))
	
	while now_tile != end_tile:
		end_direction = (end_tile-now_tile).normalized()
	
		next_tile = Vector2(round(end_direction.x), round(end_direction.y))
		now_tile += next_tile
		
		print(now_tile)
		tiles.append(now_tile)
		
	
	return tiles

func randomly_add(tilemap:TileMap, number=5):
	
	var this = []
	var hmm = []
	
	for tiles in tilemap.get_used_cells():
		var noise_value = noise.noise.get_noise_2d(tiles.x, tiles.y)
		this.append(tiles)
		
	for i in range(number):
		hmm.append(this[rand_range(0, this.size())])
			
	return hmm



func generate(tilemap: TileMap):
	var that = round(rand_range(0,20))
	
	for x in map_dimensions.x:
		var row = []
		points.append(row)
		
		for y in map_dimensions.y:
			
			var chosen_tile = -1
			
			var noise_value = noise.noise.get_noise_2d(x, y)
			
			if noise_value >= -.2:
				chosen_tile = 0
			
			row.append(calculate_tile_density(x,y))
			
			tilemap.set_cell(x,y, chosen_tile)
			
			if noise_value == 0:
				points.append(Vector2(x,y))
				
	tilemap.update_bitmask_region(Vector2.ZERO, Vector2(500,500))
	
	tilemap.update_dirty_quadrants()
	
func calculate_tile_density(x, y):
	
	var this
	var direct_neighbors = 0
	for r in range(2):
		for j in range(2):
			direct_neighbors += stepify(noise.noise.get_noise_2d(x + j - 1, y + r -1), 1)
			
	return abs(direct_neighbors)
