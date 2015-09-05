uniform sampler2D SceneBuffer : register(s0);
uniform float ColorR;
uniform float ColorG;
uniform float ColorB;

float4 main(float2 texCoord: TEXCOORD0):COLOR0
{
	float4 texCol = tex2D(SceneBuffer, texCoord);
	
	// digital ITU R 709: Y = 0.2126 R + 0.7152 G + 0.0722 B 
	// digital ITU R 601: Y = 0.2990 R + 0.5870 G + 0.1140 B
	float lum = dot(texCol.rgb, float3(0.2990, 0.5870, 0.1140));	
	return float4(
		pow(lum, 1.0/ColorR),
		pow(lum, 1.0/ColorG),
		pow(lum, 1.0/ColorG), 
		texCol.a)*ColorB+texCol*(1.0-ColorB);
}
