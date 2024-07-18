extends CharacterBody2D


var speed = 50
var player_tracked = false

@export var player: Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D

#func _physics_process(_delta: float):
	#var dir = to_local(nav_agent.get_next_path_position().normalized())
	#velocity = dir * speed
	#move_and_slide()
	#
	#if velocity.x != 0 or velocity.y != 0:
		#$AnimatedSprite2D.play("running_right")
		#if velocity.x < 0:
			#$AnimatedSprite2D.play("running_left")
	#
#func path():
	#nav_agent.target_position = player.global_position

func _on_detection_area_body_entered(body):
	player_tracked = true
	print("entered tracking area rat")


func _on_detection_area_body_exited(body):
	print("exit tracking area for rat")
