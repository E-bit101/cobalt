#version 440

layout(location = 0) in vec2 uv;
layout(location = 0) out vec4 fragColor;

layout(binding = 1) uniform sampler2D wallpaper;

layout(std140, binding = 0) uniform buf
{
    mat4 qt_Matrix;
    float qt_Opacity;

    vec2 screenSize;
    vec2 panelPos;
    vec2 panelSize;

    float time;
    float cornerRadius;
    float blurStrength;
    float refractionStrength;
    float gamma;
};

//void main()
//{
//    fragColor = texture(wallpaper, uv * panelSize / screenSize);
//}

#define width 0.5  // % by X
#define height 0.5 // % by Y
#define radius 0.1
#define lens_refraction 0.1
#define sharp 0.1

int samples = 12 + int(blurStrength) * 16;
const int LOD = 2,         // gaussian done on MIPmap at scale LOD
          sLOD = 1 << LOD; // tile size = 2^LOD
float sigma = float(samples) * .25;

float gaussian(vec2 i) {
    return exp( -.5* dot(i/=sigma,i) ) / ( 6.28 * sigma*sigma );
}

vec4 blur(sampler2D sp, vec2 U, vec2 scale) {
    vec4 O = vec4(0);  
    int s = samples/sLOD;
    
    for ( int i = 0; i < s*s; i++ ) {
        vec2 d = vec2(i%s, i/s)*float(sLOD) - float(samples)/2.;
        O += gaussian(d) * textureLod( sp, U + scale * d , float(LOD) );
    }
    
    return O / O.a;
}

float fresnel(vec2 uv, float scale, float power) {
    return 1. - pow(1. - length(uv * scale), power);
}

float box( in vec2 p, in vec2 b, in vec4 r )
{
    r.xy = (p.x>0.0)?r.xy : r.zw;
    r.x  = (p.y>0.0)?r.x  : r.y;
    vec2 q = abs(p)-b+r.x;
    return min(max(q.x,q.y),0.0) + length(max(q,0.0)) - r.x;
}

void main()
{
    float a = -box(uv*panelSize-panelSize/2, panelSize/2.0, vec4(panelSize.y/2.0 * cornerRadius));;
    if (a > 0) {
        vec2 lens = ( (uv * panelSize + panelPos) / screenSize-0.5)*sin(pow(
            clamp(a/refractionStrength,0.,1.),
        0.25)*1.57)+0.5;//5+sin(time)*0.05;
        
        float b = max(abs(dot(uv * 2.0 - vec2(1.0), normalize(vec2(0.5, 0.5)))), 0.25);
        
        fragColor = mix(blur(wallpaper, lens, 0.25/screenSize.xy * blurStrength), vec4(1.0), clamp(1.0-fresnel(vec2(a), 0.25, 1.0), 0.0, 1.0) * b * 0.75);
        fragColor.rgb *= gamma;
    }
    else {
        fragColor = texture(wallpaper, (uv * panelSize + panelPos) / screenSize);
    }
}