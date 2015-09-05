uniform sampler2D SceneBuffer : register(s0);
uniform sampler2D BlurBuffer : register(s1);
uniform float EffectStrength;

float4 main(float2 texCoord: TEXCOORD0):COLOR0
{
	float4 col0 = tex2D(BlurBuffer, texCoord.xy);	// Bloom color
	float4 col1 = tex2D(SceneBuffer, texCoord.xy);	// Scene
	
	// Tonemap (using photographic exposure mapping)
	float4 col2 = 1.0-exp2(-EffectStrength*col0);
	
	return (col2+col1);
}
