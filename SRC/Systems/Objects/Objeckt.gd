tool
class_name Objeckt
extends Node2D


export var tile: Vector2 setget _set_tile
export var collision := true
export var moveable := true

var processed := false
var last_move := Vector2.ZERO
var collisions := 0


func move(input_dir: Vector2) -> Vector2:
	return Vector2.ZERO


func push(dir: Vector2) -> Vector2:
	if moveable:
		return dir
	return Vector2.ZERO


func _set_tile(value: Vector2):
	tile = value
	position = tile*24+Vector2.ONE*12
