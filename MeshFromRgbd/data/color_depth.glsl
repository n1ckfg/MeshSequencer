uniform vec3 iResolution;

uniform sampler2D tex0;

uniform float mindepth;
uniform float maxdepth;

//TODO: make uniforms
const float fx = 1.11087;
const float fy = 0.832305;

vec3 rgb2hsl( vec3 color ) {
	float h = 0.0;
	float s = 0.0;
	float l = 0.0;
	float r = color.r;
	float g = color.g;
	float b = color.b;
	float cMin = min( r, min( g, b ) );
	float cMax = max( r, max( g, b ) );
	l =  ( cMax + cMin ) / 2.0;
	if ( cMax > cMin ) {
		float cDelta = cMax - cMin;
		// saturation
		if ( l < 0.5 ) {
			s = cDelta / ( cMax + cMin );
		} else {
			s = cDelta / ( 2.0 - ( cMax + cMin ) );
		}

		// hue
		if ( r == cMax ) {
			h = ( g - b ) / cDelta;
		} else if ( g == cMax ) {
			h = 2.0 + ( b - r ) / cDelta;
		} else {
			h = 4.0 + ( r - g ) / cDelta;
		}

		if ( h < 0.0) {
			h += 6.0;
		}
		h = h / 6.0;

	}
	return vec3( h, s, l );
}

vec3 xyz( float x, float y, float depth ) {
	float z = depth * ( maxdepth - mindepth ) + mindepth;
	return vec3( ( x / 640.0 ) * z * fx, ( y / 480.0 ) * z * fy, - z );
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
	vec2 uv = fragCoord.xy / iResolution.xy;
	vec2 uv2 = vec2(uv.x, abs(1.0 - uv.y));

	vec3 hslCol = rgb2hsl(texture2D(tex0, uv2).xyz);
	vec4 col = vec4(hslCol.x, hslColCol.x, hslCol.x, 1.0); 

	fragColor = col;
}

void main() {
	mainImage(gl_FragColor, gl_FragCoord.xy);
}