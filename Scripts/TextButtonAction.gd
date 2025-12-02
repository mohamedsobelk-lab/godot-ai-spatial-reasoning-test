extends TextureButton

onready var label = $Label1         # Change to your actual label name
onready var row = get_parent()      # The HBoxContainer / VBoxContainer above this button

func _ready():
	# Debug (optional)
	print("Label:", label, " Class:", label.get_class())
	print("Row:", row, " Class:", row.get_class())

	# Important: connect the Label's resized signal
	if label:
		label.connect("resized", self, "_on_label_resized")
	
	# Run once at start
	_on_label_resized()

func _on_label_resized():
	# Update the button layout
	call_deferred("minimum_size_changed")

	# Update the container layout
	if row and row is Control:
		row.call_deferred("minimum_size_changed")
		row.call_deferred("queue_sort")

#
# -------- CRITICAL PART FOR GODOT 3.x --------
# Makes TextureButton expand vertically to match the label’s height.
#
func get_minimum_size():
	var size = .get_minimum_size()

	if label:
		# Ensure height grows to label’s current height
		size.y = max(size.y, label.rect_size.y)

	return size
