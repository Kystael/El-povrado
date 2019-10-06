extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const MAX_SPEED = 300
const MAX_STEER = 0.05
const MIN_DIST_TO_STEER = 10

var speed = Vector2()
onready var target_pos = get_position()
var target = false
var fleeing = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _physics_process(delta):
	target_pos = get_global_mouse_position()
	var distance = target_pos - get_position()
	
	if distance.length() < MIN_DIST_TO_STEER and not fleeing:
		var frame_max_distance = MAX_SPEED * delta
		if distance.length_squared() > frame_max_distance * frame_max_distance:
			distance = distance.normalized() * frame_max_distance
		move_and_collide(distance)
	else:
		speed = steer(distance)
		move_and_collide(speed * delta)


func steer(distance : Vector2) -> Vector2:
	var v = distance.normalized() * MAX_SPEED
	var desired_speed = Vector2(v.x, v.y)
	if fleeing:
		desired_speed *= -1
	var steer = desired_speed - speed
	var steered_speed = speed + steer * MAX_STEER
	return steered_speed


func ia_main(delta):
	if target:
		ia_chase_target(delta, target)
	else:
		ia_do_rounds(delta)


func ia_chase_target(delta, target):
	target_pos = target.get_position()
	pass


func ia_do_rounds(delta):
	if on_round_point():
		target_pos = get_next_round_point()
	pass


func on_round_point():
	pass


func get_next_round_point():
	pass
	