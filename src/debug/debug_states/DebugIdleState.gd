extends State

class_name DebugIdleState

func _on_enter():
#	print("On Enter Idle")
	Transitioned.emit(self, "NotIdleAnymore")

func _on_exit():
#	print("On Exit Idle")
	pass
