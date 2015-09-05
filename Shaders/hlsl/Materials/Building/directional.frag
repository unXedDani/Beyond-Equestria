varying float diffuse_value;
float4 main() {
    // Set the output color of our current pixel
    return = gl_Color * diffuse_value;
}