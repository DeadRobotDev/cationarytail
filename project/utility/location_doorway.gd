extends Area2D

signal interacted

@export var destination_mark: Marker2D

@onready var arrow_indicator: Sprite2D = %ArrowIndicator

var area_active: bool = false

func _ready():
	arrow_indicator.visible = false
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _unhandled_input(event):
	if area_active and event.is_action_pressed("ui_accept"):
		var player = get_tree().get_first_node_in_group("Player")
		SceneTransitionManager.change_position_with_transition(player, destination_mark, SceneManager.FADE_TRANSITION)
		get_viewport().set_input_as_handled()
		interacted.emit()

func _on_area_entered(area: Area2D) -> void:
	area_active = true
	arrow_indicator.visible = true

func _on_area_exited(area: Area2D) -> void:
	area_active = false
	arrow_indicator.visible = false