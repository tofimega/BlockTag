extends Node


func _ready() -> void:
	print(BlockTagParser.parse_bt(FileAccess.open("res://example_nocom.txt", FileAccess.READ).get_as_text()))
