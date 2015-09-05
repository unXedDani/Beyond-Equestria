#version 120
uniform sampler2D mTexture;
void main()
{
    gl_TexCoord[0] = gl_MultiTexCoord0;
	// perform standard transform on vertex
	gl_Position = ftransform();
}
