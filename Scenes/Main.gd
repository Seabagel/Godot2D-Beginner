extends Node

export (PackedScene) var enemy_scene
var score = 0

func _ready():
	randomize()

func new_game():
	score = 0
	$HUD.update_score(score)
	
	$StartTimer.start()
	
	$HUD.show_message("Get ready...")
	
	yield($StartTimer, "timeout")
	
	$ScoreTimer.start()
	$SpawnTimer.start()

func game_over():
	$ScoreTimer.stop()

func _on_SpawnTimer_timeout():
	var spawn_location = $EnemyPath/SpawnLocation
	spawn_location.unit_offset = randf()
	
	var enemy = enemy_scene.instance()
	add_child(enemy)
	
	enemy.position = spawn_location.position
	
	var direction = spawn_location.rotation + PI / 2
	direction += rand_range(-PI / 4, PI / 4)
	enemy.rotation = direction
	
	var velocity = Vector2(rand_range(enemy.min_speed, enemy.max_speed), 0)
	enemy.linear_velocity = velocity.rotated(direction)


func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)
	pass # Replace with function body.
