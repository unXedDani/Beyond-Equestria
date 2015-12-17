#version 120
varying float diffuse_value;
uniform float ambientR;
uniform float ambientG;
uniform float ambientB;
void main() {
    // Set the output color of our current pixel
    gl_FragColor = gl_Color * diffuse_value + vec4(ambientR, ambientG, ambientB, 1.0);
}