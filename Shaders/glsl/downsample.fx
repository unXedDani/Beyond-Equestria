#version 330
uniform sampler2D texture0;
uniform sampler2D texture1;

uniform vec4 uScale = vec4(0.5);
uniform vec4 uBias = vec4(0.0);

noperspective in vec2 vTexcoord;

layout(location=0) out vec4 fResult;

/*----------------------------------------------------------------------------*/
void main() {
	fResult = (max(vec4(0.0), texture(texture0, vTexcoord) + uBias) * uScale);
}