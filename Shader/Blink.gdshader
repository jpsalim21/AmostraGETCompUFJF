shader_type canvas_item;

uniform bool isActive = false;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	if(isActive){
		vec4 corAtual = COLOR;
		vec4 branco = vec4(1.0);
		vec4 diferenca = branco - corAtual;
		COLOR = COLOR + diferenca * abs(sin(TIME));
	}
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
