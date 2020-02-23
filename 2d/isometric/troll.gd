extends KinematicBody2D


# This is a demo showing how KinematicBody2D
# move_and_slide works.

# Member variables
const MOTION_SPEED = 400 # Pixels/second
var motion = Vector2.ZERO
const ACCELERATION = .2
const DECCELERATION = .12
var screenSize = OS.get_screen_size()
var windowSize = OS.get_window_size()

func _ready():
	
	#screen centering
	OS.set_window_position(screenSize*.5 - windowSize*.5)
	#Make the window fullscreen 
	OS.window_fullscreen = true

func _physics_process(_delta):

	#horizontal direction
	var xDir = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	#vertical direction
	var yDir = Input.get_action_strength("move_bottom") - Input.get_action_strength("move_up")
	
	#all 8 directional movement normalization
	var directions = Vector2(xDir, yDir*.5).normalized()*MOTION_SPEED
	
	#manage acceleration and deceleration based on inputs feedback. Zero = apply friction else, apply acceleration
	var gradualAcceleration = ACCELERATION if(directions != Vector2.ZERO) else DECCELERATION
	
	#gradual acceleration/deceleration
	motion = lerp(motion, (directions), gradualAcceleration)
	
	motion = move_and_slide(motion)
	

	
func	_unhandled_input(event):	
		var windowNotCentered = OS.window_fullscreen == false
		if(Input.is_action_just_pressed("ui_cancel")):
			OS.window_fullscreen = !OS.window_fullscreen 
			if(windowNotCentered):
				OS.set_window_position(screenSize*.5 - windowSize*.5)
		if(Input.is_action_just_pressed("ui_focus_next")):
			OS.set_window_position(screenSize*.5 - windowSize*.5)
