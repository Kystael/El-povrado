extends KinematicBody2D

export var speed = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2()  # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		$AnimatedSprite.flip_h = false
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		$AnimatedSprite.flip_h = true
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		$AnimatedSprite.flip_v = false
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		$AnimatedSprite.flip_v = true
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

	move_and_slide(velocity)
