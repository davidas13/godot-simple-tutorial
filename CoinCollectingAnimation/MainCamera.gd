extends Camera2D

export var max_slider_pos: float = 500
export var max_zoom: float = 2.0
onready var initial_pos: Vector2 = global_position


func _on_ZoomSlider_value_changed(value: float) -> void:
	var zoom_amount := range_lerp(value, 0.0, 100.0, 0.1, max_zoom)
	zoom = Vector2(zoom_amount, zoom_amount)


func _on_HPosSlider_value_changed(value: float) -> void:
	var x_pos := range_lerp(value, 0.0, 100.0, initial_pos.x - max_slider_pos, initial_pos.x + max_slider_pos)
	global_position.x = x_pos
