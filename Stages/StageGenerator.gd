extends Node

var tiles
var points = []



export (Vector2) var map_dimensions

export (NoiseTexture) var noise

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func randomly_add(tilemap:TileMap, number=5):
	
	var this = []
	var hmm = []
	
	for tiles in tilemap.get_used_cells():
		var noise_value = noise.noise.get_noise_2d(tiles.x, tiles.y)
		this.append(tiles)
		
	for i in range(number):
		hmm.append(this[rand_range(0, this.size())])
			
	return hmm

func create_river(a, b):
	
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
