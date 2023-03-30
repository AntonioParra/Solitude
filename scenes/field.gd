extends Node2D

@onready var tilemap: TileMap = $TileMap
@onready var player: Node2D = $Player

func _ready():
	randomize()
	
	fill_tilemap()
	get_tree().root.connect("size_changed", fill_tilemap)

func _on_player_moving():
	fill_tilemap()

func fill_tilemap():
	var player_position: Vector2 = player.position
	var map_position: Vector2i = tilemap.local_to_map(player_position)
	var visible_size: Vector2 = get_viewport_rect().size
	var visible_tile_size: Vector2 = visible_size / tilemap.tile_set.tile_size.x
	
	var extra = 2
	for i in visible_tile_size.x + extra * 2:
		for j in visible_tile_size.y + extra * 2:
			var rel_map_position = map_position + Vector2i( i - visible_tile_size.x / 2, j - visible_tile_size.y / 2) + Vector2i(-extra, -extra)
			var current_tile = tilemap.get_cell_tile_data(0, rel_map_position)
			if current_tile == null:
				set_cell(rel_map_position)
	
func set_cell(map_position: Vector2i):
	var rand_index: int = randi() % 10
	var tile_index: int = 0
	if rand_index < 5:
		tile_index = 0
	elif rand_index < 8:
		tile_index = 2
	else:
		tile_index = 1
	tilemap.set_cell(0, map_position, tile_index, Vector2i.ZERO)
