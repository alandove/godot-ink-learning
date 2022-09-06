# Godot-Ink Integration Notes

For some reason Paul has stripped down the documentation on his
[Github](https://github.com/paulloz/godot-ink "wikilink") repo, but
[this](https://freesoft.dev/program/117139627 "wikilink") page-scraped
version has the GDScript usage notes.

In case that page evaporates, here are my snippets from it, and
additional notes as I take another run at learning this setup.

## Initial setup

Create a new Godot project.

Install Ink from the AssetLib tab.

Copy `ink-engine-runtime.dll` and the `inklecate` executable into the
project's root folder.

To create a `.csproj` file, create a main node and attach a C# script to
it.

Open the new `.csproj` file (which won't show up in the Godot
FileSystem tab) in a text editor and insert this block:

```
<ItemGroup>
    <Reference Include="Ink">
    <HintPath>$(ProjectDir)/ink-engine-runtime.dll</HintPath>
    <Private>False</Private>
    </Reference>
</ItemGroup>
```

Be sure to move the `</Project>` tag from the initial block
Godot made to the end of that inserted block.

Click "Build" in the upper right corner of the Godot editor window.

Go to Project > Project Settings, choose the "Plugins" tab, and
enable ink.

Go to Project > Project Settings, choose the "General" tab, scroll
all the way down to Ink, and set the Inklecate Path to point to the
local copy of the executable.

## Basic usage

In the Add Node menu, create an InkPlayer node. You can rename it, but for these examples we'll continue calling it InkPlayer.

## GDScript usage: loops

This is adapted from the scraper page, which was mostly correct.

To get text, call the `.Continue()` method:

```
onready var story = $InkPlayer
...

while story.CanContinue:
    print(story.Continue())
    # Alternatively, text can be accessed from story.CurrentText
```
Choices come from the `.ChooseChoiceIndex(int)` method:

```
if story.HasChoices:
    for choice in story.CurrentChoices:
        print(choice)
    ...
    story.ChooseChoiceIndex(index)
```

## GDScript usage: signals

This is a more Godot-like way of doing things, but it requires inserting some pauses with a timer, as I've now done in the `TextTest.gd` script.

```
    ...
    story.connect("InkContinued", self, "_on_story_continued")
    story.connect("InkChoices", self, "_on_choices")

func _on_story_continued(currentText, currentTags):
    print(currentText)

func _on_choices(currentChoices):
    for choice in choices:
        print(choice)
```

Obviously in a real game, one would use something like a `Label` for text and `Button`s for choices, and set `label.text` and `button.text` to the outputs.

To save and load from disk, use the `.SaveStateOnDisk` and
`.LoadStateFromDisk` methods:

```
story.SaveStateOnDisk("save.json")
story.LoadStateFromDisk("save.json")

...

var file = File.new()
file.open("save.json", File.WRITE)
story.SaveStateOnDisk(file)
file.close


file.open("save.json", File.READ)
story.LoadStateFromDisk(file)
file.close
```

Get tags from `.CurrentTags`, `.GlobalTags`, and
`.TagsForContentAtPath(String)`:

```
print(story.CurrentTags)
print(story.GlobalTags)
print(story.TagsForContentAtPath("mycoolknot"))
```

Jump to a specific knot and stitch with `.ChoosePathString(String)`,
which returns `false` if the jump fails:

```
if story.ChoosePathString("mycoolknot.myradstitch"):
    story.Continue()
```

Access Ink variables with `.GetVariable` and `.SetVariable`:

```
story.GetVariable("foo")
story.SetVariable("foo", "bar")
```

and observe them with signals if you like:

```
...
    story.connect(story.ObserveVariable("foo"), self, "_foo_observer")

func _foo_observer(varName, varValue):
    print(varName, " = ", varValue)
```

Read count for a knot/stitch is readable with
`.VisitCountPathString(String)`:

```
print(story.VisitCountPathString("mycoolknot.myradstitch"))
```

## General Architecture Notes

Ink itself just feeds whatever text and tags it has to the engine, so I
can use any tags I like for designating speakers, directing sprite
positioning, setting and changing expressions, setting backgrounds, and
so forth. I just need to include functions to handle those tags in my
scripts.
