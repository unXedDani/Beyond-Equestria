#version 120
uniform sampler2D mTexture0;
uniform sampler2D mTexture1;
uniform sampler2D mTexture2;
uniform float ambientR, ambientG, ambientB;
varying float diffuse_value;
varying vec3 normal;

vec4 interpolate(vec4 c1, vec4 c2, float inter)
{
	return ( 1.0 - inter )* c1 + inter * c2;
}
void main() {
    // Set the output color of our current pixel
		vec4 c = gl_Color;
		vec4 color = texture2D(mTexture0, vec2(c.r, c.g));
		//vec4 c1 = interpolate(texture2D(mTexture1, gl_TexCoord[0].st), texture2D(mTexture2, gl_TexCoord[0].st), normal.z);
		//float g = (c1.r+c1.g+c1.b)/3;
		//c1 = vec4(g, g, g, 1.0);
		//color = c1;
    gl_FragColor = diffuse_value * color + (color*vec4(ambientR, ambientG, ambientB, 1.0));
		
}

