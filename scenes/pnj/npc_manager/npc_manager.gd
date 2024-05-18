extends Node2D

var npc_base = preload("res://scenes/pnj/npc.tscn")

func _ready():
	var shopkeeper = npc_base.instantiate()
	shopkeeper.set_npc("shopkeeper")
	shopkeeper.position = random_position()
	add_child(shopkeeper)
	
	var healer = npc_base.instantiate()
	healer.set_npc("healer")
	healer.position = random_position()
	add_child(healer)

func random_position():
	var center_position = Vector2(0, 0)
	var random_angle = randi_range(0, 2 * PI)
	var random_radius = randi_range(0, 50)
	var random_x = center_position.x + random_radius * cos(random_angle)
	var random_y = center_position.y + random_radius * sin(random_angle)
	return Vector2(random_x, random_y)
