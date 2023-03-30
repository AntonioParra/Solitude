extends Node2D

@onready
var tilemap: TileMap = $TileMap

func _ready():
	randomize()

func _on_player_moving(player):
	var player_position: Vector2 = player.position
	var map_position: Vector2i = tilemap.local_to_map(player_position)
	
	var current_tile = tilemap.get_cell_tile_data(0, map_position)
	if current_tile == null:
		set_cell(map_position)
		
func set_cell(map_position: Vector2i):
	var rand_index: int = randi() % 10
	var tile_index: int = 0
	if rand_index < 5:
		tile_index = 0
	elif rand_index < 8:
		tile_index = 1
	else:
		tile_index = 2
	tilemap.set_cell(tile_index, map_position, 0, Vector2i.ZERO)
