extends TileMap

var positions := []


func process(objeckt: Objeckt, dir: Vector2, push := Vector2.ZERO) -> bool:
	objeckt.processed = true
	var move = objeckt.move(dir)
	if move == Vector2.ZERO and push != Vector2.ZERO:
		move = objeckt.push(push)
	if get_cellv(objeckt.tile+move) != -1:
		return false
	objeckt.tile += move
	for child in get_children():
		child = child as Objeckt
		if not child.processed and objeckt.tile == child.tile and child.collision:
			if not process(child, dir, move):
				objeckt.tile -= move
				return false
	for child in get_children():
		child = child as Objeckt
		if objeckt != child and objeckt.tile == child.tile and child.collision:
			objeckt.tile -= move
			return false
	objeckt.last_move = move
	return true


func move(dir: Vector2) -> void:
	for objeckt in get_children():
		objeckt = objeckt as Objeckt
		if not objeckt.processed:
			process(objeckt, dir)
			print(objeckt.tile)
	
	for objeckt in get_children():
		objeckt = objeckt as Objeckt
		objeckt.processed = false


func _unhandled_input(event: InputEvent) -> void:
	var moved := true
	if event.is_action_pressed("walk_left"):
		move(Vector2(-1,0))
	elif event.is_action_pressed("walk_right"):
		move(Vector2(1,0))
	elif event.is_action_pressed("walk_up"):
		move(Vector2(0,-1))
	elif event.is_action_pressed("walk_down"):
		move(Vector2(0,1))
	else:
		moved = false
	if moved:
		get_node("../MoveTimer").start()




func _on_MoveTimer_timeout() -> void:
	if Input.is_action_pressed("walk_left"):
		move(Vector2(-1,0))
	if Input.is_action_pressed("walk_right"):
		move(Vector2(1,0))
	if Input.is_action_pressed("walk_up"):
		move(Vector2(0,-1))
	if Input.is_action_pressed("walk_down"):
		move(Vector2(0,1))
