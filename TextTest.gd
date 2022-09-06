extends Node

onready var story := $InkPlayer
onready var output := $Textbox
onready var _choice_selector: ChoiceSelector = $ChoiceSelector
var timer := Timer.new()
signal start_story
signal choice_made(target_id)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_choice_selector.connect("choice_made", self, "_on_ChoiceSelector_choice_made")
	add_child(timer)
	timer.autostart = true
	timer.wait_time = 0.5
	timer.connect("timeout", story, "Continue")
	timer.start()
#	emit_signal("start_story")
	
# Alternative approach that also works, before I figured out signals.
#	while story.CanContinue:
#		output.text = (story.Continue())
#		if story.HasChoices:
#			for choice in story.CurrentChoices:
#				selector.text += choice

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func _on_story_continued(text, tags) -> void:
	output.text += text
	print(tags)
	timer.start()

func _on_choices(choices) -> void:
	_choice_selector.display(choices)
	
func _on_ChoiceSelector_choice_made(target_id: int) -> void:
	story.ChooseChoiceIndexAndContinue(target_id)
	emit_signal("choice_made", target_id)

func _on_start_story() -> void:
	story.Continue()
