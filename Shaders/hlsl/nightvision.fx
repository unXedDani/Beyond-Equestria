// based on http://www.geeks3d.com/20091009/shader-library-night-vision-post-processing-filter-glsl/

uniform sampler2D SceneBuffer : register(s0);
uniform sampler2D NoiseTex : register(s1);
uniform sampler2D MaskTex : register(s2);
//uniform float ElapsedTime;
uniform float RandomValue;
uniform float LuminanceThreshold;
uniform float ColorAmplification;
uniform float NoiseStrength;
uniform float VisionColorR;
uniform float VisionColorG;
uniform float VisionColorB;

float4 main(float2 texCoord:TEXCOORD0):COLOR
{
	float4 finalCol;
	
	// noise
	float2 noiseCoord;
	noiseCoord.x = RandomValue; // 0.4*sin(ElapsedTime*50.0);
	noiseCoord.y = RandomValue; // 0.4*cos(ElapsedTime*50.0);
	float3 noiseCol = tex2D(NoiseTex, (texCoord*NoiseStrength)+noiseCoord).rgb;
	
	// light amplification
	float3 texCol = tex2D(SceneBuffer, texCoord+(noiseCol.xy*0.001)).rgb;
	texCol = float3(saturate((texCol.rgb-LuminanceThreshold)/(ColorAmplification-LuminanceThreshold)));

	// mask
	float4 maskCol = tex2D(MaskTex, texCoord);
	
	// calculate final color
	if (maskCol.a > 0.0)
	{
		finalCol = maskCol*maskCol.a;
	}
	//else
	{
		finalCol.rgb += (texCol+(noiseCol*0.2))*float3(VisionColorR, VisionColorG, VisionColorB)*(1.0-maskCol.a);
		finalCol.a = 1.0;
	}
	return finalCol;
}