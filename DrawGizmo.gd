extends Node2D

@onready var gizmo = $".."
@export var x=200.0
@export var y=50.0
@export var hide_behind_camera:bool = true
@export var line_thickness = -1
var xFudge = 4.52
var yFudge = 4.77
var ratioFudge: float=4.0/3.0

func _ready():
	print(get_viewport().size)
	
func adjustPosition(p: Vector2):
	p.x /= xFudge
	p.y /= yFudge*ratioFudge
	return p

func calcAxisPos(camera,pos,offset):
	return camera.unproject_position(pos+(gizmo.global_transform.basis*offset))

func _draw():
	var camera=get_viewport().get_camera_3d()
	# Don't draw anything when the origin of the gizmo is behind the camera
	if !camera.is_position_behind(gizmo.global_position):
		var screen_origin=camera.unproject_position(gizmo.global_position)
		var p=gizmo.global_position
		var axisx=adjustPosition(calcAxisPos(camera, p, Vector3(1,0,0)))
		var axisy=adjustPosition(calcAxisPos(camera, p, Vector3(0,1,0)))
		var axisz=adjustPosition(calcAxisPos(camera, p, Vector3(0,0,1)))
		
		screen_origin = adjustPosition(screen_origin)
		# Draw axis
		draw_line(screen_origin,axisx, Color.RED, line_thickness)
		draw_line(screen_origin,axisy, Color.GREEN, line_thickness)
		draw_line(screen_origin,axisz, Color.BLUE, line_thickness)
		# Draw circle
		var ellipse_coords=[]
		var rad=5.0
		var ellipse_step=10
		for a in range(0,360+ellipse_step,ellipse_step):
			ellipse_coords.append(Vector2(sin(deg_to_rad(a))*rad*ratioFudge,cos(deg_to_rad(a))*rad)+screen_origin)
		draw_polyline(ellipse_coords, Color.WHITE, line_thickness)
		
func _process(_delta):
	queue_redraw()
	
	
