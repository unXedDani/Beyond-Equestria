#version 330

uniform sampler2D texture0; //Main
uniform sampler2D ghostTex; //Downsampled
uniform sampler2D dirtTex; //DirtTexture
uniform sampler2D texture3;
uniform float uExposure = 0.3;

noperspective in vec2 vTexcoord;

layout(location=0) out vec4 fResult;

/*----------------------------------------------------------------------------*/

void main()
{
	vec4 lensMod = texture(dirtTex, vTexcoord);
	vec4 flare = texture(ghostTex, vTexcoord) * lensMod;
	
	fResult = texture(texture0, vTexcoord) + (flare*uExposure);
}