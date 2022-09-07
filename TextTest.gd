extends Node

onready var story := $InkPlayer
onready var output := $Textbox
onready var _choice_selector: ChoiceSelector = $ChoiceSelector

# The timer is to pace the display of text, and also to keep signals from stepping on each other.
var timer := Timer.new()
signal choice_made(target_id)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
# warning-ignore:return_value_discarded
	_choice_selector.connect("choice_made", self, "_on_ChoiceSelector_choice_made")
# warning-ignore:return_value_discarded
	story.connect("InkContinued", self, "_on_story_continued")
# warning-ignore:return_value_discarded
	story.connect("InkChoices", self, "_on_choices")
	add_child(timer)
	timer.autostart = true
	timer.wait_time = 0.5
# warning-ignore:return_value_discarded
	timer.connect("timeout", story, "Continue")
	timer.start()

func _on_story_continued(text, tags) -> void:
	output.text = text
	# We're not using tags in this test case, but here's an output for them in case we need it.
	print(tags)
	timer.start()

func _on_choices(choices) -> void:
	_choice_selector.display(choices)
	
func _on_ChoiceSelector_choice_made(target_id: int) -> void:
	story.ChooseChoiceIndex(target_id)
	emit_signal("choice_made", target_id)
	timer.start()
