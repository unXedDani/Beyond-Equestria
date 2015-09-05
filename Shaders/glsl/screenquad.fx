#version 120
uniform sampler2D texture0;
uniform float BufferWidth;
uniform float BufferHeight;

void main()
{
	gl_FragColor=texture2D(texture0, gl_TexCoord[0].xy);
}

void downscale2x2()
{
	vec2 texSize = vec2(1.0/BufferWidth, 1.0/BufferHeight);
	vec4 average = vec4(0.0);
	vec2 samples[4];
	samples[0]=vec2(-0.5, -0.5);
	samples[1]=vec2(-0.5,  0.5);
	samples[2]=vec2( 0.5, -0.5);
	samples[3]=vec2( 0.5,  0.5);
	for (int i=0; i<4; ++i)
	{
		average += texture2D(texture0, gl_TexCoord[0].xy+texSize*samples[i]);
	}
	gl_FragColor = average*0.25;
}
/*
//======================================================================================
#define FXAA_PC 1
#define FXAA_GLSL_130 1
#define FXAA_QUALITY__PRESET 12
#define FXAA_GREEN_AS_LUMA 1
#include "Shaders/fxaa3_11.h"
void finalPassFXAA()
{
	FxaaFloat2 fxaaQualityRcpFrame = FxaaFloat2(1.0/BufferWidth, 1.0/BufferHeight);
	FxaaFloat4 fxaaConsoleRcpFrameOpt = FxaaFloat4(-0.5/BufferWidth, -0.5/BufferHeight, 0.5/BufferWidth, 0.5/BufferHeight);
	FxaaFloat4 fxaaConsoleRcpFrameOpt2 = FxaaFloat4(-2.0/BufferWidth, -2.0/BufferHeight, 2.0/BufferWidth, 2.0/BufferHeight);
	FxaaFloat4 fxaaConsole360RcpFrameOpt2 = FxaaFloat4(8.0/BufferWidth, 8.0/BufferHeight, -4.0/BufferWidth, -4.0/BufferHeight);
	FxaaFloat fxaaQualitySubpix = 0.75;
	FxaaFloat fxaaQualityEdgeThreshold = 0.166;
	FxaaFloat fxaaQualityEdgeThresholdMin = 0.0625;
	FxaaFloat fxaaConsoleEdgeSharpness = 8.0;
	FxaaFloat fxaaConsoleEdgeThreshold = 0.125;
	FxaaFloat fxaaConsoleEdgeThresholdMin = 0.05;
	FxaaFloat4 fxaaConsole360ConstDir = FxaaFloat4(1.0, -1.0, 0.25, -0.25);
	FxaaFloat2 texCoord = gl_TexCoord[0].xy;
	FxaaFloat4 texCoord2 = FxaaFloat4(texCoord.x, texCoord.y, texCoord.x, texCoord.y)+fxaaConsoleRcpFrameOpt;
	
	gl_FragColor = FxaaPixelShader(
		texCoord,
		texCoord2,
		texture0,
		texture0,
		texture0,
		fxaaQualityRcpFrame,
		fxaaConsoleRcpFrameOpt,
		fxaaConsoleRcpFrameOpt2,
		fxaaConsole360RcpFrameOpt2,
		fxaaQualitySubpix,
		fxaaQualityEdgeThreshold,
		fxaaQualityEdgeThresholdMin,
		fxaaConsoleEdgeSharpness,
		fxaaConsoleEdgeThreshold,
		fxaaConsoleEdgeThresholdMin,
		fxaaConsole360ConstDir);
}*/