extends Control

var shop = preload("res://scenes/ui/shop/shop.tscn")

#func _ready():
	#instantiate_shop()
	
func instantiate_shop(_global_position: Vector2):
	print(_global_position)
	var instance = shop.instantiate()
	add_child(instance)
	instance.global_position = _global_position
