extends Label

# Increase this number to make it slower (e.g., 0.1 is slow, 0.2 is very slow)
@export var typing_speed: float = 0.15 
@export_enum("Beginner", "Advanced") var difficulty_type: String = "Beginner"

var full_text: String = ""
var current_text: String = ""
var char_index: int = 0
var time_passed: float = 0.0

func _ready() -> void:
	# Set up text and colors
	if difficulty_type == "Beginner":
		full_text = "ENTRY LEVEL (★☆☆)"
		modulate = Color(0.9, 0.9, 0.2) # Yellow-ish
	else:
		full_text = "ADVANCED (★★★)"
		modulate = Color(1, 0.2, 0.2) # Red
	
	text = "" 

func _process(delta: float) -> void:
	if char_index < full_text.length():
		time_passed += delta
		
		# Only add a character when enough time (typing_speed) has passed
		if time_passed >= typing_speed:
			time_passed = 0.0
			current_text += full_text[char_index]
			char_index += 1
			
			# Add a cursor '_' at the end to make it look active
			text = current_text + "_"
	else:
		# Once finished, we can make the cursor blink or just disappear
		text = current_text
