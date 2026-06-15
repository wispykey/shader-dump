extends Path3D


@export var speed = 15

var time_elapsed: float = 0.
var delay_between_edges: Array[float] = [0.2, 0.3, 0.5, .8, 1.]

func _process(delta: float) -> void:
	var paths = get_children()
	
	for j in paths.size():
		var path: PathFollow3D = paths[j]
		
		var progress_offset = j * delay_between_edges[j]
		var progress = time_elapsed * speed + progress_offset
		
		
		var prev_progress_ratio = path.progress_ratio
	
		# setting path.progress updates path.progress_ratio immediately
		# why do this? since we can't query the max value of path.progress for normalization
		# we instead normalize the value by retrieving the computed progress_ratio
		path.progress = max(0, progress)
		var t = path.progress_ratio
		
		var new_progress_ratio = ease(t, 0.35)
		path.progress_ratio = new_progress_ratio

		# if we have wrapped around 
		if (new_progress_ratio < prev_progress_ratio):
			path.queue_free()
			continue
		
		var wind: WindBlade = path.get_child(0)
		# Could optimize this
		var wind_t = ease(t, 1) if t < 0.4 else clamp(1 - ease(t, 0.3), 0., 0.6)
		wind.set_alpha(wind_t)
		
		#Tween.interpolate_value()
	
	time_elapsed += delta *0.8
