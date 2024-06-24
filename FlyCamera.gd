extends Camera3D

@export var mouse_sensivity: float = 0.001
@export var move_speed: float = 2.0
@export var capture_mouse:bool = false

func _ready():
	if capture_mouse:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _process(delta):

	if Input.is_action_just_pressed("toggle_mouse"):
		capture_mouse = !capture_mouse
		if capture_mouse:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		else:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

	if Input.is_action_just_pressed("toggle_fullscreen"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
				
	if Input.is_action_pressed("camera_left"):
		#rotation += global_transform.basis.y*delta
		position -= global_transform.basis.x*delta*move_speed
	if Input.is_action_pressed("camera_right"):
		#rotation -= global_transform.basis.y*delta
		position += global_transform.basis.x*delta*move_speed

	if Input.is_action_pressed("camera_forward"):
		position -= global_transform.basis.z*delta*move_speed
	if Input.is_action_pressed("camera_back"):
		position += global_transform.basis.z*delta*move_speed

	if Input.is_action_pressed("camera_up"):
		position += global_transform.basis.y*delta*move_speed
	if Input.is_action_pressed("camera_down"):
		position -= global_transform.basis.y*delta*move_speed
		

func _input(event):
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x * mouse_sensivity
		rotation.x -= event.relative.y * mouse_sensivity
