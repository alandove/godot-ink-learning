# I haven't quite gotten the loop-based approach working yet, but this is how far I got before abandoning it for the signal-based approach. Currently the choices iterate infinitely, and I don't know why.

extends Node

onready var story := $InkPlayer
onready var output := $Textbox
onready var choice_output := $Textbox/Choicebox
var timer := Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(timer)
	timer.autostart = true
	timer.wait_time = 0.5
# warning-ignore:return_value_discarded
	timer.connect("timeout", story, "Continue")
	timer.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	while story.get_CanContinue():
		output.text = story.Continue()
	if story.get_HasChoices():
		var choices : Array = story.get_CurrentChoices()
		var choice_count := choices.size()
		print(choices.size())
		for choice in choices:
			var choice_index := 0
			var button := Button.new()
			button.text = choice
			choice_index = choices.find(choice,0)
			choice_output.add_child(button)
