extends CanvasLayer

@onready var score_label: Label = $ScoreLabel
@onready var win_label: Label = $WinLabel

func update_score(value: int) -> void:
	score_label.text = "Score: %d" % value

func show_win() -> void:
	win_label.visible = true
