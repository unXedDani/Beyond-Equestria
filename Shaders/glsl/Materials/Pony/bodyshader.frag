varying vec4 diffuse, ambient;
varying vec3 normal, halfVector;

uniform sampler2D mTexture0;

void main()
{
    vec3 n,halfV,lightDir;
    float NdotL,NdotHV;
 
    lightDir = vec3(gl_LightSource[0].position);
		
    /* The ambient term will always be present */
    vec4 color = ambient;
    /* a fragment shader can't write a varying variable, hence we need
    a new variable to store the normalized interpolated normal */
    n = normalize(normal);
		//vec4 texColor = texture2D(mTexture0, gl_TexCoord[0].st);
		//color *= texColor;
    /* compute the dot product between normal and ldir */
    NdotL = max(dot(n,lightDir),0.0);
		if (NdotL > 0.0) {
        color += diffuse * NdotL;
        halfV = normalize(halfVector);
        NdotHV = max(dot(n,halfV),0.0);
        //color += gl_FrontMaterial.specular *
               // gl_LightSource[0].specular *
                //pow(NdotHV, gl_FrontMaterial.shininess);
    }
 
    gl_FragColor = color;
}