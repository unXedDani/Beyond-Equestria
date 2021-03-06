uniform sampler2D PrevLumBuffer : register(s0);
uniform sampler2D TargetLumBuffer : register(s1);
uniform float EffectStrength;

float4 main(float2 texCoord: TEXCOORD0):COLOR0
{
	float4 prevLum = tex2D(PrevLumBuffer, texCoord);
	float4 targetLum = tex2D(TargetLumBuffer, texCoord);
	return saturate(prevLum+(targetLum-prevLum)*EffectStrength);
}
