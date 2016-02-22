/* Fragment shader */
 varying float time;
uniform sampler2D mTexture0,  mTexture1;
uniform float opacity;
void main() {
	// Set the output color of our current pixel
	vec2 texcoord = gl_TexCoord[0];
	texcoord.x += (sin(time+texcoord.x)*cos(time+texcoord.x/2))/20;
	texcoord.y += (sin(time+texcoord.y/2)*cos(time+texcoord.y))/20;
	vec4 color = texture2D(mTexture0, texcoord.st);
	color.a = opacity;
	gl_FragColor = color;
}