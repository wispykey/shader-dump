extends Node

const LEVEL_DIRECTORY = "res://Levels"

@onready var scene_list := $SceneList

func _ready() -> void:
	discover_and_load_all_levels()
	
func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_released("debug_open_scene_switcher"):
		self.visible = !self.visible
		
	
# Note: Assumes that directory is camel case (e.g. 'SomeName'), 
# and the scene file is snake case (e.g. 'some_name')
func discover_and_load_all_levels():
	var dir = DirAccess.open(LEVEL_DIRECTORY)
	
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
				var expected_scene_path = "%s/%s/%s"
				var scene_to_load = expected_scene_path % [LEVEL_DIRECTORY, file_name, convert_camel_case_to_snake_case(file_name) + ".tscn"]
				
				add_button_to_scene_list(file_name, scene_to_load)

			else:
				print("Found file: " + file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path '%s'" % dir)


func add_button_to_scene_list(scene_ref_name: String, scene_file_path: String):
	var button = Button.new()
	# Hard-coded to remove .tscn
	button.text = scene_ref_name
	button.pressed.connect(switch_to_scene.bind(scene_file_path))
	scene_list.add_child(button)
	
	
func switch_to_scene(scene_file_path: String):
	get_tree().change_scene_to_file(scene_file_path)
	self.visible = false


# Note: This will treat all capitals as the beginning of a new word
func convert_camel_case_to_snake_case(s: String) -> String:
	var result := ""

	for i in range(s.length()):
		var c := s[i]

		if c >= "A" and c <= "Z":
			if i > 0:
				result += "_"
			result += c.to_lower()
		else:
			result += c

	return result


	
