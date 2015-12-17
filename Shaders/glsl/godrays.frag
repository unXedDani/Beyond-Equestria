#version 120
uniform float exposure;
uniform float decay;
uniform float density;
uniform float weight;
uniform sampler2D texture0;
uniform sampler2D texture1;
const int NUM_SAMPLES = 50;

void main()
{	
	vec4 pos = glToScreen(gl_LightSource[0].position, 0);
	vec2 lightPositionOnScreen = vec2(pos.x, pos.y);
	vec2 deltaTextCoord = vec2( gl_TexCoord[0].st - lightPositionOnScreen.xy );
	vec2 textCoo = gl_TexCoord[0].st;
	deltaTextCoord *= 1.0 /  float(NUM_SAMPLES) * density;
	float illuminationDecay = 1.0;
	gl_FragColor = texture2D(texture1, textCoo);

	for(int i=0; i < NUM_SAMPLES ; i++)
		{
						 textCoo -= deltaTextCoord;
						 vec4 sample = texture2D(texture1, textCoo);
	
						 sample *= illuminationDecay * weight;

						 gl_FragColor += sample;

						 illuminationDecay *= decay;
		 }
		 gl_FragColor *= exposure;
}

vec4 glToScreen(vec4 v)
{
	// Get the matrices and viewport
 double modelView[16];
 double projection[16];
 double viewport[4];
 double depthRange[2];

 glGetDoublev(GL_MODELVIEW_MATRIX, modelView);
 glGetDoublev(GL_PROJECTION_MATRIX, projection);
 glGetDoublev(GL_VIEWPORT, viewport);
 glGetDoublev(GL_DEPTH_RANGE, depthRange);
 
 vec4 T[4];
 int r, c, i;
 for (r = 0; r < 4; ++r)
 {
	for (c = 0; c < 4; ++c)
	{
		T[r][c] = 0;
		for (i = 0; i < 4; ++i)
		{
			// OpenGL matrices are column major
			 T[r][c] += projection[r + i * 4] * modelView[i + c * 4];
		}
	}
 }
 vec4 result;
 for (r = 0; r < 4; ++r)
 {
	result[r] = T[r].dot(v);
 }

 // Homogeneous divide
 double rhw = 1 / result.w;

 return vec4(
 (1 + result.x * rhw) * viewport[2] / 2 + viewport[0],
 (1 - result.y * rhw) * viewport[3] / 2 + viewport[1],
 (result.z * rhw) * (depthRange[1] - depthRange[0]) + depthRange[0],
 rhw);
}