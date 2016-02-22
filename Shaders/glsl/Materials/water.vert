/* Vertex shader */
uniform float mWorldTime;
uniform float waveWidth;
uniform float waveHeight;

varying float time;
void main(void)
{
	mWorldTime = mWorldTime/1000;
	time = mWorldTime;
	vec4 v = vec4(gl_Vertex);
	v.y = sin(waveWidth * v.x + mWorldTime) * cos(waveWidth * v.z + mWorldTime) * waveHeight;
	v.y *= sin(waveWidth * (2*-v.z) +mWorldTime) * cos(waveWidth * (2*v.z) + mWorldTime);
 	gl_Position = gl_ModelViewProjectionMatrix * v;
        gl_TexCoord[0] = gl_MultiTexCoord0;
	vec3 u = normalize( vec3(gl_ModelViewMatrix * v));
	vec3 n = normalize( gl_NormalMatrix * gl_Normal );
	vec3 r = reflect( u, n );
	float m = 2.0 * sqrt( r.x*r.x + r.y*r.y + (r.z+1.0)*(r.z+1.0) );
	gl_TexCoord[1].s = r.x/m + 0.5;
	gl_TexCoord[1].t = r.y/m + 0.5;
}