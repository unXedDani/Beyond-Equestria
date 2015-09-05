float4x4 WorldMatrix;
float4x4 ViewMatrix;
float4x4 ProjMatrix;
float DistanceScale;

struct VS_INPUT
{
	float4 Pos:POSITION;
    float3 Normal:NORMAL0;
	float2 Tex:TEXCOORD0;
};

struct VS_OUTPUT
{
	float4 Pos:POSITION;
    float4 Color:COLOR0;
};

VS_OUTPUT main(VS_INPUT input)
{
	VS_OUTPUT output;

	//output.Pos = mul(input.Pos, WorldViewProjMatrix);
    output.Pos = mul(mul(mul(input.Pos, WorldMatrix), ViewMatrix), ProjMatrix);
    float3 worldNormal = mul(input.Normal, WorldMatrix);
    output.Color.rgb = (worldNormal + 1.0) / 2.0;

	float4 vec = -DistanceScale * output.Pos;
	output.Color.a = length(vec.xyz);

	return output;
}
