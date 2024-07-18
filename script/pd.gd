extends CharacterBody2D


const SPEED = 100.0
var curr_dirr ="none"

func _ready():
	$AnimatedSprite2D.play("idle")

func _physics_process(delta):
	player_movement(delta)

func player_movement(delta):
	if Input.is_action_pressed("Right"):
		curr_dirr="right"
		play_anim(0)
		velocity.x=SPEED
		velocity.y=0
	elif Input.is_action_pressed("Left"):
		curr_dirr="left"
		play_anim(0)
		velocity.x=-SPEED
		velocity.y=0
	elif Input.is_action_pressed("Up"):
		play_anim(0)
		velocity.x=0
		velocity.y=-SPEED
	elif Input.is_action_pressed("Down"):
		play_anim(0)
		velocity.x=0
		velocity.y=SPEED
	else:
		play_anim(1)
		velocity.x=0
		velocity.y=0
		
	move_and_slide()
	
func play_anim(mode):
	var dir=curr_dirr	
	var anim = $AnimatedSprite2D
	
	if dir=="right":
		anim.flip_h=false
		if mode==0:
			anim.play("moveRight")
		elif mode==1:
			anim.play("idle")
	else:
		anim.flip_h=true
		if mode==0:
			anim.play("moveRight")
		elif mode==1:
			anim.play("idle")
