extends CharacterBody2D


signal interact_sig
signal can_interact_sig
signal cannot_interact_sig
signal stop_interacting_sig

func interact():
	emit_signal("interact_sig")

func can_interact():
	emit_signal("can_interact_sig")
	
func cannot_interact():
	emit_signal("cannot_interact_sig")
	
func stop_interacting():
	emit_signal("stop_interacting_sig")
