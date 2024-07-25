extends CharacterBody2D

@export var speed = 100.0
var breadcrumb = preload("res://scenes/player_breadcrumb.tscn")

var screen_size
var idle = false
var idle_animation = false

# Control currently added
# Up Down Left Right Attack(Left Mouse)
func _ready():
	screen_size = get_viewport_rect().size

# Maybe make this into physics process later
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("Right"):
		velocity.x += 1
	if Input.is_action_pressed("Left"):
		velocity.x -= 1
	if Input.is_action_pressed("Down"):
		velocity.y += 1
	if Input.is_action_pressed("Up"):
		velocity.y -= 1
		
	if velocity.length() == 0:
		if not idle:
			$AnimatedSprite2D.stop()
			idle = true
			#print("idle")
			$IdleTimer.start(2)
	
	if idle_animation:
		$AnimatedSprite2D.play("idle")

	if velocity.length() > 0:
		idle = false
		idle_animation = false
		$IdleTimer.stop()
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x != 0 or velocity.y != 0:
		$AnimatedSprite2D.animation = "moveRight"
		$AnimatedSprite2D.flip_v = false
		# See the note below about boolean assignment.
		$AnimatedSprite2D.flip_h = velocity.x < 0
		
func _input(event):
	if event.is_action_pressed("Cloak"):
		spawn_breadcrumb()

func spawn_breadcrumb():
	print("player cloaked")
	var last_position = breadcrumb.instantiate()
	last_position.global_position = global_position
	#var bread_node = get_tree().get_first_node_in_group("p_breadcrumb")
	#bread_node.add_child(last_position)
	var world_node = get_parent()
	if world_node:
		world_node.add_child(last_position)

func _on_idle_timer_timeout():
	#print("play idle animation")
	idle_animation = true

func _on_rat_2d_player_escaped_los():
	spawn_breadcrumb()
