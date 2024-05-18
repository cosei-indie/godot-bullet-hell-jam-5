extends Node2D

var base_item_preload = preload("res://scenes/ui/shop/item/item.tscn")
var items = {
	"pickaxe": {
		"icon": "res://scenes/ui/shop/item/resources/pickaxe.tres",
		"price": "15",
		"description": "Double your damage"
	}
}
var healing_items = {
	"small_healing_pot": {
		"icon": "res://scenes/ui/shop/item/resources/small_healing_pot.tres",
		"price": "15",
		"description": "Heal you for a quarter of your life"
	},
	"healing_pot": {
		"icon": "res://scenes/ui/shop/item/resources/small_healing_pot.tres",
		"price": "15",
		"description": "Heal you for half of your life"
	}
}
var shopkeeper_preload = preload("res://scenes/pnj/sprites/sprite_shopkeeper.tscn")
var healer_preload = preload("res://scenes/pnj/sprites/sprite_healer.tscn")
var npc_name

func set_npc(_npc_name):
	if _npc_name == "shopkeeper":
		%CharacterBody2D.add_child(shopkeeper_preload.instantiate())
		fill_shop()
	if _npc_name == "healer":
		%CharacterBody2D.add_child(healer_preload.instantiate())
		fill_healing_shop()
	npc_name = _npc_name
	
func interact():
	%Interact.visible = false
	if npc_name == "shopkeeper":
		%Shop.visible = true
	if npc_name == "healer":
		%HealingShop.visible = true
		
func close_interaction():
	if npc_name == "shopkeeper":
		%Shop.visible = false
	if npc_name == "healer":
		%HealingShop.visible = false
	set_can_interact(true)
	
func set_can_interact(status: bool):
	%Interact.visible = status
	
func _on_character_body_2d_interact_sig() -> void:
	interact()

func _on_character_body_2d_cannot_interact_sig() -> void:
	set_can_interact(false)

func _on_character_body_2d_can_interact_sig() -> void:
	set_can_interact(true)

func _on_character_body_2d_stop_interacting_sig() -> void:
	close_interaction()

	
func fill_healing_shop():
	var item = healing_items["small_healing_pot"]
	var instance = base_item_preload.instantiate()
	instance.set_icon(item.icon)
	instance.set_price(item.price)
	instance.set_label(item.description)
	instance.set_item_name("small_healing_pot")
	
	var item2 = healing_items["healing_pot"]
	var instance2 = base_item_preload.instantiate()
	instance2.set_icon(item2.icon)
	instance2.set_price(item2.price)
	instance2.set_label(item2.description)
	instance2.set_item_name("healing_pot")
	
	%HealingShop.get_node("GridContainer").add_child(instance)
	%HealingShop.get_node("GridContainer").add_child(instance2)
	
func fill_shop():
	add_random_item()
	add_random_item()
	add_random_item()

func add_random_item():
	var size = items.size()
	var random_key = items.keys()[randi() % size]
	var rand_item = items[random_key]
	var instance = base_item_preload.instantiate()
	instance.set_icon(rand_item.icon)
	instance.set_price(rand_item.price)
	instance.set_label(rand_item.description)
	instance.set_item_name(random_key)
	%Shop.get_node("GridContainer").add_child(instance)
