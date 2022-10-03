extends Node

onready var story := $InkPlayer
onready var output := $Scrollbox
onready var score := $Scorebox
onready var _choice_selector := $ChoiceSelector
var timer := Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
# warning-ignore:return_value_discarded
	story.connect("InkContinued", self, "_on_story_continued")
# warning-ignore:return_value_discarded
	story.connect("InkChoices", self, "_on_choices")

# Let's observe a variable in the ink story, and report it in a score window.
# warning-ignore:return_value_discarded
	story.connect(story.ObserveVariable("distrust"), self, "_score_update")
	print(story.get_GlobalTags())

# The timer paces the display of text, and keeps signals from stepping on each other.
	add_child(timer)
	timer.autostart = true
	timer.wait_time = 0.1
# warning-ignore:return_value_discarded
	timer.connect("timeout", story, "Continue")
	timer.start()

func _on_story_continued(text, tag_array) -> void:
	for tag in tag_array:
		print(tag)
		if tag == "CLEAR":
			output.text = ""
		# Experimenting with ways to extract commands from tags and execute them.
		if "test_function" in tag:
			# Split the tag into an array of the space-separated words in it.
			var command_array = tag.split(" ", true, 0)
			# Call the first item in the array (i.e. the first word in the tag) as a function, 
			# and send the entire tag an array of args to it.
			self.call(command_array[0],command_array)
	output.text += text
	timer.start()

# Test function for the commands extracted from the tags above.
func test_function(args) -> void:
	print("This is the test.")
	for command in args:
		print(command)

func _on_choices(choices) -> void:
	for choice in choices:
		var choice_index := 0
		var button := Button.new()
		button.text = choice
		choice_index = choices.find(choice,0)
		_choice_selector.add_child(button)
# warning-ignore:return_value_discarded
		button.connect("pressed", self, "_on_Button_pressed", [choice_index])
	(_choice_selector.get_child(0) as Button).grab_focus()

func _score_update(varName, varValue) -> void:
	var score_report : String = "Distrust is now " + String(varValue)
	score.text = score_report
	print(varName, " is now ", varValue)
	
func _on_Button_pressed(target_id) -> void:
	story.ChooseChoiceIndex(target_id)
	for child in _choice_selector.get_children():
		child.queue_free()
	timer.start()

