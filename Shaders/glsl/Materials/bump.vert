varying vec3 halfVector;
varying float diffuse;
void main() {  
	gl_TexCoord[0] = gl_MultiTexCoord0;  
	halfVector = gl_LightSource[0].halfVector.xyz;
	diffuse = gl_FrontMaterial.diffuse * gl_LightSource[0].diffuse;
	// Set the position of the current vertex  
	gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;  
}  