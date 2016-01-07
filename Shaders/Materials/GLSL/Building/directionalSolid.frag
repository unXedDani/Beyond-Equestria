#version 120
uniform float ambientR, ambientG, ambientB;
varying float diffuse_value;
void main() {
    // Set the output color of our current pixel
		vec4 color = texture2D(mTexture0, gl_TexCoord[0].st);//gl_Color;
    gl_FragColor = diffuse_value * color + (color*vec4(ambientR, ambientG, ambientB, 1.0));
		
}