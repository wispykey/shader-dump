extends Node


func play_pot_shatter():
	$PotShatter.pitch_scale = 1. + randf_range(-0.05, 0.05)
	$PotShatter.play()
	
func play_elwind():
	$Elwind.pitch_scale = 1.45 + randf_range(-0.02, 0.02)
	$Elwind.play()

func play_left_footstep():
	$LeftFootstep.play()

func play_right_footstep():
	$RightFootstep.play()
	
	
func play_elthunder():
	$Elthunder.play()

func play_soulfreeze():
	$SoulFreeze.play()
