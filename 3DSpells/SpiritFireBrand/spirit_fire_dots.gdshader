shader_type spatial;
render_mode unshaded, cull_disabled, blend_mix;

uniform sampler2DArray particle_texture;
uniform sampler2D gradient;

varying flat int particle_id;

void vertex()
{
    particle_id = INSTANCE_ID % 4;
	
    POINT_SIZE = 128.0;
}

void fragment()
{
    vec4 texture_alpha = texture(particle_texture, vec3(POINT_COORD, float(particle_id)));
	vec4 color = texture(gradient, UV);
	
    ALBEDO = color.rgb;
	ALPHA = texture_alpha.r;
}