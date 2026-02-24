class_name ColometryPlayer2DPercentPositionToColor
extends Node


signal on_position_as_color_changed(color:Color)

@export var player_position_node2d:Node2D
@export var player_direction_node2d:Node2D
@export var level_down_left:Node2D
@export var level_top_right:Node2D


@export_range(0.0, 1.0)  var left_right_percent_0_1_in_map: float = 0.0
@export_range(0.0, 1.0)  var down_top_percent_0_1_in_map: float = 0
@export_range(0.0, 360.0)  var angle_0_360_clockwise: float = 0
@export_range(0.0, 1.0)  var angle_0_1_percent: float = 0
@export var export_color : Color = Color(0,0,0)



func _process(delta: float) -> void:
	if not player_position_node2d or not level_down_left or not level_top_right:
		return

	var player_pos = player_position_node2d.global_position
	var level_left = level_down_left.global_position.x
	var level_right = level_top_right.global_position.x
	var level_down = level_down_left.global_position.y
	var level_top = level_top_right.global_position.y
	left_right_percent_0_1_in_map = (player_pos.x - level_left) / (level_right - level_left)
	down_top_percent_0_1_in_map = (player_pos.y - level_down) / (level_top - level_down)

	if player_direction_node2d:
		# take the node 3d foward direction of player_direction_node2d and convert to angle 0-360 clockwise, then to 0-1 percent
		var player_direction_forward = player_direction_node2d.global_transform.x.normalized()
		angle_0_360_clockwise = atan2(player_direction_forward.y, player_direction_forward.x) * 180.0 / PI	
		angle_0_1_percent = angle_0_360_clockwise / 360.0
	else:
		angle_0_360_clockwise = 0
		angle_0_1_percent = 0
		

	var color = Color(left_right_percent_0_1_in_map, down_top_percent_0_1_in_map, angle_0_1_percent)
	if color != export_color:
		export_color = color
		on_position_as_color_changed.emit(export_color)
