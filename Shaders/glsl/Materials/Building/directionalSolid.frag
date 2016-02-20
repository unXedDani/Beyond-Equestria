#version 120
uniform sampler2D mTexture0;
uniform float ambientR, ambientG, ambientB;
varying float diffuse_value;
void main() {
    // Set the output color of our current pixel
	vec4 color = texture2D(mTexture0, gl_TexCoord[0].st)*gl_Color;
    gl_FragColor = clamp((diffuse_value * color)+vec4(ambientR, ambientG, ambientB, 1.0), 0.0, 1.0);
		
}