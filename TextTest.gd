extends Node

onready var story := $InkPlayer
onready var output := $Textbox
onready var selector := $Choicebox
signal start_story

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	emit_signal("start_story")
	pass
	
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
	output.text = text
	print(tags)

func _on_choices(choices) -> void:
	for choice in choices:
		selector.text += choice

func _on_start_story() -> void:
	story.Continue()
