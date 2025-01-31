extends CharacterBody2D

var speed = 140
var player_chase = false
var player = null

var health = 3
var player_inattack_zone = false

func _physics_process(delta):
	deal_damage()
	
	if player_chase:
		position += (player.position - position)/speed
		
		$AnimatedSprite2D.play("walk")
		
		if(player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
		
	else:
		$AnimatedSprite2D.play("idle")

func _on_detection_area_body_entered(body: Node2D):
	player = body
	player_chase = true

func _on_detection_area_body_exited(body: Node2D):
	player = null
	player_chase = false

func enemy():
	pass

func _on_hitbox_body_entered(body):
	if body.has_method("player"):
		player_inattack_zone = true

func _on_hitbox_body_exited(body):
	if body.has_method("player"):
		player_inattack_zone = false

func deal_damage():
	if player_inattack_zone and global.player_current_attack == true:
		health = health - 1
		
		if health <= 0:
			self.queue_free()
