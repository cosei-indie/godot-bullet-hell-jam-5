extends Control


var item_name = ""
var icon
	
func set_item_name(_item_name):
	item_name = _item_name
	
func set_icon(path):
	%Button.icon = load(path)
	icon = path
	
func set_label(_label):
	%Label.text = _label

func set_price(_price):
	%RichTextLabel.text = _price
	
func _on_button_mouse_entered() -> void:
	$Label.visible = true

func _on_button_mouse_exited() -> void:
	$Label.visible = false

func _on_button_pressed() -> void:
	if get_tree().get_nodes_in_group("player").size() == 1:
		get_tree().get_nodes_in_group("player")[0].add_item(item_name, icon)
	queue_free()
