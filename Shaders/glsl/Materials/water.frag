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
	vec4 envmap = texture2D(mTexture1, gl_TexCoord[1].st);
	gl_FragColor = (color*0.5) + (envmap*0.4);
}