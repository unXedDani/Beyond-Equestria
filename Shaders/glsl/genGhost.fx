#version 330
uniform sampler2D texture0;
uniform sampler2D texture1;

uniform int uGhosts = 3; // number of ghost samples
uniform float uGhostDispersal = 0.35; // dispersion factor

const int MAX_SAMPLES = 64;
uniform int uSamples = 8;

uniform float uDispersal = 0.25;
uniform float uHaloWidth = 0.3;
uniform float uDistortion = 0.5;

noperspective in vec2 vTexcoord;

layout(location=0) out vec4 fResult;

vec4 textureDistorted(
	in sampler2D tex, 
	in vec2 texcoord, 
	in vec2 direction,
	in vec3 distortion 
) {
	return vec4(
		texture(tex, texcoord + direction * distortion.r).r,
		texture(tex, texcoord + direction * distortion.g).g,
		texture(tex, texcoord + direction * distortion.b).b,
		1.0
	);
}

void main() {
	vec2 texcoord = -(vTexcoord) + vec2(1.0);
	vec2 texelSize = 1.0 / vec2(textureSize(texture0, 0));
	vec3 distortion = vec3(-texelSize.x * uDistortion, 0.0, texelSize.x * uDistortion);
// ghost vector to image centre:
	vec2 ghostVec = (vec2(0.5) - texcoord) * uGhostDispersal;
	vec2 haloVec = normalize(ghostVec) * uHaloWidth;
	
// sample ghosts:  
	vec4 result = vec4(0.0);
	for (int i = 0; i < uSamples; ++i) {
		vec2 offset = fract(texcoord + ghostVec * float(i));
		
		float weight = length(vec2(0.5) - offset) / length(vec2(0.5));
		weight = pow(1.0 - weight, 5.0);
		result += textureDistorted(
			texture0,
			offset,
			normalize(ghostVec),
			distortion
		) * weight;
	}
	
	float weight = length(vec2(0.5) - fract(texcoord + haloVec)) / length(vec2(0.5));
	weight = pow(1.0 - weight, 5.0);
	result += textureDistorted(
		texture0,
		fract(texcoord + haloVec),
		normalize(ghostVec),
		distortion
	) * weight;
	fResult = result;
}