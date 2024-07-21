extends CharacterBody2D


@export var movement_speed = 50
var player_tracked = false

@export var target: Node2D
@onready var navigation_agent_2d = $NavigationAgent2D

func _ready():
	call_deferred("find_target")
	pass

func _physics_process(delta):
	if target:
		navigation_agent_2d.target_position = target.global_position
	if navigation_agent_2d.is_navigation_finished():
		return
	var curr_rat_position = global_position
	var next_path_position = navigation_agent_2d.get_next_path_position()
	velocity = curr_rat_position.direction_to(next_path_position) * movement_speed
	move_and_slide()
	
func find_target():
	await get_tree().physics_frame
	if target:
		navigation_agent_2d.target_position = target.global_position

func _on_detection_area_body_entered(body):
	player_tracked = true
	print("entered tracking area rat")


func _on_detection_area_body_exited(body):
	print("exit tracking area for rat")
