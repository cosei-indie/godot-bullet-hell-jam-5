extends CollisionShape2D

signal interact_sig

func interact():
	emit_signal("interact_sig")
