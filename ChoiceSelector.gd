# I borrowed this script from the excellent GDQuest Visual Novel tutorial (in their 2D Secrets course).
# These functions are now all in the TextTest.gd script, and I've disconnected this file from the ChoiceSelector node, which now functions as a simple VBoxContainer.
# class_name ChoiceSelector
extends VBoxContainer

signal choice_made(target_id)

func display(choices) -> void:
	for choice in choices:
		var choice_index := 0
		var button := Button.new()
		button.text = choice
		choice_index = choices.find(choice,0)
		add_child(button)
# warning-ignore:return_value_discarded
		button.connect("pressed", self, "_on_Button_pressed", [choice_index])
	(get_child(0) as Button).grab_focus()

func _on_Button_pressed(target_id: int) -> void:
	emit_signal("choice_made", target_id)
	_clear()

func _clear() -> void:
	for child in get_children():
		child.queue_free()	
