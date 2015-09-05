uniform sampler2D mTexture0, mTexture1, mTexture2;
varying vec4 diffuse;
varying vec3 normal,halfVector;
uniform float red;
uniform float ambientR, ambientG, ambientB, bumpDepth;

void main()
{
    vec3 n,halfV,lightDir;
    float NdotL,NdotHV;
	
    lightDir = vec3(gl_LightSource[0].position);
	
    /* The ambient term will always be present */
    vec4 color = texture2D(mTexture0, gl_TexCoord[0].st);
    /* a fragment shader can't write a varying variable, hence we need
    a new variable to store the normalized interpolated normal */
    n = normalize(normal);
    /* compute the dot product between normal and ldir */
	n = 2.0 * (texture2D (mTexture1, gl_TexCoord[0].st).rgb * bumpDepth) - 1.0;
	n = normalize ((normal+n)/2.0);
    NdotL = max(dot(n,lightDir),0.0);
	if(NdotL > 0.0){
        color *= diffuse * NdotL + vec4(ambientR, ambientG, ambientB, 0.0);
        halfV = normalize(halfVector);
        NdotHV = max(dot(n,halfV),0.0);
        //color += gl_FrontMaterial.specular * gl_LightSource[0].specular * pow(NdotHV, gl_FrontMaterial.shininess);
		color += (2.0*(texture2D(mTexture2, gl_TexCoord[0].st).r) - 1.0) * gl_LightSource[0].specular;
    }
    gl_FragColor = color;
}