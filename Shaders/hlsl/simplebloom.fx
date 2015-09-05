uniform sampler2D SceneBuffer : register(s0);
uniform float EffectStrength;

float4 main(float2 texCoord:TEXCOORD0):COLOR
{
	float4 finalCol = tex2D(SceneBuffer, texCoord);
	float4 col0 = finalCol;
		
	// higher contrast
	finalCol.rgb = pow(col0.rgb, EffectStrength);
		
	// mix colors
	finalCol.rgb *= col0;
	finalCol.rgb += col0;

	return finalCol; 
}
