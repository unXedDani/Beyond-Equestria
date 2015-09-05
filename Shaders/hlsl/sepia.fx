// nvidia shader library
// http://developer.download.nvidia.com/shaderlibrary/webpages/shader_library.html

uniform sampler2D SceneBuffer : register(s0);
uniform float Toning;
uniform float Desaturation;

float4 main(float2 texCoord:TEXCOORD0):COLOR
{
	float3 PaperTone={1.0, 0.95, 0.7};
	float3 StainTone={0.2, 0.05, 0.0};
	
	float3 texColor = PaperTone*tex2D(SceneBuffer, texCoord).rgb;
	
	// digital ITU R 709: Y = 0.2126 R + 0.7152 G + 0.0722 B 
	// digital ITU R 601: Y = 0.2990 R + 0.5870 G + 0.1140 B
    float gray = dot(texColor, float3(0.2990, 0.5870, 0.1140));
    float3 muted = lerp(texColor, gray.xxx, Desaturation);
    float3 sepia = lerp(StainTone, PaperTone, gray);
    float3 result = lerp(muted, sepia, Toning);
   
    return float4(result,1.0);
}