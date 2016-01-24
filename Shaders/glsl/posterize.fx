#version 120
// nvidia shader library
// http://developer.download.nvidia.com/shaderlibrary/webpages/shader_library.html

uniform sampler2D texture0;
uniform float NumColors;
uniform float Gamma;

void main()
{
	vec4 texCol = texture2D(texture0, gl_TexCoord[0].xy);
	/*vec3 col0 = vec3(texCol.r, texCol.g, texCol.b);
	col0 = vec3(pow(float(col0), Gamma));
	col0 = col0*NumColors;
	col0 = floor(col0);
	col0 = col0/NumColors;
	col0 = vec3(pow(float(col0), 1.0f/Gamma));*/
	texCol = texCol + texCol/Gamma;
	texCol = texCol * NumColors;
	texCol = floor(texCol);
	texCol = texCol/NumColors;
	gl_FragColor = texCol;
}
