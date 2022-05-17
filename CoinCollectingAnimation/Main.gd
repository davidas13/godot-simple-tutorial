extends Node2D

var Coin = preload("res://Coin.tscn")
var coin_amount := 0


onready var score_ui := $GUI/ScoreUI
onready var score_icon := score_ui.get_node("Icon")
onready var score_value := score_ui.get_node("Value")
onready var main_camera := $MainCamera


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("ui_left_click"):
			var _coin: Sprite = Coin.instance(PackedScene.GEN_EDIT_STATE_INSTANCE)
			var _coin_tween: Tween = _coin.get_node("Tween")
			
			add_child(_coin)
			
			_coin_tween.follow_method(
				_coin,
				"set_global_position",
				get_global_mouse_position(),
				self,
				"_get_coin_target_position",
				4.0,
				Tween.TRANS_BACK,
				Tween.EASE_IN_OUT
			)
			_coin_tween.interpolate_property(
				_coin,
				"modulate:a",
				1.0,
				0.0,
				0.5,
				Tween.TRANS_LINEAR,
				Tween.EASE_IN,
				3.5
			)
			_coin_tween.connect("tween_all_completed", self, "_on_Coin_update_score", [_coin])
			
			_coin_tween.start()

func _get_coin_target_position() -> Vector2:
	var _coin_pos: Vector2 = (score_icon.get_global_transform_with_canvas().origin + (score_icon.rect_size / 2)) * main_camera.zoom
	var _camera_pos: Vector2 = main_camera.global_position - (get_viewport_rect().size / 2 * main_camera.zoom)
	var _coin_target_position := _coin_pos + _camera_pos
	return _coin_target_position


func _on_Coin_update_score(coin: Sprite) -> void:
	coin_amount += 1
	score_value.text = str(coin_amount)
	coin.queue_free()
	
	
	
