shader_type spatial;
render_mode blend_mix, cull_disabled, unshaded;

uniform sampler2D tex: repeat_disable;
uniform vec4 color: source_color;

varying vec3 local_pos;

void vertex() {
    local_pos = VERTEX;
}

void fragment() {
    vec3 n = normalize(local_pos);

    // pole-centered planar projection
    vec2 uv = n.xz / (1.0 + n.y);

    // remap to 0–1
    uv = uv * 0.5 + 0.5;


    vec4 col = texture(tex, uv);
	float mask = smoothstep( -.05, .2, n.y);

    ALBEDO = col.rgb * color.rgb;
    ALPHA = mask * col.r;
}