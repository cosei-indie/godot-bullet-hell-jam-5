extends Node2D

var speed := 100
var steering_factor := 40

var desired_velocity := Vector2(0, 0)

#is_interacting
var is_interacting = false
var interacting_with = null


func _process(delta: float) -> void:
	movements(delta)
	

func movements(delta):
	var direction := Vector2(0,0)
	direction.x = Input.get_axis("left", "right")
	direction.y = Input.get_axis("up", "down")
	if direction.length() < 1.0:
		%AnimationPlayer.play("idle")
		direction = direction.normalized()
		return
			
	desired_velocity = speed * direction
	#%MovingObject.position += desired_velocity * delta
	%MovingObject.move_and_collide(desired_velocity * delta)
	
	%AnimationPlayer.play("move")
	#if (desired_velocity.angle() > PI/2 || desired_velocity.angle() < -PI/2):
		#if %MovingObject.scale.x > 0:
			#%MovingObject.scale.x = %MovingObject.scale.x * -1
	#else:
		#if %MovingObject.scale.x < 0:
			#%MovingObject.scale.x = %MovingObject.scale.x * -1
			
func _input(event):
	if event.is_action_pressed("interact"):
		var bodies = %InteractingRange.get_overlapping_bodies()
		if is_interacting:
			stop_interacting()
		else:
			for body in bodies:
				if body.has_method("interact"):
					body.interact()
					is_interacting = true
					interacting_with = body
					break
		
	if event.is_action_pressed("escape"):
		if is_interacting:
			stop_interacting()
		

func stop_interacting():
	is_interacting = false
	interacting_with.stop_interacting()


func _on_interacting_range_body_entered(body: Node2D) -> void:
	if body.has_method("can_interact"):
		body.can_interact()
		

func _on_interacting_range_body_exited(body: Node2D) -> void:
	if body.has_method("cannot_interact"):
		if is_interacting:
			stop_interacting()
		body.cannot_interact()
		
func add_item(item_name, texture):
	match item_name:
		'pickaxe':
			create_item(texture)
			
		
func create_item(texture):
		var text_rect = TextureRect.new()
		var _texture = load(texture)
		if _texture:
			text_rect.expand_mode = TextureRect.EXPAND_FIT_WIDTH
			text_rect.texture = _texture
			%InventoryContainer.add_child(text_rect)
