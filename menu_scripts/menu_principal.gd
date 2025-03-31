extends Control

#préchargé l'ancienne partie
@onready var newGame#= preload("")
@onready var SaveLvl# = preload("")

func _on_start_btn_button_down() -> void:
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_packed(newGame)

func _on_continue_btn_pressed() -> void:
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_packed(SaveLvl)

func _on_quit_btn_button_down() -> void:
	get_tree().quit()
