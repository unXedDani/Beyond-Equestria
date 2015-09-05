#version 120
varying vec4 posPos;
uniform float FXAA_SUBPIX_SHIFT = 1.0/4.0;
uniform float BufferWidth; // GeeXLab built-in
uniform float BufferHeight; // GeeXLab built-in

void main(void)
{
  gl_Position = ftransform();
  gl_TexCoord[0] = gl_MultiTexCoord0;
  vec2 rcpFrame = vec2(1.0/BufferWidth, 1.0/BufferHeight);
  posPos.xy = gl_MultiTexCoord0.xy;
  posPos.zw = gl_MultiTexCoord0.xy - 
                  (rcpFrame * (0.5 + FXAA_SUBPIX_SHIFT));
}