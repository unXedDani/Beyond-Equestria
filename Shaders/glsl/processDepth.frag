#version 330
uniform sampler2D texture0;
uniform sampler2D texture1;

uniform vec4 uScale = vec4(0.5);
uniform vec4 uBias = vec4(0.0);

noperspective in vec2 vTexcoord;

layout(location=0) out vec4 fResult;

/*----------------------------------------------------------------------------*/
void main() {
	vec4 color = texture(texture0, vTexcoord);
	if(color.x == 0.0 && color.y == 0.0 && color.z == 0.0)
	{
		color = vec4(1.0, 1.0, 1.0, color.a);
	}else
	{
		color = vec4(0.0, 0.0, 0.0, color.a);
	}
	fResult = color;
}