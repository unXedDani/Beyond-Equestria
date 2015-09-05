uniform sampler2D SceneBuffer : register(s0);
uniform sampler2D BlurBuffer : register(s1);
uniform sampler2D DistanceBuffer : register(s2);

float4 main(float2 texCoord: TEXCOORD0):COLOR0
{
	float4 sharp = tex2D(SceneBuffer, texCoord);
	float4 blur  = tex2D(BlurBuffer, texCoord);
	float4 dist  = tex2D(DistanceBuffer, texCoord);
	float factor = 0;
	
	if (dist.a < 0.05)
		factor = 1.0;
	else if(dist.a < 0.1)
		factor = 20.0 *(0.1 - dist.a);
	else if(dist.a < 0.5)
		factor=0;
	else
		factor = 2.0 *(dist.a - 0.5);

	clamp(factor, 0.0, 0.90);
	return lerp(sharp, blur, factor);
}
