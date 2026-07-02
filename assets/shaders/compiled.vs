{@}AntimatterCopy.fs{@}uniform sampler2D tDiffuse;

varying vec2 vUv;

void main() {
    gl_FragColor = texture2D(tDiffuse, vUv);
}{@}AntimatterCopy.vs{@}varying vec2 vUv;
void main() {
    vUv = uv;
    gl_Position = vec4(position, 1.0);
}{@}AntimatterPass.vs{@}varying vec2 vUv;

void main() {
    vUv = uv;
    gl_Position = vec4(position, 1.0);
}{@}AntimatterPosition.vs{@}uniform sampler2D tPos;

void main() {
    vec4 decodedPos = texture2D(tPos, position.xy);
    vec3 pos = decodedPos.xyz;

    vec4 mvPosition = modelViewMatrix * vec4(pos, 1.0);
    gl_PointSize = 0.02 * (1000.0 / length(mvPosition.xyz));
    gl_Position = projectionMatrix * mvPosition;
}{@}AntimatterBasicFrag.fs{@}void main() {
    gl_FragColor = vec4(1.0);
}{@}antimatter.glsl{@}vec3 getData(sampler2D tex, vec2 uv) {
    return texture2D(tex, uv).xyz;
}

vec4 getData4(sampler2D tex, vec2 uv) {
    return texture2D(tex, uv);
}

{@}blendmodes.glsl{@}float blendColorDodge(float base, float blend) {
    return (blend == 1.0)?blend:min(base/(1.0-blend), 1.0);
}
vec3 blendColorDodge(vec3 base, vec3 blend) {
    return vec3(blendColorDodge(base.r, blend.r), blendColorDodge(base.g, blend.g), blendColorDodge(base.b, blend.b));
}
vec3 blendColorDodge(vec3 base, vec3 blend, float opacity) {
    return (blendColorDodge(base, blend) * opacity + base * (1.0 - opacity));
}
float blendColorBurn(float base, float blend) {
    return (blend == 0.0)?blend:max((1.0-((1.0-base)/blend)), 0.0);
}
vec3 blendColorBurn(vec3 base, vec3 blend) {
    return vec3(blendColorBurn(base.r, blend.r), blendColorBurn(base.g, blend.g), blendColorBurn(base.b, blend.b));
}
vec3 blendColorBurn(vec3 base, vec3 blend, float opacity) {
    return (blendColorBurn(base, blend) * opacity + base * (1.0 - opacity));
}
float blendVividLight(float base, float blend) {
    return (blend<0.5)?blendColorBurn(base, (2.0*blend)):blendColorDodge(base, (2.0*(blend-0.5)));
}
vec3 blendVividLight(vec3 base, vec3 blend) {
    return vec3(blendVividLight(base.r, blend.r), blendVividLight(base.g, blend.g), blendVividLight(base.b, blend.b));
}
vec3 blendVividLight(vec3 base, vec3 blend, float opacity) {
    return (blendVividLight(base, blend) * opacity + base * (1.0 - opacity));
}
float blendHardMix(float base, float blend) {
    return (blendVividLight(base, blend)<0.5)?0.0:1.0;
}
vec3 blendHardMix(vec3 base, vec3 blend) {
    return vec3(blendHardMix(base.r, blend.r), blendHardMix(base.g, blend.g), blendHardMix(base.b, blend.b));
}
vec3 blendHardMix(vec3 base, vec3 blend, float opacity) {
    return (blendHardMix(base, blend) * opacity + base * (1.0 - opacity));
}
float blendLinearDodge(float base, float blend) {
    return min(base+blend, 1.0);
}
vec3 blendLinearDodge(vec3 base, vec3 blend) {
    return min(base+blend, vec3(1.0));
}
vec3 blendLinearDodge(vec3 base, vec3 blend, float opacity) {
    return (blendLinearDodge(base, blend) * opacity + base * (1.0 - opacity));
}
float blendLinearBurn(float base, float blend) {
    return max(base+blend-1.0, 0.0);
}
vec3 blendLinearBurn(vec3 base, vec3 blend) {
    return max(base+blend-vec3(1.0), vec3(0.0));
}
vec3 blendLinearBurn(vec3 base, vec3 blend, float opacity) {
    return (blendLinearBurn(base, blend) * opacity + base * (1.0 - opacity));
}
float blendLinearLight(float base, float blend) {
    return blend<0.5?blendLinearBurn(base, (2.0*blend)):blendLinearDodge(base, (2.0*(blend-0.5)));
}
vec3 blendLinearLight(vec3 base, vec3 blend) {
    return vec3(blendLinearLight(base.r, blend.r), blendLinearLight(base.g, blend.g), blendLinearLight(base.b, blend.b));
}
vec3 blendLinearLight(vec3 base, vec3 blend, float opacity) {
    return (blendLinearLight(base, blend) * opacity + base * (1.0 - opacity));
}
float blendLighten(float base, float blend) {
    return max(blend, base);
}
vec3 blendLighten(vec3 base, vec3 blend) {
    return vec3(blendLighten(base.r, blend.r), blendLighten(base.g, blend.g), blendLighten(base.b, blend.b));
}
vec3 blendLighten(vec3 base, vec3 blend, float opacity) {
    return (blendLighten(base, blend) * opacity + base * (1.0 - opacity));
}
float blendDarken(float base, float blend) {
    return min(blend, base);
}
vec3 blendDarken(vec3 base, vec3 blend) {
    return vec3(blendDarken(base.r, blend.r), blendDarken(base.g, blend.g), blendDarken(base.b, blend.b));
}
vec3 blendDarken(vec3 base, vec3 blend, float opacity) {
    return (blendDarken(base, blend) * opacity + base * (1.0 - opacity));
}
float blendPinLight(float base, float blend) {
    return (blend<0.5)?blendDarken(base, (2.0*blend)):blendLighten(base, (2.0*(blend-0.5)));
}
vec3 blendPinLight(vec3 base, vec3 blend) {
    return vec3(blendPinLight(base.r, blend.r), blendPinLight(base.g, blend.g), blendPinLight(base.b, blend.b));
}
vec3 blendPinLight(vec3 base, vec3 blend, float opacity) {
    return (blendPinLight(base, blend) * opacity + base * (1.0 - opacity));
}
float blendReflect(float base, float blend) {
    return (blend == 1.0)?blend:min(base*base/(1.0-blend), 1.0);
}
vec3 blendReflect(vec3 base, vec3 blend) {
    return vec3(blendReflect(base.r, blend.r), blendReflect(base.g, blend.g), blendReflect(base.b, blend.b));
}
vec3 blendReflect(vec3 base, vec3 blend, float opacity) {
    return (blendReflect(base, blend) * opacity + base * (1.0 - opacity));
}
vec3 blendGlow(vec3 base, vec3 blend) {
    return blendReflect(blend, base);
}
vec3 blendGlow(vec3 base, vec3 blend, float opacity) {
    return (blendGlow(base, blend) * opacity + base * (1.0 - opacity));
}
float blendOverlay(float base, float blend) {
    return base<0.5?(2.0*base*blend):(1.0-2.0*(1.0-base)*(1.0-blend));
}
vec3 blendOverlay(vec3 base, vec3 blend) {
    return vec3(blendOverlay(base.r, blend.r), blendOverlay(base.g, blend.g), blendOverlay(base.b, blend.b));
}
vec3 blendOverlay(vec3 base, vec3 blend, float opacity) {
    return (blendOverlay(base, blend) * opacity + base * (1.0 - opacity));
}
vec3 blendHardLight(vec3 base, vec3 blend) {
    return blendOverlay(blend, base);
}
vec3 blendHardLight(vec3 base, vec3 blend, float opacity) {
    return (blendHardLight(base, blend) * opacity + base * (1.0 - opacity));
}
vec3 blendPhoenix(vec3 base, vec3 blend) {
    return min(base, blend)-max(base, blend)+vec3(1.0);
}
vec3 blendPhoenix(vec3 base, vec3 blend, float opacity) {
    return (blendPhoenix(base, blend) * opacity + base * (1.0 - opacity));
}
vec3 blendNormal(vec3 base, vec3 blend) {
    return blend;
}
vec3 blendNormal(vec3 base, vec3 blend, float opacity) {
    return (blendNormal(base, blend) * opacity + base * (1.0 - opacity));
}
vec3 blendNegation(vec3 base, vec3 blend) {
    return vec3(1.0)-abs(vec3(1.0)-base-blend);
}
vec3 blendNegation(vec3 base, vec3 blend, float opacity) {
    return (blendNegation(base, blend) * opacity + base * (1.0 - opacity));
}
vec3 blendMultiply(vec3 base, vec3 blend) {
    return base*blend;
}
vec3 blendMultiply(vec3 base, vec3 blend, float opacity) {
    return (blendMultiply(base, blend) * opacity + base * (1.0 - opacity));
}
vec3 blendAverage(vec3 base, vec3 blend) {
    return (base+blend)/2.0;
}
vec3 blendAverage(vec3 base, vec3 blend, float opacity) {
    return (blendAverage(base, blend) * opacity + base * (1.0 - opacity));
}
float blendScreen(float base, float blend) {
    return 1.0-((1.0-base)*(1.0-blend));
}
vec3 blendScreen(vec3 base, vec3 blend) {
    return vec3(blendScreen(base.r, blend.r), blendScreen(base.g, blend.g), blendScreen(base.b, blend.b));
}
vec3 blendScreen(vec3 base, vec3 blend, float opacity) {
    return (blendScreen(base, blend) * opacity + base * (1.0 - opacity));
}
float blendSoftLight(float base, float blend) {
    return (blend<0.5)?(2.0*base*blend+base*base*(1.0-2.0*blend)):(sqrt(base)*(2.0*blend-1.0)+2.0*base*(1.0-blend));
}
vec3 blendSoftLight(vec3 base, vec3 blend) {
    return vec3(blendSoftLight(base.r, blend.r), blendSoftLight(base.g, blend.g), blendSoftLight(base.b, blend.b));
}
vec3 blendSoftLight(vec3 base, vec3 blend, float opacity) {
    return (blendSoftLight(base, blend) * opacity + base * (1.0 - opacity));
}
float blendSubtract(float base, float blend) {
    return max(base+blend-1.0, 0.0);
}
vec3 blendSubtract(vec3 base, vec3 blend) {
    return max(base+blend-vec3(1.0), vec3(0.0));
}
vec3 blendSubtract(vec3 base, vec3 blend, float opacity) {
    return (blendSubtract(base, blend) * opacity + base * (1.0 - opacity));
}
vec3 blendExclusion(vec3 base, vec3 blend) {
    return base+blend-2.0*base*blend;
}
vec3 blendExclusion(vec3 base, vec3 blend, float opacity) {
    return (blendExclusion(base, blend) * opacity + base * (1.0 - opacity));
}
vec3 blendDifference(vec3 base, vec3 blend) {
    return abs(base-blend);
}
vec3 blendDifference(vec3 base, vec3 blend, float opacity) {
    return (blendDifference(base, blend) * opacity + base * (1.0 - opacity));
}
float blendAdd(float base, float blend) {
    return min(base+blend, 1.0);
}
vec3 blendAdd(vec3 base, vec3 blend) {
    return min(base+blend, vec3(1.0));
}
vec3 blendAdd(vec3 base, vec3 blend, float opacity) {
    return (blendAdd(base, blend) * opacity + base * (1.0 - opacity));
}{@}conditionals.glsl{@}vec4 when_eq(vec4 x, vec4 y) {
  return 1.0 - abs(sign(x - y));
}

vec4 when_neq(vec4 x, vec4 y) {
  return abs(sign(x - y));
}

vec4 when_gt(vec4 x, vec4 y) {
  return max(sign(x - y), 0.0);
}

vec4 when_lt(vec4 x, vec4 y) {
  return max(sign(y - x), 0.0);
}

vec4 when_ge(vec4 x, vec4 y) {
  return 1.0 - when_lt(x, y);
}

vec4 when_le(vec4 x, vec4 y) {
  return 1.0 - when_gt(x, y);
}

vec3 when_eq(vec3 x, vec3 y) {
  return 1.0 - abs(sign(x - y));
}

vec3 when_neq(vec3 x, vec3 y) {
  return abs(sign(x - y));
}

vec3 when_gt(vec3 x, vec3 y) {
  return max(sign(x - y), 0.0);
}

vec3 when_lt(vec3 x, vec3 y) {
  return max(sign(y - x), 0.0);
}

vec3 when_ge(vec3 x, vec3 y) {
  return 1.0 - when_lt(x, y);
}

vec3 when_le(vec3 x, vec3 y) {
  return 1.0 - when_gt(x, y);
}

vec2 when_eq(vec2 x, vec2 y) {
  return 1.0 - abs(sign(x - y));
}

vec2 when_neq(vec2 x, vec2 y) {
  return abs(sign(x - y));
}

vec2 when_gt(vec2 x, vec2 y) {
  return max(sign(x - y), 0.0);
}

vec2 when_lt(vec2 x, vec2 y) {
  return max(sign(y - x), 0.0);
}

vec2 when_ge(vec2 x, vec2 y) {
  return 1.0 - when_lt(x, y);
}

vec2 when_le(vec2 x, vec2 y) {
  return 1.0 - when_gt(x, y);
}

float when_eq(float x, float y) {
  return 1.0 - abs(sign(x - y));
}

float when_neq(float x, float y) {
  return abs(sign(x - y));
}

float when_gt(float x, float y) {
  return max(sign(x - y), 0.0);
}

float when_lt(float x, float y) {
  return max(sign(y - x), 0.0);
}

float when_ge(float x, float y) {
  return 1.0 - when_lt(x, y);
}

float when_le(float x, float y) {
  return 1.0 - when_gt(x, y);
}

vec4 and(vec4 a, vec4 b) {
  return a * b;
}

vec4 or(vec4 a, vec4 b) {
  return min(a + b, 1.0);
}

vec4 Not(vec4 a) {
  return 1.0 - a;
}

vec3 and(vec3 a, vec3 b) {
  return a * b;
}

vec3 or(vec3 a, vec3 b) {
  return min(a + b, 1.0);
}

vec3 Not(vec3 a) {
  return 1.0 - a;
}

vec2 and(vec2 a, vec2 b) {
  return a * b;
}

vec2 or(vec2 a, vec2 b) {
  return min(a + b, 1.0);
}


vec2 Not(vec2 a) {
  return 1.0 - a;
}

float and(float a, float b) {
  return a * b;
}

float or(float a, float b) {
  return min(a + b, 1.0);
}

float Not(float a) {
  return 1.0 - a;
}{@}curl.glsl{@}float CNrange(float oldValue, float oldMin, float oldMax, float newMin, float newMax) {
    float oldRange = oldMax - oldMin;
    float newRange = newMax - newMin;
    return (((oldValue - oldMin) * newRange) / oldRange) + newMin;
}

float CNnoise(vec3 v) {
    float t = v.z * 0.3;
    v.y *= 0.8;
    float noise = 0.0;
    float s = 0.5;
    noise += CNrange(sin(v.x * 0.9 / s + t * 10.0) + sin(v.x * 2.4 / s + t * 15.0) + sin(v.x * -3.5 / s + t * 4.0) + sin(v.x * -2.5 / s + t * 7.1), -1.0, 1.0, -0.3, 0.3);
    noise += CNrange(sin(v.y * -0.3 / s + t * 18.0) + sin(v.y * 1.6 / s + t * 18.0) + sin(v.y * 2.6 / s + t * 8.0) + sin(v.y * -2.6 / s + t * 4.5), -1.0, 1.0, -0.3, 0.3);
    return noise;
}

vec3 snoiseVec3( vec3 x ){
    
    float s  = CNnoise(vec3( x ));
    float s1 = CNnoise(vec3( x.y - 19.1 , x.z + 33.4 , x.x + 47.2 ));
    float s2 = CNnoise(vec3( x.z + 74.2 , x.x - 124.5 , x.y + 99.4 ));
    vec3 c = vec3( s , s1 , s2 );
    return c;
    
}

vec3 curlNoise( vec3 p ){
    
    const float e = 1e-1;
    vec3 dx = vec3( e   , 0.0 , 0.0 );
    vec3 dy = vec3( 0.0 , e   , 0.0 );
    vec3 dz = vec3( 0.0 , 0.0 , e   );
    
    vec3 p_x0 = snoiseVec3( p - dx );
    vec3 p_x1 = snoiseVec3( p + dx );
    vec3 p_y0 = snoiseVec3( p - dy );
    vec3 p_y1 = snoiseVec3( p + dy );
    vec3 p_z0 = snoiseVec3( p - dz );
    vec3 p_z1 = snoiseVec3( p + dz );
    
    float x = p_y1.z - p_y0.z - p_z1.y + p_z0.y;
    float y = p_z1.x - p_z0.x - p_x1.z + p_x0.z;
    float z = p_x1.y - p_x0.y - p_y1.x + p_y0.x;
    
    const float divisor = 1.0 / ( 2.0 * e );
    return normalize( vec3( x , y , z ) * divisor );
}{@}depthvalue.fs{@}float getDepthValue(sampler2D tDepth, vec2 uv, float n, float f) {
    vec4 depth = texture2D(tDepth, uv);
    return (2.0 * n) / (f + n - depth.x * (f - n));
}{@}dither.fs{@}highp float rand(vec2 co) {
    highp float a = 12.9898;
    highp float b = 78.233;
    highp float c = 43758.5453;
    highp float dt = dot(co.xy, vec2(a, b));
    highp float sn = mod(dt, 3.14);
    return fract(sin(sn) * c);
}

vec3 dither(vec3 color) {
    float grid_position = rand(gl_FragCoord.xy);
    vec3 dither_shift_RGB = vec3(0.25 / 255.0, -0.25 / 255.0, 0.25 / 255.0);
    dither_shift_RGB = mix(2.0 * dither_shift_RGB, -2.0 * dither_shift_RGB, grid_position);
    return color + dither_shift_RGB;
}{@}eases.glsl{@}#ifndef PI
#define PI 3.141592653589793
#endif

#ifndef HALF_PI
#define HALF_PI 1.5707963267948966
#endif

float backInOut(float t) {
  float f = t < 0.5
    ? 2.0 * t
    : 1.0 - (2.0 * t - 1.0);

  float g = pow(f, 3.0) - f * sin(f * PI);

  return t < 0.5
    ? 0.5 * g
    : 0.5 * (1.0 - g) + 0.5;
}

float backIn(float t) {
  return pow(t, 3.0) - t * sin(t * PI);
}

float backOut(float t) {
  float f = 1.0 - t;
  return 1.0 - (pow(f, 3.0) - f * sin(f * PI));
}

float bounceOut(float t) {
  const float a = 4.0 / 11.0;
  const float b = 8.0 / 11.0;
  const float c = 9.0 / 10.0;

  const float ca = 4356.0 / 361.0;
  const float cb = 35442.0 / 1805.0;
  const float cc = 16061.0 / 1805.0;

  float t2 = t * t;

  return t < a
    ? 7.5625 * t2
    : t < b
      ? 9.075 * t2 - 9.9 * t + 3.4
      : t < c
        ? ca * t2 - cb * t + cc
        : 10.8 * t * t - 20.52 * t + 10.72;
}

float bounceIn(float t) {
  return 1.0 - bounceOut(1.0 - t);
}

float bounceInOut(float t) {
  return t < 0.5
    ? 0.5 * (1.0 - bounceOut(1.0 - t * 2.0))
    : 0.5 * bounceOut(t * 2.0 - 1.0) + 0.5;
}

float circularInOut(float t) {
  return t < 0.5
    ? 0.5 * (1.0 - sqrt(1.0 - 4.0 * t * t))
    : 0.5 * (sqrt((3.0 - 2.0 * t) * (2.0 * t - 1.0)) + 1.0);
}

float circularIn(float t) {
  return 1.0 - sqrt(1.0 - t * t);
}

float circularOut(float t) {
  return sqrt((2.0 - t) * t);
}

float cubicInOut(float t) {
  return t < 0.5
    ? 4.0 * t * t * t
    : 0.5 * pow(2.0 * t - 2.0, 3.0) + 1.0;
}

float cubicIn(float t) {
  return t * t * t;
}

float cubicOut(float t) {
  float f = t - 1.0;
  return f * f * f + 1.0;
}

float elasticInOut(float t) {
  return t < 0.5
    ? 0.5 * sin(+13.0 * HALF_PI * 2.0 * t) * pow(2.0, 10.0 * (2.0 * t - 1.0))
    : 0.5 * sin(-13.0 * HALF_PI * ((2.0 * t - 1.0) + 1.0)) * pow(2.0, -10.0 * (2.0 * t - 1.0)) + 1.0;
}

float elasticIn(float t) {
  return sin(13.0 * t * HALF_PI) * pow(2.0, 10.0 * (t - 1.0));
}

float elasticOut(float t) {
  return sin(-13.0 * (t + 1.0) * HALF_PI) * pow(2.0, -10.0 * t) + 1.0;
}

float expoInOut(float t) {
  return t == 0.0 || t == 1.0
    ? t
    : t < 0.5
      ? +0.5 * pow(2.0, (20.0 * t) - 10.0)
      : -0.5 * pow(2.0, 10.0 - (t * 20.0)) + 1.0;
}

float expoIn(float t) {
  return t == 0.0 ? t : pow(2.0, 10.0 * (t - 1.0));
}

float expoOut(float t) {
  return t == 1.0 ? t : 1.0 - pow(2.0, -10.0 * t);
}

float linear(float t) {
  return t;
}

float quadraticInOut(float t) {
  float p = 2.0 * t * t;
  return t < 0.5 ? p : -p + (4.0 * t) - 1.0;
}

float quadraticIn(float t) {
  return t * t;
}

float quadraticOut(float t) {
  return -t * (t - 2.0);
}

float quarticInOut(float t) {
  return t < 0.5
    ? +8.0 * pow(t, 4.0)
    : -8.0 * pow(t - 1.0, 4.0) + 1.0;
}

float quarticIn(float t) {
  return pow(t, 4.0);
}

float quarticOut(float t) {
  return pow(t - 1.0, 3.0) * (1.0 - t) + 1.0;
}

float qinticInOut(float t) {
  return t < 0.5
    ? +16.0 * pow(t, 5.0)
    : -0.5 * pow(2.0 * t - 2.0, 5.0) + 1.0;
}

float qinticIn(float t) {
  return pow(t, 5.0);
}

float qinticOut(float t) {
  return 1.0 - (pow(t - 1.0, 5.0));
}

float sineInOut(float t) {
  return -0.5 * (cos(PI * t) - 1.0);
}

float sineIn(float t) {
  return sin((t - 1.0) * HALF_PI) + 1.0;
}

float sineOut(float t) {
  return sin(t * HALF_PI);
}
{@}ColorMaterial.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 color;

#!VARYINGS

#!SHADER: ColorMaterial.vs
void main() {
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: ColorMaterial.fs
void main() {
    gl_FragColor = vec4(color, 1.0);
}{@}DebugCamera.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 uColor;

#!VARYINGS
varying vec3 vColor;

#!SHADER: DebugCamera.vs
void main() {
    vColor = mix(uColor, vec3(1.0, 0.0, 0.0), step(position.z, -0.1));
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: DebugCamera.fs
void main() {
    gl_FragColor = vec4(vColor, 1.0);
}{@}ScreenQuad.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;

#!VARYINGS
varying vec2 vUv;

#!SHADER: ScreenQuad.vs
void main() {
    vUv = uv;
    gl_Position = vec4(position, 1.0);
}

#!SHADER: ScreenQuad.fs
void main() {
    gl_FragColor = texture2D(tMap, vUv);
    gl_FragColor.a = 1.0;
}{@}TestMaterial.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform float alpha;

#!VARYINGS
varying vec3 vNormal;

#!SHADER: TestMaterial.vs
void main() {
    vec3 pos = position;
    vNormal = normalMatrix * normal;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: TestMaterial.fs
void main() {
    gl_FragColor = vec4(vNormal, 1.0);
}{@}TextureMaterial.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;

#!VARYINGS
varying vec2 vUv;

#!SHADER: TextureMaterial.vs
void main() {
    vUv = uv;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: TextureMaterial.fs
void main() {
    gl_FragColor = texture2D(tMap, vUv);
    gl_FragColor.rgb /= gl_FragColor.a;
}{@}BlitPass.fs{@}void main() {
    gl_FragColor = texture2D(tDiffuse, vUv);
    gl_FragColor.a = 1.0;
}{@}NukePass.vs{@}varying vec2 vUv;

void main() {
    vUv = uv;
    gl_Position = vec4(position, 1.0);
}{@}ShadowDepth.glsl{@}#!ATTRIBUTES

#!UNIFORMS

#!VARYINGS

#!SHADER: ShadowDepth.vs
void main() {
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: ShadowDepth.fs
void main() {
    gl_FragColor = vec4(vec3(gl_FragCoord.x), 1.0);
}{@}instance.vs{@}vec3 transformNormal(vec3 n, vec4 orientation) {
    vec3 nn = n + 2.0 * cross(orientation.xyz, cross(orientation.xyz, n) + orientation.w * n);
    return nn;
}

vec3 transformPosition(vec3 position, vec3 offset, vec3 scale, vec4 orientation) {
    vec3 _pos = position;
    _pos *= scale;

    _pos = _pos + 2.0 * cross(orientation.xyz, cross(orientation.xyz, _pos) + orientation.w * _pos);
    _pos += offset;
    return _pos;
}

vec3 transformPosition(vec3 position, vec3 offset, vec4 orientation) {
    vec3 _pos = position;

    _pos = _pos + 2.0 * cross(orientation.xyz, cross(orientation.xyz, _pos) + orientation.w * _pos);
    _pos += offset;
    return _pos;
}

vec3 transformPosition(vec3 position, vec3 offset, float scale, vec4 orientation) {
    return transformPosition(position, offset, vec3(scale), orientation);
}

vec3 transformPosition(vec3 position, vec3 offset) {
    return position + offset;
}

vec3 transformPosition(vec3 position, vec3 offset, float scale) {
    vec3 pos = position * scale;
    return pos + offset;
}

vec3 transformPosition(vec3 position, vec3 offset, vec3 scale) {
    vec3 pos = position * scale;
    return pos + offset;
}{@}lights.fs{@}vec3 worldLight(vec3 pos, vec3 vpos) {
    vec4 mvPos = modelViewMatrix * vec4(vpos, 1.0);
    vec4 worldPosition = viewMatrix * vec4(pos, 1.0);
    return worldPosition.xyz - mvPos.xyz;
}{@}lights.vs{@}vec3 worldLight(vec3 pos) {
    vec4 mvPos = modelViewMatrix * vec4(position, 1.0);
    vec4 worldPosition = viewMatrix * vec4(pos, 1.0);
    return worldPosition.xyz - mvPos.xyz;
}

vec3 worldLight(vec3 lightPos, vec3 localPos) {
    vec4 mvPos = modelViewMatrix * vec4(localPos, 1.0);
    vec4 worldPosition = viewMatrix * vec4(lightPos, 1.0);
    return worldPosition.xyz - mvPos.xyz;
}{@}shadows.fs{@}float shadowCompare(sampler2D map, vec2 coords, float compare) {
    return step(compare, texture2D(map, coords).r);
}

float shadowLerp(sampler2D map, vec2 coords, float compare, float size) {
    const vec2 offset = vec2(0.0, 1.0);

    vec2 texelSize = vec2(1.0) / size;
    vec2 centroidUV = floor(coords * size + 0.5) / size;

    float lb = shadowCompare(map, centroidUV + texelSize * offset.xx, compare);
    float lt = shadowCompare(map, centroidUV + texelSize * offset.xy, compare);
    float rb = shadowCompare(map, centroidUV + texelSize * offset.yx, compare);
    float rt = shadowCompare(map, centroidUV + texelSize * offset.yy, compare);

    vec2 f = fract( coords * size + 0.5 );

    float a = mix( lb, lt, f.y );
    float b = mix( rb, rt, f.y );
    float c = mix( a, b, f.x );

    return c;
}

float srange(float oldValue, float oldMin, float oldMax, float newMin, float newMax) {
    float oldRange = oldMax - oldMin;
    float newRange = newMax - newMin;
    return (((oldValue - oldMin) * newRange) / oldRange) + newMin;
}

float shadowrandom(vec3 vin) {
    vec3 v = vin * 0.1;
    float t = v.z * 0.3;
    v.y *= 0.8;
    float noise = 0.0;
    float s = 0.5;
    noise += srange(sin(v.x * 0.9 / s + t * 10.0) + sin(v.x * 2.4 / s + t * 15.0) + sin(v.x * -3.5 / s + t * 4.0) + sin(v.x * -2.5 / s + t * 7.1), -1.0, 1.0, -0.3, 0.3);
    noise += srange(sin(v.y * -0.3 / s + t * 18.0) + sin(v.y * 1.6 / s + t * 18.0) + sin(v.y * 2.6 / s + t * 8.0) + sin(v.y * -2.6 / s + t * 4.5), -1.0, 1.0, -0.3, 0.3);
    return noise;
}

float shadowLookup(sampler2D map, vec3 coords, float size, float compare, vec3 wpos) {
    float shadow = 1.0;

    #if defined(SHADOW_MAPS)
    bool frustumTest = coords.x >= 0.0 && coords.x <= 1.0 && coords.y >= 0.0 && coords.y <= 1.0 && coords.z <= 1.0;
    if (frustumTest) {
        vec2 texelSize = vec2(1.0) / size;

        float dx0 = -texelSize.x;
        float dy0 = -texelSize.y;
        float dx1 = +texelSize.x;
        float dy1 = +texelSize.y;

        float rnoise = shadowrandom(wpos) * 0.00015;
        dx0 += rnoise;
        dy0 -= rnoise;
        dx1 += rnoise;
        dy1 -= rnoise;

        #if defined(SHADOWS_MED)
        shadow += shadowCompare(map, coords.xy + vec2(0.0, dy0), compare);
        //        shadow += shadowCompare(map, coords.xy + vec2(dx1, dy0), compare);
        shadow += shadowCompare(map, coords.xy + vec2(dx0, 0.0), compare);
        shadow += shadowCompare(map, coords.xy, compare);
        shadow += shadowCompare(map, coords.xy + vec2(dx1, 0.0), compare);
        //        shadow += shadowCompare(map, coords.xy + vec2(dx0, dy1), compare);
        shadow += shadowCompare(map, coords.xy + vec2(0.0, dy1), compare);
        shadow /= 5.0;

        #elif defined(SHADOWS_HIGH)
        shadow = shadowLerp(map, coords.xy + vec2(dx0, dy0), compare, size);
        shadow += shadowLerp(map, coords.xy + vec2(0.0, dy0), compare, size);
        shadow += shadowLerp(map, coords.xy + vec2(dx1, dy0), compare, size);
        shadow += shadowLerp(map, coords.xy + vec2(dx0, 0.0), compare, size);
        shadow += shadowLerp(map, coords.xy, compare, size);
        shadow += shadowLerp(map, coords.xy + vec2(dx1, 0.0), compare, size);
        shadow += shadowLerp(map, coords.xy + vec2(dx0, dy1), compare, size);
        shadow += shadowLerp(map, coords.xy + vec2(0.0, dy1), compare, size);
        shadow += shadowLerp(map, coords.xy + vec2(dx1, dy1), compare, size);
        shadow /= 9.0;

        #else
        shadow = shadowCompare(map, coords.xy, compare);
        #endif
    }

        #endif

    return clamp(shadow, 0.0, 1.0);
}

#test !!window.Metal
vec3 transformShadowLight(vec3 pos, vec3 vpos, mat4 mvMatrix, mat4 viewMatrix) {
    vec4 mvPos = mvMatrix * vec4(vpos, 1.0);
    vec4 worldPosition = viewMatrix * vec4(pos, 1.0);
    return normalize(worldPosition.xyz - mvPos.xyz);
}

float getShadow(vec3 pos, vec3 normal, float bias, Uniforms uniforms, GlobalUniforms globalUniforms, sampler2D shadowMap) {
    float shadow = 1.0;
    #if defined(SHADOW_MAPS)

    vec4 shadowMapCoords;
    vec3 coords;
    float lookup;

    for (int i = 0; i < SHADOW_COUNT; i++) {
        shadowMapCoords = uniforms.shadowMatrix[i] * vec4(pos, 1.0);
        coords = (shadowMapCoords.xyz / shadowMapCoords.w) * vec3(0.5) + vec3(0.5);

        lookup = shadowLookup(shadowMap, coords, uniforms.shadowSize[i], coords.z - bias, pos);
        lookup += mix(1.0 - step(0.002, dot(transformShadowLight(uniforms.shadowLightPos[i], pos, uniforms.modelViewMatrix, globalUniforms.viewMatrix), normal)), 0.0, step(999.0, normal.x));
        shadow *= clamp(lookup, 0.0, 1.0);
    }

    #endif
    return shadow;
}

float getShadow(vec3 pos, vec3 normal, Uniforms uniforms, GlobalUniforms globalUniforms, sampler2D shadowMap) {
    return getShadow(pos, normal, 0.0, uniforms, globalUniforms, shadowMap);
}

float getShadow(vec3 pos, float bias, Uniforms uniforms, GlobalUniforms globalUniforms, sampler2D shadowMap) {
    return getShadow(pos, vec3(99999.0), bias, uniforms, globalUniforms, shadowMap);
}

float getShadow(vec3 pos, Uniforms uniforms, GlobalUniforms globalUniforms, sampler2D shadowMap) {
    return getShadow(pos, vec3(99999.0), 0.0, uniforms, globalUniforms, shadowMap);
}

float getShadow(vec3 pos, vec3 normal) {
    return 1.0;
}

float getShadow(vec3 pos, float bias) {
    return 1.0;
}

float getShadow(vec3 pos) {
    return 1.0;
}
#endtest

#test !window.Metal
vec3 transformShadowLight(vec3 pos, vec3 vpos) {
    vec4 mvPos = modelViewMatrix * vec4(vpos, 1.0);
    vec4 worldPosition = viewMatrix * vec4(pos, 1.0);
    return normalize(worldPosition.xyz - mvPos.xyz);
}

float getShadow(vec3 pos, vec3 normal, float bias) {
    float shadow = 1.0;
    #if defined(SHADOW_MAPS)

    vec4 shadowMapCoords;
    vec3 coords;
    float lookup;

    #pragma unroll_loop
    for (int i = 0; i < SHADOW_COUNT; i++) {
        shadowMapCoords = shadowMatrix[i] * vec4(pos, 1.0);
        coords = (shadowMapCoords.xyz / shadowMapCoords.w) * vec3(0.5) + vec3(0.5);

        lookup = shadowLookup(shadowMap[i], coords, shadowSize[i], coords.z - bias, pos);
        lookup += mix(1.0 - step(0.002, dot(transformShadowLight(shadowLightPos[i], pos), normal)), 0.0, step(999.0, normal.x));
        shadow *= clamp(lookup, 0.0, 1.0);
    }

    #endif
    return shadow;
}

float getShadow(vec3 pos, vec3 normal) {
    return getShadow(pos, normal, 0.0);
}

float getShadow(vec3 pos, float bias) {
    return getShadow(pos, vec3(99999.0), bias);
}

float getShadow(vec3 pos) {
    return getShadow(pos, vec3(99999.0), 0.0);
}
#endtest{@}FXAA.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMask;

#!VARYINGS
varying vec2 v_rgbNW;
varying vec2 v_rgbNE;
varying vec2 v_rgbSW;
varying vec2 v_rgbSE;
varying vec2 v_rgbM;

#!SHADER: FXAA.vs

varying vec2 vUv;

void main() {
    vUv = uv;

    vec2 fragCoord = uv * resolution;
    vec2 inverseVP = 1.0 / resolution.xy;
    v_rgbNW = (fragCoord + vec2(-1.0, -1.0)) * inverseVP;
    v_rgbNE = (fragCoord + vec2(1.0, -1.0)) * inverseVP;
    v_rgbSW = (fragCoord + vec2(-1.0, 1.0)) * inverseVP;
    v_rgbSE = (fragCoord + vec2(1.0, 1.0)) * inverseVP;
    v_rgbM = vec2(fragCoord * inverseVP);

    gl_Position = vec4(position, 1.0);
}

#!SHADER: FXAA.fs

#require(conditionals.glsl)

#ifndef FXAA_REDUCE_MIN
    #define FXAA_REDUCE_MIN   (1.0/ 128.0)
#endif
#ifndef FXAA_REDUCE_MUL
    #define FXAA_REDUCE_MUL   (1.0 / 8.0)
#endif
#ifndef FXAA_SPAN_MAX
    #define FXAA_SPAN_MAX     8.0
#endif

vec4 fxaa(sampler2D tex, vec2 fragCoord, vec2 resolution,
            vec2 v_rgbNW, vec2 v_rgbNE,
            vec2 v_rgbSW, vec2 v_rgbSE,
            vec2 v_rgbM) {
    vec4 color;
    mediump vec2 inverseVP = vec2(1.0 / resolution.x, 1.0 / resolution.y);
    vec3 rgbNW = texture2D(tex, v_rgbNW).xyz;
    vec3 rgbNE = texture2D(tex, v_rgbNE).xyz;
    vec3 rgbSW = texture2D(tex, v_rgbSW).xyz;
    vec3 rgbSE = texture2D(tex, v_rgbSE).xyz;
    vec4 texColor = texture2D(tex, v_rgbM);
    vec3 rgbM  = texColor.xyz;
    vec3 luma = vec3(0.299, 0.587, 0.114);
    float lumaNW = dot(rgbNW, luma);
    float lumaNE = dot(rgbNE, luma);
    float lumaSW = dot(rgbSW, luma);
    float lumaSE = dot(rgbSE, luma);
    float lumaM  = dot(rgbM,  luma);
    float lumaMin = min(lumaM, min(min(lumaNW, lumaNE), min(lumaSW, lumaSE)));
    float lumaMax = max(lumaM, max(max(lumaNW, lumaNE), max(lumaSW, lumaSE)));

    mediump vec2 dir;
    dir.x = -((lumaNW + lumaNE) - (lumaSW + lumaSE));
    dir.y =  ((lumaNW + lumaSW) - (lumaNE + lumaSE));

    float dirReduce = max((lumaNW + lumaNE + lumaSW + lumaSE) *
                          (0.25 * FXAA_REDUCE_MUL), FXAA_REDUCE_MIN);

    float rcpDirMin = 1.0 / (min(abs(dir.x), abs(dir.y)) + dirReduce);
    dir = min(vec2(FXAA_SPAN_MAX, FXAA_SPAN_MAX),
              max(vec2(-FXAA_SPAN_MAX, -FXAA_SPAN_MAX),
              dir * rcpDirMin)) * inverseVP;

    vec3 rgbA = 0.5 * (
        texture2D(tex, fragCoord * inverseVP + dir * (1.0 / 3.0 - 0.5)).xyz +
        texture2D(tex, fragCoord * inverseVP + dir * (2.0 / 3.0 - 0.5)).xyz);
    vec3 rgbB = rgbA * 0.5 + 0.25 * (
        texture2D(tex, fragCoord * inverseVP + dir * -0.5).xyz +
        texture2D(tex, fragCoord * inverseVP + dir * 0.5).xyz);

    float lumaB = dot(rgbB, luma);

    color = vec4(rgbB, texColor.a);
    color = mix(color, vec4(rgbA, texColor.a), when_lt(lumaB, lumaMin));
    color = mix(color, vec4(rgbA, texColor.a), when_gt(lumaB, lumaMax));

    return color;
}

void main() {
    vec2 fragCoord = vUv * resolution;
    float mask = texture2D(tMask, vUv).r;
    if (mask < 0.5) {
        gl_FragColor = fxaa(tDiffuse, fragCoord, resolution, v_rgbNW, v_rgbNE, v_rgbSW, v_rgbSE, v_rgbM);
    } else {
        gl_FragColor = texture2D(tDiffuse, vUv);
    }
    gl_FragColor.a = 1.0;
}
{@}glscreenprojection.glsl{@}vec2 frag_coord(vec4 glPos) {
    return ((glPos.xyz / glPos.w) * 0.5 + 0.5).xy;
}

vec2 getProjection(vec3 pos, mat4 projMatrix) {
    vec4 mvpPos = projMatrix * vec4(pos, 1.0);
    return frag_coord(mvpPos);
}

void applyNormal(inout vec3 pos, mat4 projNormalMatrix) {
    vec3 transformed = vec3(projNormalMatrix * vec4(pos, 0.0));
    pos = transformed;
}{@}DefaultText.glsl{@}#!ATTRIBUTES

#!UNIFORMS

uniform sampler2D tMap;
uniform vec3 uColor;
uniform float uAlpha;

#!VARYINGS

varying vec2 vUv;

#!SHADER: DefaultText.vs

void main() {
    vUv = uv;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: DefaultText.fs

#require(msdf.glsl)

void main() {
    float alpha = msdf(tMap, vUv);

    gl_FragColor.rgb = uColor;
    gl_FragColor.a = alpha * uAlpha;
}
{@}msdf.glsl{@}float msdf(sampler2D tMap, vec2 uv) {
    vec3 tex = texture2D(tMap, uv).rgb;
    float signedDist = max(min(tex.r, tex.g), min(max(tex.r, tex.g), tex.b)) - 0.5;

    // TODO: fallback for fwidth for webgl1 (need to enable ext)
    float d = fwidth(signedDist);
    float alpha = smoothstep(-d, d, signedDist);
    if (alpha < 0.01) discard;
    return alpha;
}

float strokemsdf(sampler2D tMap, vec2 uv, float stroke, float padding) {
    vec3 tex = texture2D(tMap, uv).rgb;
    float signedDist = max(min(tex.r, tex.g), min(max(tex.r, tex.g), tex.b)) - 0.5;
    float t = stroke;
    float alpha = smoothstep(-t, -t + padding, signedDist) * smoothstep(t, t - padding, signedDist);
    return alpha;
}{@}GLUIBatch.glsl{@}#!ATTRIBUTES
attribute vec3 offset;
attribute vec2 scale;
attribute float rotation;
//attributes

#!UNIFORMS
uniform sampler2D tMap;
uniform vec3 uColor;
uniform float uAlpha;

#!VARYINGS
varying vec2 vUv;
//varyings

#!SHADER: Vertex

mat4 rotationMatrix(vec3 axis, float angle) {
    axis = normalize(axis);
    float s = sin(angle);
    float c = cos(angle);
    float oc = 1.0 - c;

    return mat4(oc * axis.x * axis.x + c,           oc * axis.x * axis.y - axis.z * s,  oc * axis.z * axis.x + axis.y * s,  0.0,
    oc * axis.x * axis.y + axis.z * s,  oc * axis.y * axis.y + c,           oc * axis.y * axis.z - axis.x * s,  0.0,
    oc * axis.z * axis.x - axis.y * s,  oc * axis.y * axis.z + axis.x * s,  oc * axis.z * axis.z + c,           0.0,
    0.0,                                0.0,                                0.0,                                1.0);
}

void main() {
    vUv = uv;
    //vdefines

    vec3 pos = vec3(rotationMatrix(vec3(0.0, 0.0, 1.0), rotation) * vec4(position, 1.0));
    pos.xy *= scale;
    pos.xyz += offset;

    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment
void main() {
    gl_FragColor = vec4(1.0);
}{@}GLUIBatchText.glsl{@}#!ATTRIBUTES
attribute vec2 offset;
attribute vec2 scale;
attribute float rotation;
//attributes

#!UNIFORMS
uniform sampler2D tMap;
uniform vec3 uColor;
uniform float uAlpha;

#!VARYINGS
varying vec2 vUv;
//varyings

#!SHADER: Vertex

mat4 rotationMatrix(vec3 axis, float angle) {
    axis = normalize(axis);
    float s = sin(angle);
    float c = cos(angle);
    float oc = 1.0 - c;

    return mat4(oc * axis.x * axis.x + c,           oc * axis.x * axis.y - axis.z * s,  oc * axis.z * axis.x + axis.y * s,  0.0,
    oc * axis.x * axis.y + axis.z * s,  oc * axis.y * axis.y + c,           oc * axis.y * axis.z - axis.x * s,  0.0,
    oc * axis.z * axis.x - axis.y * s,  oc * axis.y * axis.z + axis.x * s,  oc * axis.z * axis.z + c,           0.0,
    0.0,                                0.0,                                0.0,                                1.0);
}

void main() {
    vUv = uv;
    //vdefines

    vec3 pos = vec3(rotationMatrix(vec3(0.0, 0.0, 1.0), rotation) * vec4(position, 1.0));
    pos.xy *= scale;
    pos.xy += offset;

    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment

#require(msdf.glsl)

void main() {
    float alpha = msdf(tMap, vUv);

    gl_FragColor.rgb = v_uColor;
    gl_FragColor.a = alpha * v_uAlpha;
}
{@}GLUIColor.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 uColor;
uniform float uAlpha;

#!VARYINGS
varying vec2 vUv;

#!SHADER: GLUIColor.vs
void main() {
    vUv = uv;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: GLUIColor.fs
void main() {
    vec2 uv = vUv;
    vec3 uvColor = vec3(uv, 1.0);
    gl_FragColor = vec4(mix(uColor, uvColor, 0.0), uAlpha);
}{@}GLUIObject.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform float uAlpha;

#!VARYINGS
varying vec2 vUv;

#!SHADER: GLUIObject.vs
void main() {
    vUv = uv;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: GLUIObject.fs
void main() {
    gl_FragColor = texture2D(tMap, vUv);
    gl_FragColor.a *= uAlpha;
}{@}GLUIObjectMask.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform float uAlpha;
uniform vec4 mask;

#!VARYINGS
varying vec2 vUv;
varying vec2 vWorldPos;

#!SHADER: GLUIObjectMask.vs
void main() {
    vUv = uv;
    vWorldPos = (modelMatrix * vec4(position.xy, 0.0, 1.0)).xy;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: GLUIObjectMask.fs
void main() {
    gl_FragColor = texture2D(tMap, vUv);
    gl_FragColor.a *= uAlpha;

    if (vWorldPos.x > mask.x + mask.z) discard;
    if (vWorldPos.x < mask.x) discard;
    if (vWorldPos.y > mask.y) discard;
    if (vWorldPos.y < mask.y - mask.w) discard;
}{@}luma.fs{@}float luma(vec3 color) {
  return dot(color, vec3(0.299, 0.587, 0.114));
}

float luma(vec4 color) {
  return dot(color.rgb, vec3(0.299, 0.587, 0.114));
}{@}matcap.vs{@}vec2 reflectMatcap(vec3 position, mat4 modelViewMatrix, mat3 normalMatrix, vec3 normal) {
    vec4 p = vec4(position, 1.0);
    
    vec3 e = normalize(vec3(modelViewMatrix * p));
    vec3 n = normalize(normalMatrix * normal);
    vec3 r = reflect(e, n);
    float m = 2.0 * sqrt(
        pow(r.x, 2.0) +
        pow(r.y, 2.0) +
        pow(r.z + 1.0, 2.0)
    );
    
    vec2 uv = r.xy / m + .5;
    
    return uv;
}

vec2 reflectMatcap(vec3 position, mat4 modelViewMatrix, vec3 normal) {
    vec4 p = vec4(position, 1.0);
    
    vec3 e = normalize(vec3(modelViewMatrix * p));
    vec3 n = normalize(normal);
    vec3 r = reflect(e, n);
    float m = 2.0 * sqrt(
                         pow(r.x, 2.0) +
                         pow(r.y, 2.0) +
                         pow(r.z + 1.0, 2.0)
                         );
    
    vec2 uv = r.xy / m + .5;
    
    return uv;
}

vec2 reflectMatcap(vec4 mvPos, vec3 normal) {
    vec3 e = normalize(vec3(mvPos));
    vec3 n = normalize(normal);
    vec3 r = reflect(e, n);
    float m = 2.0 * sqrt(
                         pow(r.x, 2.0) +
                         pow(r.y, 2.0) +
                         pow(r.z + 1.0, 2.0)
                         );

    vec2 uv = r.xy / m + .5;

    return uv;
}{@}BasicMirror.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMirrorReflection;
uniform mat4 uMirrorMatrix;

#!VARYINGS
varying vec4 vMirrorCoord;

#!SHADER: BasicMirror.vs
void main() {
    vec4 worldPos = modelMatrix * vec4(position, 1.0);
    vMirrorCoord = uMirrorMatrix * worldPos;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: BasicMirror.fs
void main() {
    gl_FragColor.rgb = vec3(texture2D(tMirrorReflection, vMirrorCoord.xy / vMirrorCoord.w));
    gl_FragColor.a = 1.0;
}{@}parabolas.glsl{@}float parabola(float x, float k) {
    return pow(4.0 * x * (1.0 - x), k);
}

float pcurve(float x, float a, float b) {
    float k = pow(a + b, a + b) / (pow(a, a) * pow(b, b));
    return k * pow(x, a) * pow(1.0 - x, b);
}{@}PBR.glsl{@}#!ATTRIBUTES

#!UNIFORMS

#!VARYINGS

#!SHADER: PBR.vs

#require(pbr.vs)

void main() {
    setupPBR(position);

    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: PBR.fs

#require(pbr.fs)

void main() {
    gl_FragColor = getPBR();
}{@}pbr.fs{@}uniform sampler2D tBaseColor;
uniform vec2 uEnv;

uniform sampler2D tMRO;
uniform vec3 uMRO;

uniform sampler2D tNormal;
uniform vec2 uNormalScale;

uniform sampler2D tLUT;
uniform sampler2D tEnvDiffuse;
uniform sampler2D tEnvSpecular;
uniform float uHDR;

uniform vec4 uLight;

const float PI = 3.14159265359;
const float PI2 = 6.28318530718;
const float RECIPROCAL_PI = 0.31830988618;
const float RECIPROCAL_PI2 = 0.15915494;
const float LOG2 = 1.442695;
const float EPSILON = 1e-6;
const float LN2 = 0.6931472;

const float ENV_LODS = 7.0;

struct PBRConfig {
    float reflection;
    float darken;
    vec3 color;
};

varying vec2 vUv;
varying vec3 vNormal;
varying vec3 vMPos;

vec4 SRGBtoLinear(vec4 srgb) {
    vec3 linOut = pow(srgb.xyz, vec3(2.2));
    return vec4(linOut, srgb.w);
}

vec4 RGBEToLinear(vec4 value) {
    return vec4(value.rgb * exp2(value.a * 255.0 - 128.0), 1.0);
}

vec4 RGBMToLinear(vec4 value) {
    float maxRange = 6.0;
    return vec4(value.xyz * value.w * maxRange, 1.0);
}

vec4 RGBDToLinear(vec4 value, float maxRange) {
    return vec4(value.rgb * ((maxRange / 255.0) / value.a), 1.0);
}

vec3 linearToSRGB(vec3 color) {
    return pow(color, vec3(1.0 / 2.2));
}

vec3 getNormal(vec2 uNormalScale, sampler2D tNormal /*, sampler tNormalSampler*/, vec2 vUv, vec3 vNormal, vec3 vMPos) {
    vec3 pos_dx = vec3(dFdx(vMPos.x), dFdx(vMPos.y), dFdx(vMPos.z));
    vec3 pos_dy = vec3(dFdy(vMPos.x), dFdy(vMPos.y), dFdy(vMPos.z));
    vec3 tex_dx = vec3(dFdx(vUv.x), dFdx(vUv.y), dFdx(0.0));
    vec3 tex_dy = vec3(dFdy(vUv.x), dFdy(vUv.y), dFdy(0.0));
    vec3 t = (tex_dy.y * pos_dx - tex_dx.y * pos_dy) / (tex_dx.x * tex_dy.y - tex_dy.x * tex_dx.y);

    vec3 ng = normalize(vNormal);

    t = normalize(t - ng * dot(ng, t));
    vec3 b = normalize(cross(ng, t));
    mat3 tbn = mat3(t, b, ng);

    vec3 n = texture2D(tNormal, vUv * uNormalScale.y).rgb;
    n = normalize(tbn * ((2.0 * n - 1.0) * vec3(uNormalScale.x, uNormalScale.x, 1.0)));

    return n;
}

vec3 specularReflection(vec3 specularEnvR0, vec3 specularEnvR90, float VdH) {
    return specularEnvR0 + (specularEnvR90 - specularEnvR0) * pow(clamp(1.0 - VdH, 0.0, 1.0), 5.0);
}

float geometricOcclusion(float NdL, float NdV, float roughness) {
    float r = roughness;
    float attenuationL = 2.0 * NdL / (NdL + sqrt(r * r + (1.0 - r * r) * (NdL * NdL)));
    float attenuationV = 2.0 * NdV / (NdV + sqrt(r * r + (1.0 - r * r) * (NdV * NdV)));
    return attenuationL * attenuationV;
}

float microfacetDistribution(float roughness, float NdH) {
    float roughnessSq = roughness * roughness;
    float f = (NdH * roughnessSq - NdH) * NdH + 1.0;
    return roughnessSq / (PI * f * f);
}

vec3 inverseTformDir(in vec3 dir, in mat4 matrix) {
    return normalize((vec4(dir, 0.0) * matrix).xyz);
}

float prange(float oldValue, float oldMin, float oldMax, float newMin, float newMax) {
    float oldRange = oldMax - oldMin;
    float newRange = newMax - newMin;
    return (((oldValue - oldMin) * newRange) / oldRange) + newMin;
}

float pcrange(float oldValue, float oldMin, float oldMax, float newMin, float newMax) {
    return clamp(prange(oldValue, oldMin, oldMax, newMin, newMax), min(newMax, newMin), max(newMin, newMax));
}

vec2 cartesianToPolar(vec3 n, vec3 vMPos, vec3 cameraPosition, mat4 viewMatrix) {
    vec3 cameraToVertex = normalize(vMPos - cameraPosition);
    vec3 worldNormal = inverseTformDir(normalize(n), viewMatrix);
    vec3 reflectVec = normalize(reflect(cameraToVertex, worldNormal));
    vec3 reflectView = normalize((viewMatrix * vec4( reflectVec, 0.0)).xyz + vec3(0.0, 0.0, 1.0));
    return reflectView.xy * 0.5 + 0.5;
}

vec4 autoToLinear(vec4 texel, float uHDR) {
    vec4 rgbm = RGBMToLinear(texel);
    vec4 srgb = SRGBtoLinear(texel);
    return mix(srgb, rgbm, uHDR);
}

vec3 getIBLContribution(float NdV, float roughness, vec3 n, vec3 reflection, vec3 diffuseColor, vec3 specularColor, PBRConfig config, vec3 cameraPosition, mat4 viewMatrix, vec2 vUv, vec3 vMPos, vec2 uEnv, float uHDR, sampler2D tLUT, /*sampler tLUTSampler,*/ sampler2D tEnvDiffuse, /*sampler tEnvDiffuseSampler,*/ sampler2D tEnvSpecular /*, sampler tEnvSpecularSampler*/) {
    vec2 lutUV = vec2(NdV, roughness);
    vec2 diffuseUV = cartesianToPolar(n, vMPos, cameraPosition, viewMatrix);

    #test !!window.Metal
    lutUV.y = 1.0 - lutUV.y;
    diffuseUV.y = 1.0 - diffuseUV.y;
    #endtest

    vec3 brdf = SRGBtoLinear(texture2D(tLUT, lutUV)).rgb;
    vec3 diffuseLight = autoToLinear( texture2D(tEnvDiffuse, diffuseUV ), uHDR).rgb;

    // Sample 2 levels and mix between to get smoother degradation
    float blend = roughness * ENV_LODS;
    float level0 = floor(blend);
    float level1 = min(ENV_LODS, level0 + 1.0);
    blend -= level0;

    // Sample the specular env map atlas depending on the roughness value
    vec2 uvSpec = diffuseUV;
    uvSpec.y /= 2.0;

    vec2 uv0 = uvSpec;
    vec2 uv1 = uvSpec;

    uv0 /= pow(2.0, level0);
    uv0.y += 1.0 - exp(-LN2 * level0);

    uv1 /= pow(2.0, level1);
    uv1.y += 1.0 - exp(-LN2 * level1);

    #test !!window.Metal
    uv0.y = 1.0 - uv0.y;
    uv1.y = 1.0 - uv1.y;
    #endtest

    vec3 specular0 = autoToLinear(texture2D(tEnvSpecular, uv0), uHDR).rgb;
    vec3 specular1 = autoToLinear(texture2D(tEnvSpecular, uv1), uHDR).rgb;
    vec3 specularLight = mix(specular0, specular1, blend);

    vec3 diffuse = diffuseLight * diffuseColor;
    vec3 specular = specularLight * (specularColor * brdf.x + brdf.y);

    // A value to be able to push the strength and mimic HDR
    specular *= (1.0 + uEnv.y * specularLight) * config.reflection;
    return diffuse + specular;
}

vec3 calculatePBR(vec3 baseColor, PBRConfig config, vec3 cameraPosition, mat4 viewMatrix, vec2 vUv, vec3 vNormal, vec3 vMPos, vec2 uEnv, vec3 uMRO, vec2 uNormalScale, float uHDR, vec4 uLight, sampler2D tMRO, /*sampler tMROSampler,*/ sampler2D tNormal, /*sampler tNormalSampler,*/ sampler2D tLUT, /*sampler tLUTSampler,*/ sampler2D tEnvDiffuse, /*sampler tEnvDiffuseSampler,*/ sampler2D tEnvSpecular /*, sampler tEnvSpecularSampler*/) {
    // rgb = [metallic, roughness, occlusion] - still have a available
    vec4 mroSample = texture2D(tMRO, vUv);
    float metallic = clamp(mroSample.r * uMRO.x, 0.04, 1.0);
    float roughness = clamp(mroSample.g * uMRO.y, 0.04, 1.0);

    vec3 diffuseColor = baseColor * 0.96 * (1.0 - metallic);
    vec3 specularColor = mix(vec3(0.04), baseColor, metallic);

    float reflectance = max(max(specularColor.r, specularColor.g), specularColor.b);
    float reflectance90 = clamp(reflectance * 25.0, 0.0, 1.0);
    vec3 specularEnvR0 = specularColor.rgb;
    vec3 specularEnvR90 = vec3(reflectance90);

    vec3 N = getNormal(uNormalScale, tNormal, vUv, vNormal, vMPos);
    vec3 V = normalize(cameraPosition - vMPos);
    vec3 L = normalize(uLight.xyz);
    vec3 H = normalize(L + V);
    vec3 reflection = -normalize(reflect(V, N));

    float NdL = pcrange(clamp(dot(N, L), 0.001, 1.0), 0.0, 1.0, 0.4, 1.0);
    float NdV = pcrange(clamp(abs(dot(N, V)), 0.001, 1.0), 0.0, 1.0, 0.4, 1.0);
    float NdH = clamp(dot(N, H), 0.0, 1.0);
//    float LdH = clamp(dot(L, H), 0.0, 1.0);
    float VdH = clamp(dot(V, H), 0.0, 1.0);

    vec3 F = specularReflection(specularEnvR0, specularEnvR90, VdH);
    float G = geometricOcclusion(NdL, NdV, roughness);
    float D = microfacetDistribution(roughness, NdH);

    vec3 diffuseContrib = (1.0 - F) * (diffuseColor / PI);
    vec3 specContrib = F * G * D / (4.0 * NdL * NdV) * uLight.w;
    vec3 color = NdL * (diffuseContrib + specContrib) * config.darken;

    color += getIBLContribution(NdV, roughness, N, reflection, diffuseColor, specularColor, config, cameraPosition, viewMatrix, vUv, vMPos, uEnv, uHDR, tLUT, /*tLUTSampler,*/ tEnvDiffuse, /*tEnvDiffuseSampler,*/ tEnvSpecular /*, tEnvSpecularSampler*/) * config.color * uEnv.x;

    return mix(color, color * mroSample.b, uMRO.z);
}

vec4 getPBR() {
    PBRConfig config;
    config.reflection = 1.0;
    config.darken = 1.0;
    config.color = vec3(1.0);

    vec4 baseColor = SRGBtoLinear(texture2D(tBaseColor, vUv));
    vec3 color = calculatePBR(baseColor.rgb, config, cameraPosition, viewMatrix, vUv, vNormal, vMPos, uEnv, uMRO, uNormalScale, uHDR, uLight, tMRO, /*tMROSampler,*/ tNormal, /*tNormalSampler,*/ tLUT, /*tLUTSampler,*/ tEnvDiffuse, /*tEnvDiffuseSampler,*/ tEnvSpecular /*, tEnvSpecularSampler*/);
    return vec4(linearToSRGB(color), baseColor.a);
}

vec4 getPBR(PBRConfig config) {
    vec4 baseColor = SRGBtoLinear(texture2D(tBaseColor, vUv));
    vec3 color = calculatePBR(baseColor.rgb, config, cameraPosition, viewMatrix, vUv, vNormal, vMPos, uEnv, uMRO, uNormalScale, uHDR, uLight, tMRO, /*tMROSampler,*/ tNormal, /*tNormalSampler,*/ tLUT, /*tLUTSampler,*/ tEnvDiffuse, /*tEnvDiffuseSampler,*/ tEnvSpecular /*, tEnvSpecularSampler*/);
    return vec4(linearToSRGB(color), baseColor.a);
}

vec4 getPBR(vec3 inputColor) {
    PBRConfig config;
    config.reflection = 1.0;
    config.darken = 1.0;
    config.color = vec3(1.0);

    vec3 color = calculatePBR(SRGBtoLinear(vec4(inputColor, 1.0)).rgb, config, cameraPosition, viewMatrix, vUv, vNormal, vMPos, uEnv, uMRO, uNormalScale, uHDR, uLight, tMRO, /*tMROSampler,*/ tNormal, /*tNormalSampler,*/ tLUT, /*tLUTSampler,*/ tEnvDiffuse, /*tEnvDiffuseSampler,*/ tEnvSpecular /*, tEnvSpecularSampler*/);
    return vec4(linearToSRGB(color), 1.0);
}

vec4 getPBR(vec3 inputColor, PBRConfig config) {
    vec3 color = calculatePBR(SRGBtoLinear(vec4(inputColor, 1.0)).rgb, config, cameraPosition, viewMatrix, vUv, vNormal, vMPos, uEnv, uMRO, uNormalScale, uHDR, uLight, tMRO, /*tMROSampler,*/ tNormal, /*tNormalSampler,*/ tLUT, /*tLUTSampler,*/ tEnvDiffuse, /*tEnvDiffuseSampler,*/ tEnvSpecular /*, tEnvSpecularSampler*/);
    return vec4(linearToSRGB(color), 1.0);
}{@}pbr.vs{@}uniform sampler2D tBaseColor;

varying vec2 vUv;
varying vec3 vNormal;
varying vec3 vMPos;

void setupPBR(vec3 p0) { //inlinemain
    vUv = uv;
    vec4 mPos = modelMatrix * vec4(p0, 1.0);
    vMPos = mPos.xyz / mPos.w;
    vNormal = normalMatrix * normal;
}{@}range.glsl{@}float range(float oldValue, float oldMin, float oldMax, float newMin, float newMax) {
    float oldRange = oldMax - oldMin;
    float newRange = newMax - newMin;
    return (((oldValue - oldMin) * newRange) / oldRange) + newMin;
}

float crange(float oldValue, float oldMin, float oldMax, float newMin, float newMax) {
    return clamp(range(oldValue, oldMin, oldMax, newMin, newMax), min(newMax, newMin), max(newMin, newMax));
}

vec2 crange(vec2 oldValue, vec2 oldMin, vec2 oldMax, vec2 newMin, vec2 newMax) {
    vec2 v;
    v.x = crange(oldValue.x, oldMin.x, oldMax.x, newMin.x, newMax.x);
    v.y = crange(oldValue.y, oldMin.y, oldMax.y, newMin.y, newMax.y);
    return v;
}

vec2 range(vec2 oldValue, vec2 oldMin, vec2 oldMax, vec2 newMin, vec2 newMax) {
    vec2 v;
    v.x = range(oldValue.x, oldMin.x, oldMax.x, newMin.x, newMax.x);
    v.y = range(oldValue.y, oldMin.y, oldMax.y, newMin.y, newMax.y);
    return v;
}

vec3 crange(vec3 oldValue, vec3 oldMin, vec3 oldMax, vec3 newMin, vec3 newMax) {
    vec3 v;
    v.x = crange(oldValue.x, oldMin.x, oldMax.x, newMin.x, newMax.x);
    v.y = crange(oldValue.y, oldMin.y, oldMax.y, newMin.y, newMax.y);
    v.z = crange(oldValue.z, oldMin.z, oldMax.z, newMin.z, newMax.z);
    return v;
}

vec3 range(vec3 oldValue, vec3 oldMin, vec3 oldMax, vec3 newMin, vec3 newMax) {
    vec3 v;
    v.x = range(oldValue.x, oldMin.x, oldMax.x, newMin.x, newMax.x);
    v.y = range(oldValue.y, oldMin.y, oldMax.y, newMin.y, newMax.y);
    v.z = range(oldValue.z, oldMin.z, oldMax.z, newMin.z, newMax.z);
    return v;
}{@}rgb2hsv.fs{@}vec3 rgb2hsv(vec3 c) {
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
    
    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec3 hsv2rgb(vec3 c) {
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}{@}rgbshift.fs{@}vec4 getRGB(sampler2D tDiffuse, vec2 uv, float angle, float amount) {
    vec2 offset = vec2(cos(angle), sin(angle)) * amount;
    vec4 r = texture2D(tDiffuse, uv + offset);
    vec4 g = texture2D(tDiffuse, uv - offset);
    vec4 b = texture2D(tDiffuse, uv);
    return vec4(r.r, g.g, b.b, g.a);
}{@}rotation.glsl{@}mat4 rotationMatrix(vec3 axis, float angle) {
    axis = normalize(axis);
    float s = sin(angle);
    float c = cos(angle);
    float oc = 1.0 - c;

    return mat4(oc * axis.x * axis.x + c,           oc * axis.x * axis.y - axis.z * s,  oc * axis.z * axis.x + axis.y * s,  0.0,
                oc * axis.x * axis.y + axis.z * s,  oc * axis.y * axis.y + c,           oc * axis.y * axis.z - axis.x * s,  0.0,
                oc * axis.z * axis.x - axis.y * s,  oc * axis.y * axis.z + axis.x * s,  oc * axis.z * axis.z + c,           0.0,
                0.0,                                0.0,                                0.0,                                1.0);
}{@}simplenoise.glsl{@}float getNoise(vec2 uv, float time) {
    float x = uv.x * uv.y * time * 1000.0;
    x = mod(x, 13.0) * mod(x, 123.0);
    float dx = mod(x, 0.01);
    float amount = clamp(0.1 + dx * 100.0, 0.0, 1.0);
    return amount;
}

highp float getRandom(vec2 co) {
    highp float a = 12.9898;
    highp float b = 78.233;
    highp float c = 43758.5453;
    highp float dt = dot(co.xy, vec2(a, b));
    highp float sn = mod(dt, 3.14);
    return fract(sin(sn) * c);
}

float cnoise(vec3 v) {
    float t = v.z * 0.3;
    v.y *= 0.8;
    float noise = 0.0;
    float s = 0.5;
    noise += range(sin(v.x * 0.9 / s + t * 10.0) + sin(v.x * 2.4 / s + t * 15.0) + sin(v.x * -3.5 / s + t * 4.0) + sin(v.x * -2.5 / s + t * 7.1), -1.0, 1.0, -0.3, 0.3);
    noise += range(sin(v.y * -0.3 / s + t * 18.0) + sin(v.y * 1.6 / s + t * 18.0) + sin(v.y * 2.6 / s + t * 8.0) + sin(v.y * -2.6 / s + t * 4.5), -1.0, 1.0, -0.3, 0.3);
    return noise;
}

float cnoise(vec2 v) {
    float t = v.x * 0.3;
    v.y *= 0.8;
    float noise = 0.0;
    float s = 0.5;
    noise += range(sin(v.x * 0.9 / s + t * 10.0) + sin(v.x * 2.4 / s + t * 15.0) + sin(v.x * -3.5 / s + t * 4.0) + sin(v.x * -2.5 / s + t * 7.1), -1.0, 1.0, -0.3, 0.3);
    noise += range(sin(v.y * -0.3 / s + t * 18.0) + sin(v.y * 1.6 / s + t * 18.0) + sin(v.y * 2.6 / s + t * 8.0) + sin(v.y * -2.6 / s + t * 4.5), -1.0, 1.0, -0.3, 0.3);
    return noise;
}{@}transformUV.glsl{@}vec2 transformUV(vec2 uv, float a[9]) {

    // Convert UV to vec3 to apply matrices
	vec3 u = vec3(uv, 1.0);

    // Array consists of the following
    // 0 translate.x
    // 1 translate.y
    // 2 skew.x
    // 3 skew.y
    // 4 rotate
    // 5 scale.x
    // 6 scale.y
    // 7 origin.x
    // 8 origin.y

    // Origin before matrix
    mat3 mo1 = mat3(
        1, 0, -a[7],
        0, 1, -a[8],
        0, 0, 1);

    // Origin after matrix
    mat3 mo2 = mat3(
        1, 0, a[7],
        0, 1, a[8],
        0, 0, 1);

    // Translation matrix
    mat3 mt = mat3(
        1, 0, -a[0],
        0, 1, -a[1],
    	0, 0, 1);

    // Skew matrix
    mat3 mh = mat3(
        1, a[2], 0,
        a[3], 1, 0,
    	0, 0, 1);

    // Rotation matrix
    mat3 mr = mat3(
        cos(a[4]), sin(a[4]), 0,
        -sin(a[4]), cos(a[4]), 0,
    	0, 0, 1);

    // Scale matrix
    mat3 ms = mat3(
        1.0 / a[5], 0, 0,
        0, 1.0 / a[6], 0,
    	0, 0, 1);

	// apply translation
   	u = u * mt;

	// apply skew
   	u = u * mh;

    // apply rotation relative to origin
    u = u * mo1;
    u = u * mr;
    u = u * mo2;

    // apply scale relative to origin
    u = u * mo1;
    u = u * ms;
    u = u * mo2;

    // Return vec2 of new UVs
    return u.xy;
}

vec2 rotateUV(vec2 uv, float r, vec2 origin) {
    vec3 u = vec3(uv, 1.0);

    mat3 mo1 = mat3(
        1, 0, -origin.x,
        0, 1, -origin.y,
        0, 0, 1);

    mat3 mo2 = mat3(
        1, 0, origin.x,
        0, 1, origin.y,
        0, 0, 1);

    mat3 mr = mat3(
        cos(r), sin(r), 0,
        -sin(r), cos(r), 0,
        0, 0, 1);

    u = u * mo1;
    u = u * mr;
    u = u * mo2;

    return u.xy;
}

vec2 rotateUV(vec2 uv, float r) {
    return rotateUV(uv, r, vec2(0.5));
}

vec2 translateUV(vec2 uv, vec2 translate) {
    vec3 u = vec3(uv, 1.0);
    mat3 mt = mat3(
        1, 0, -translate.x,
        0, 1, -translate.y,
        0, 0, 1);

    u = u * mt;
    return u.xy;
}

vec2 scaleUV(vec2 uv, vec2 scale, vec2 origin) {
    vec3 u = vec3(uv, 1.0);

    mat3 mo1 = mat3(
        1, 0, -origin.x,
        0, 1, -origin.y,
        0, 0, 1);

    mat3 mo2 = mat3(
        1, 0, origin.x,
        0, 1, origin.y,
        0, 0, 1);

    mat3 ms = mat3(
        1.0 / scale.x, 0, 0,
        0, 1.0 / scale.y, 0,
        0, 0, 1);

    u = u * mo1;
    u = u * ms;
    u = u * mo2;
    return u.xy;
}

vec2 scaleUV(vec2 uv, vec2 scale) {
    return scaleUV(uv, scale, vec2(0.5));
}
{@}ExperienceDefault.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex

void main() {
    vUv = uv;
    gl_Position = vec4(position, 1.0);
}

#!SHADER: Fragment

#require(transformUV.glsl)
#require(range.glsl)
#require(simplenoise.glsl)
#require(rgbshift.fs)

void main() {
    vec2 uv = vUv;

    vec4 final = getRGB(tMap, uv, 0.1, 0.0002);
    final += crange(getNoise(vUv, time * 0.1), 0.0, 1.0, -1.0, 1.0) * 0.005;

    gl_FragColor = final;
    gl_FragColor.a = 1.0;
}{@}ExperienceIntro.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tIntro;
uniform sampler2D tWorld;
uniform sampler2D tDepth;
uniform sampler2D tTransition;
uniform sampler2D tLines;
uniform float uTransition;
uniform float uLinesScale;
uniform float uDepthNear;
uniform float uDepthFar;
uniform float uTrMin;
uniform float uTrMax;
uniform float uTrMargin;
uniform float uTrDisplacement;
uniform float uChannel;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex

void main() {
    vUv = uv;
    gl_Position = vec4(position, 1.0);
}

#!SHADER: Fragment

#require(transformUV.glsl)
#require(range.glsl)
#require(simplenoise.glsl)
#require(rgbshift.fs)
#require(depthvalue.fs)
#require(eases.glsl)

float parabola( float x, float k ) {
    return pow( 4.0*x*(1.0-x), k );
}

float linearstep(float begin, float end, float t) {
    return clamp((t - begin) / (end - begin), 0.0, 1.0);
}

float hscan(float _input, float start, float end, float contrast, float progress) {
    float margin = contrast;
    float p = mix(start + margin, end, progress);
    return linearstep(p - margin, p, _input);
}

float hscansmooth(float _input, float start, float end, float contrast, float progress) {
    float margin = contrast;
    float p = mix(start + margin, end, progress);
    return smoothstep(p - margin, p, _input);
}

void main() {
    vec2 uv = vUv;

    // depth transition
    float depth = clamp(getDepthValue(tDepth, uv, uDepthNear, uDepthFar), 0.0, 1.0);
    float tr = hscan(depth, uTrMax, uTrMin, -uTrMargin, uTransition);
    float par = parabola(tr, 0.05 + smoothstep(0.0, 0.5, abs(vUv.y - 0.5)));

    // transition texture
    vec2 uvLines = vUv - 0.5;
    uvLines.x *= resolution.x / resolution.y;
    uvLines += 0.5;

    float trTex = 1.0 - texture2D(tTransition, uvLines * uLinesScale).r * 2.0 - 1.0;

    // general, on-top transition
    float trLines = (texture2D(tLines, vUv * 0.15 + time * 0.15).r * 2.0 - 1.0) * 0.075;
    float disp = floor(mod(uTransition * 2.0 + time, 2.0)) - 1.0;
    float addedX = parabola(cubicInOut(crange(uTransition, 0.1, 0.8, 0.0, 1.0)), 0.75) * disp * trLines * (1.0 - trTex);

    vec2 uv1 = uv;
    uv1.x -= 0.5;
    uv1.x *= 1.0 + uTrDisplacement * par * trTex;
    uv1.x += addedX;
    uv1.x += 0.5;

    vec2 uv2 = uv;
    uv2.x -= 0.5;
    uv2.x *= 1.0 + uTrDisplacement * par * trTex;
    uv2.x -= addedX * 2.0;
    uv2.x += 0.5;

    vec4 intro = getRGB(tIntro, uv1, 0.1, 0.0002);
    intro += crange(getNoise(vUv, time * 0.1), 0.0, 1.0, -1.0, 1.0) * 0.005;

    vec4 world = getRGB(tWorld, uv2, 0.1, 0.0002);
    world += crange(getNoise(vUv, time * 0.1), 0.0, 1.0, -1.0, 1.0) * 0.005;

    vec4 final = mix(world, intro, tr);

    gl_FragColor = final;
    gl_FragColor.a = 1.0;

    // gl_FragColor.rgb = vec3(tr);
}{@}ExperienceTransition.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tLeft;
uniform sampler2D tRight;
uniform sampler2D tNoiseMap;

uniform float uTransition;
uniform float uVelocity;
uniform float uRatio;
uniform float uRepeatSampling;

uniform float uBlendIntensityLeft;
uniform float uBlendIntensityRight;

uniform float uNoiseScale;
uniform float uNoiseIntensity;

uniform vec2 uLumRangeLeft;
uniform vec2 uLumRangeRight;

uniform vec3 uColorLeft;
uniform vec3 uColorRight;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex

void main() {
    vUv = uv;
    gl_Position = vec4(position, 1.0);
}

#!SHADER: Fragment

#require(range.glsl)
#require(simplenoise.glsl)
#require(rgbshift.fs)
#require(parabolas.glsl)
#require(eases.glsl)
#require(luma.fs)
#require(blendmodes.glsl)

float aastep(float threshold, float value) {
    float afwidth = length(vec2(dFdx(value), dFdy(value))) * 0.70710678118654757;
    return smoothstep(threshold-afwidth, threshold+afwidth, value);
}

vec3 saturation(vec3 rgb, float adjustment) {
    vec3 W = vec3(0.2125, 0.7154, 0.0721);
    vec3 intensity = vec3(dot(rgb, W));
    return mix(intensity, rgb, adjustment);
}

vec3 colorSampler(vec3 color, float steps) {
    color *= steps;
    color = floor(color) / vec3(steps);
    return color;
}

const float displacement = 0.5;
const float lumaLimit = 0.5;

void main() {
    vec2 tUv = vUv;
    tUv.x *= uRatio;
    float factor = texture2D(tNoiseMap, tUv * uNoiseScale).r;
    float noiseDisplacement = factor * uNoiseIntensity;

    float maxTilt = 0.4 / uRatio;
    float edgeParabola = parabola(vUv.x, 1.0);
    float tilt = vUv.y * crange(uVelocity, -1.0, 1.0, -maxTilt * 0.5, maxTilt * 0.5) * edgeParabola;
    float tr = aastep(vUv.x + tilt, uTransition);

    float leftProgress = (1.0 - uTransition);
    float rightProgress = uTransition;

    vec2 uvLeft = vUv;
    uvLeft.x += leftProgress * displacement;
    vec2 uvRight = vUv;
    uvRight.x -= rightProgress * displacement;

    vec3 left = texture2D(tLeft, uvLeft).rgb;
    vec3 right = texture2D(tRight, uvRight).rgb;

    // prev
    // float lLeft = smoothstep(uLumRangeLeft.x, uLumRangeLeft.y, luma(left)) * noiseDisplacement;
    // float lRight = smoothstep(uLumRangeRight.x, uLumRangeRight.y, luma(right)) * noiseDisplacement;
    float lLeft = smoothstep(uLumRangeLeft.x, lumaLimit, luma(left)) * noiseDisplacement;
    float lRight = smoothstep(uLumRangeRight.x, lumaLimit, luma(right)) * noiseDisplacement;

    uvLeft.x -= leftProgress * displacement * lLeft * uVelocity;
    uvRight.x -= rightProgress * displacement * lRight * uVelocity;

    left = texture2D(tLeft, uvLeft).rgb;
    right = texture2D(tRight, uvRight).rgb;

    left = mix(left, vec3(luma(left)), leftProgress);
    right = mix(right, vec3(luma(right)), rightProgress);

    // Blending
    float blendFactor = parabola(uTransition, 1.);
    left = blendSoftLight(left, uColorLeft, blendFactor * uBlendIntensityLeft);
    right = blendSoftLight(right, uColorRight, blendFactor * uBlendIntensityRight);

    vec3 color = mix(right, left, tr);

    gl_FragColor.rgb = color;
    gl_FragColor.a = 1.0;
}{@}IntroOverlay.fs{@}
uniform sampler2D tDiffuse;
uniform vec3 uOverlayColor;
uniform float uOverlay;

varying vec2 vUv;

#require(blendmodes.glsl)

void main() {
    vec3 color = texture2D(tDiffuse, vUv).rgb;

    color.rgb = mix(color.rgb, blendMultiply(color.rgb, uOverlayColor), uOverlay*0.4);
    color.rgb = mix(color.rgb, blendScreen(color.rgb, uOverlayColor), uOverlay*0.15);
    color.rgb = mix(color.rgb, blendSoftLight(color.rgb, uOverlayColor), uOverlay);

    gl_FragColor.rgb = color;
    gl_FragColor.a = 1.0;
}{@}ExperienceLoaderOverlay.fs{@}
uniform sampler2D tDiffuse;
uniform sampler2D tNoise;
uniform float uShow;
uniform float uOverlay;
uniform float uAlpha;

uniform vec4 uNoiseOptions;
uniform vec4 uNoiseOptions2;

varying vec2 vUv;

#require(range.glsl)
#require(simplenoise.glsl)
#require(blendmodes.glsl)
#require(dither.fs)
#require(transformUV.glsl)
#require(eases.glsl)

void main() {
    vec3 originalColor = texture2D(tDiffuse, vUv).rgb;
    vec3 color = mix(originalColor, vec3(0.0), uOverlay);


    // overlay animated noise
    vec2 noiseUV = vUv - 0.5;
    noiseUV.x *= resolution.x / resolution.y;
    noiseUV += 0.5;

    vec2 noiseUV2 = noiseUV;

    noiseUV *= uNoiseOptions.x; // X is scale
    float randomnum = getRandom(vec2(floor(time / uNoiseOptions.z) * uNoiseOptions.z, floor(time / uNoiseOptions.z) * uNoiseOptions.z)) * 2.0 - 1.0; // z is speed
    float noise = texture2D(tNoise, vec2(noiseUV.x + randomnum * 5.134, noiseUV.y + randomnum * 7.756)).r;
    noise *= step(uNoiseOptions.w, randomnum); // W is the appeareance probability

    noiseUV2 *= uNoiseOptions2.x; // X is scale
    float randomnum2 = getRandom(vec2(floor(time / uNoiseOptions2.z) * uNoiseOptions2.z, floor(time / uNoiseOptions2.z) * uNoiseOptions2.z)) * 2.0 - 1.0; // z is speed
    float noise2 = texture2D(tNoise, vec2(noiseUV2.x + randomnum2 * 5.134, noiseUV2.y + randomnum2 * 7.756)).g * 2.0;
    noise2 *= step(uNoiseOptions2.w, randomnum2); // W is the appeareance probability

    float d = clamp(noise + noise2, 0.0, 1.0);

    color = mix(color, vec3(0.9), d);
    color = mix(vec3(0.0), color, uShow);
    color = mix(originalColor, color, uAlpha);

    gl_FragColor.rgb = color;
    gl_FragColor.a = 1.0;
}
{@}ExperienceOverlay.fs{@}
uniform sampler2D tDiffuse;
uniform sampler2D tNormal;
uniform float uScale;
uniform float uFrequency;
uniform float uDeform;
uniform float uvScale;
uniform vec3 uColor;
uniform float uColorMix;
uniform float uOverlay;
uniform float uLightStr;
uniform float uNormalScale;
uniform float uSpeed;

varying vec2 vUv;

#require(range.glsl)
#require(rgb2hsv.fs)
#require(mousefluid.fs)

float noise(vec3 pp, float fluidMask) {
    vec3 p = pp;
    float f = uFrequency;
    p += .5*cos( f * 1.5*p.yxz + 1.0*time*uSpeed + fluidMask*0.2 + vec3(0.1,1.1, 0.) );
	p += .5*cos( f * 2.4*p.yxz + 1.6*time*uSpeed + fluidMask*0.2 + vec3(4.5,2.6, 0.) );
	p += .2*cos( f * 3.3*p.yxz + 1.2*time*uSpeed + fluidMask*0.2 + vec3(3.2,3.4,0.) );
	p += .2*cos( f * 4.2*p.yzx + 1.7*time*uSpeed + fluidMask*0.2 + vec3(1.8,5.2,0.) );
	p += .2*cos( f * 6.1*p.yxz + 1.1*time*uSpeed + fluidMask*0.2 + vec3(6.3,3.9,0.) );

	float r = smoothstep(0.0, 1.0, 0.15 * length(p) );

	r *= uOverlay;

    return r;
}

void main() {
    float fluidMask = texture2D(tFluidMask, vUv).r;//smoothstep(0.1, 1.0, texture2D(tFluidMask, vUv).r);
    float fluidOutline = smoothstep(0.0, 0.2, fluidMask) * smoothstep(1.0, 0.7, fluidMask) * 0.5;
    //vec2 fluid = texture2D(tFluid, vUv).xy * fluidMask;

    vec4 color = texture2D(tDiffuse, vUv);

    float eps = .003;
    vec2 st = 2. * vUv - 1.;

    //st += fluid * 0.005;

    vec3 pos0 = vec3(st, fluidMask*0.5);
    vec3 pos1 = vec3(st + vec2(eps, 0.), fluidMask*0.5);
    vec3 pos2 = vec3(st + vec2(0., eps), fluidMask*0.5);

    pos0.z = mix(1.0, uScale, uOverlay) * noise(pos0, fluidMask);
    pos1.z = mix(1.0, uScale, uOverlay) * noise(pos1, fluidMask);
    pos2.z = mix(1.0, uScale, uOverlay) * noise(pos2, fluidMask);

    vec3 n1 = normalize(pos0 - pos1);
    vec3 n2 = normalize(pos0 - pos2);

    vec3 normal = normalize(cross(n1, n2));
    n1 = normalize(cross(normal, n2));
    n2 = normalize(cross(normal, n1));

    mat3 mat = mat3(normal, n1, n2);

    vec2 hg = 2. * vUv - 1.;
    float deformation = mix(1.0, uvScale * (fluidOutline*0.05 + 1. + 0.1 * uDeform * uOverlay * abs(normal.z)), uOverlay);
    hg *= deformation;
    hg = 0.5 * hg + 0.5;

    vec3 texel = texture2D(tDiffuse, hg).xyz;

    texel = rgb2hsv(texel);
    texel.y *= 1.0-uOverlay;
    texel = hsv2rgb(texel);

    vec3 fabricNormal = texture2D(tNormal, hg * uNormalScale).xyz;
    fabricNormal = 2. * fabricNormal - 1.;

    fabricNormal = mat * fabricNormal;

    //phong shading
    vec3 light_dir = normalize(vec3(0., .10 , fluidMask));
	float d = clamp(dot(fabricNormal, light_dir), 0., 1.);
    float light = mix(1.0, d, uLightStr);

    texel = mix(texel, uColor, uColorMix);

    vec4 fabricColor = vec4(light * texel, 1.);

    fabricColor *= 1.0 - smoothstep(0.6, 0.2, length(vUv-0.5)) * (0.7 + 0.1*fluidOutline) * uLightStr;


    gl_FragColor = mix(color * (1.0-uOverlay), fabricColor, uOverlay);
}
{@}PageTransition.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMapTop;
uniform sampler2D tMapBottom;
// uniform float uMaskTransition; // -1, 1
uniform float uTransition; // 0, 1
uniform float uRatio;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex

void main() {
    gl_Position = vec4(position, 1.0);
    vUv = uv;
}

#!SHADER: Fragment

#require(rgb2hsv.fs)
#require(range.glsl)
#require(transformUV.glsl)

float aastep(float threshold, float value) {
    float afwidth = length(vec2(dFdx(value), dFdy(value))) * 0.70710678118654757;
    return smoothstep(threshold-afwidth, threshold+afwidth, value);
}

void main() {
    vec2 uv = vUv;

    vec3 topColor = texture2D(tMapTop, vUv).rgb;
    vec3 bottomColor = texture2D(tMapBottom, vUv).rgb;

    // simple horizontal cut
    float inclination = 0.07 * uRatio;
    float cut1 = aastep(uv.y + uv.x * inclination, crange(uTransition, 0.0, 1.0, 0.0, 1.0 + inclination));
    vec3 final = mix(topColor, bottomColor, cut1);

    gl_FragColor.rgb = final;
    gl_FragColor.a = 1.0;
}{@}PageFXWorld1.fs{@}
uniform vec2 uScale1;
uniform vec2 uDisplacement1;
uniform float uSpeed1;
uniform vec2 uScale2;
uniform vec2 uDisplacement2;
uniform float uSpeed2;
uniform vec3 uColor;
uniform float uOffset;
uniform float uScrollSpeed;
uniform float uPower;
uniform float uRGBShift;
uniform sampler2D tNoise;
uniform vec4 uNoiseOptions;
uniform vec4 uNoiseOptions2;
uniform vec3 uCenterMask;

uniform float uOffborders;

uniform sampler2D tGLUI;
uniform float uRenderGLUI;

#require(range.glsl)
#require(simplenoise.glsl)
#require(blendmodes.glsl)
#require(dither.fs)
#require(transformUV.glsl)
#require(rgbshift.fs)

void main() {
    vec3 color = texture2D(tDiffuse, vUv).rgb;

    // add glui
    vec4 glui = texture2D(tGLUI, vUv);
    color.rgb = mix(color.rgb, glui.rgb, glui.a);

    vec2 uv = vec2(vUv.x, vUv.y);

    float n1 = cnoise(uv * uScale1 + uDisplacement1 * uSpeed1 * time);
    float n2 = cnoise(uv * uScale2 + uDisplacement2 * uSpeed2 * time);
    float n = (1.0 - smoothstep(0.0, 1.0, abs(n1 + n2))) * uPower;

    n *= smoothstep(uCenterMask.x, uCenterMask.y, length(vUv - 0.5)) * uCenterMask.z;
    n *= 1.0 - uOffborders;

    vec3 imgColor = blendSoftLight(color, uColor, n);

    // overlay animated noise
    vec2 noiseUV = uv - 0.5;
    noiseUV.x *= resolution.x / resolution.y;
    noiseUV += 0.5;

    vec2 noiseUV2 = noiseUV;

    noiseUV *= uNoiseOptions.x; // X is scale
    noiseUV.y -= uOffset * uNoiseOptions.y; // Y is parallax
    float randomnum = getRandom(vec2(floor(time / uNoiseOptions.z) * uNoiseOptions.z, floor(time / uNoiseOptions.z) * uNoiseOptions.z)) * 2.0 - 1.0; // z is speed
    float noise = texture2D(tNoise, vec2(noiseUV.x + randomnum * 5.134, noiseUV.y + randomnum * 7.756)).r;
    noise *= step(uNoiseOptions.w, randomnum); // W is the appeareance probability

    noiseUV2 *= uNoiseOptions2.x; // X is scale
    noiseUV2.y -= uOffset * uNoiseOptions2.y; // Y is parallax
    float randomnum2 = getRandom(vec2(floor(time / uNoiseOptions2.z) * uNoiseOptions2.z, floor(time / uNoiseOptions2.z) * uNoiseOptions2.z)) * 2.0 - 1.0; // z is speed
    float noise2 = texture2D(tNoise, vec2(noiseUV2.x + randomnum2 * 5.134, noiseUV2.y + randomnum2 * 7.756)).g * 2.0;
    noise2 *= step(uNoiseOptions2.w, randomnum2); // W is the appeareance probability


    float d = clamp(noise + noise2, 0.0, 1.0);
    gl_FragColor.rgb = mix(imgColor, vec3(1.0), d);

    gl_FragColor.a = 1.0;
}{@}PageFXWorld2.fs{@}
uniform vec2 uScale1;
uniform vec2 uDisplacement1;
uniform float uSpeed1;
uniform vec2 uScale2;
uniform vec2 uDisplacement2;
uniform float uSpeed2;
uniform vec3 uColor;
uniform float uOffset;
uniform float uPower;
uniform float uRGBShift;
uniform sampler2D tClouds;
uniform vec4 uCloudsOptions;
uniform vec2 uCloudsSpeeds;
uniform float uCloudsStr;
uniform vec3 uCenterMask;

uniform float uOffborders;

uniform sampler2D tGLUI;
uniform float uRenderGLUI;

#require(range.glsl)
#require(simplenoise.glsl)
#require(blendmodes.glsl)
#require(dither.fs)
#require(transformUV.glsl)
#require(rgbshift.fs)

void main() {
    vec3 color = texture2D(tDiffuse, vUv).rgb;

    // add glui
    vec4 glui = texture2D(tGLUI, vUv);
    color.rgb = mix(color.rgb, glui.rgb, glui.a);

    vec2 uv = vec2(vUv.x, vUv.y - uOffset * 0.5);

    float n1 = cnoise(uv * uScale1 + uDisplacement1 * uSpeed1 * time);
    float n2 = cnoise(uv * uScale2 + uDisplacement2 * uSpeed2 * time);
    float n = (1.0 - smoothstep(0.0, 1.0, abs(n1 + n2))) * uPower;

    n *= smoothstep(uCenterMask.x, uCenterMask.y, length(vUv - 0.5)) * uCenterMask.z;
    n *= 1.0 - uOffborders;

    vec3 imgColor = blendSoftLight(color, uColor, n);

    // add clouds
    vec2 cloudsUV = uv - 0.5;
    cloudsUV.x *= resolution.x / resolution.y;
    cloudsUV += 0.5;
    cloudsUV *= uCloudsOptions.y; // scale

    vec2 cloudsUV2 = cloudsUV;
    cloudsUV.y -= uOffset * uCloudsOptions.x; // X is scroll parallax
    cloudsUV.y -= uCloudsSpeeds.x * time;

    // rotate so patterns become less evident
    cloudsUV = rotateUV(cloudsUV, uCloudsOptions.w); // W is rotation

    cloudsUV2.y -= uOffset * uCloudsOptions.x; //* 1.35;
    cloudsUV2.y -= uCloudsSpeeds.y * time;
    cloudsUV2 = rotateUV(cloudsUV2, -uCloudsOptions.w);


    float d1 = texture2D(tClouds, cloudsUV).r * clamp(n + 0.5, 0.0, 1.0);
    float d2 = texture2D(tClouds, cloudsUV2).g * clamp(n + 0.5, 0.0, 1.0);
    float d = clamp(d1 * d2, 0.0, 1.0) * uCloudsStr * (1.0 - uOffborders);

    // gl_FragColor.rgb = vec3(d);

    gl_FragColor.rgb = mix(imgColor, vec3(1.0), d);
    gl_FragColor.a = 1.0;
}{@}PageFXWorld3.fs{@}
uniform vec2 uScale1;
uniform vec2 uDisplacement1;
uniform float uSpeed1;
uniform vec2 uScale2;
uniform vec2 uDisplacement2;
uniform float uSpeed2;
uniform vec3 uColor;
uniform float uOffset;
uniform float uPower;
uniform float uRGBShift;
uniform vec3 uCenterMask;

uniform float uOffborders;

uniform sampler2D tGLUI;
uniform float uRenderGLUI;

#require(range.glsl)
#require(simplenoise.glsl)
#require(blendmodes.glsl)
#require(dither.fs)
#require(transformUV.glsl)
#require(rgbshift.fs)

void main() {
    vec3 color = texture2D(tDiffuse, vUv).rgb;

    // add glui
    vec4 glui = texture2D(tGLUI, vUv);
    color.rgb = mix(color.rgb, glui.rgb, glui.a);

    vec2 uv = vec2(vUv.x, vUv.y - uOffset * 0.5);

    float n1 = cnoise(uv * uScale1 + uDisplacement1 * uSpeed1 * time);
    float n2 = cnoise(uv * uScale2 + uDisplacement2 * uSpeed2 * time);
    float n = (1.0 - smoothstep(0.0, 1.0, abs(n1 + n2))) * uPower;

    n *= smoothstep(uCenterMask.x, uCenterMask.y, length(vUv - 0.5)) * uCenterMask.z;
    n *= 1.0 - uOffborders;
    n += 0.05;

    vec3 imgColor = blendSoftLight(color*0.96, uColor, n);

    gl_FragColor.rgb = imgColor;
    gl_FragColor.a = 1.0;
}{@}BackgroundLines.glsl{@}#!ATTRIBUTES
attribute vec4 data;

#!UNIFORMS
uniform sampler2D tMap;
uniform vec3 uColor;
uniform float speed;
uniform float uAlpha;
uniform float uAdditionalY;
uniform float uTime;

#!VARYINGS
varying vec2 vUv;
varying vec3 vPos;
varying vec2 phase;

#!SHADER: Vertex

void main() {
    vUv = uv;

    vec3 polar = data.xyz;
    vec3 offset = vec3(0.);

    float c = cos(polar.x);
    float s = sin(polar.x);

    offset.x = polar.y * c;
    offset.z = polar.y * s;
    offset.y = 0.;

    phase = data.zw;

    const float h_PI = 3.14159264 * 0.5;

    c = cos(polar.x + h_PI);
    s = sin(polar.x + h_PI);

    mat3 rotY = mat3(c, 0., s,
                     0., 1., 0.,
                     -s, 0., c);

    vec3 pos = rotY * position + offset;

    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);

    vPos = pos;
}

#!SHADER: Fragment

#require(eases.glsl)

void main() {
    float uy = speed * 0.03 * uTime * (1. + phase.x * 3.) + phase.y + uAdditionalY;

    float shape = texture2D(tMap, vec2(1., 1. + 2. * phase.y) * vUv + vec2(0., uy )).r;
    vec3 color = mix(uColor, vec3(1.0), qinticIn(clamp(shape, 0.0, 1.0)));

    gl_FragColor.rgb = color;
    gl_FragColor.a = shape * uAlpha;
    gl_FragColor.a *= 0.3 + 0.7 * phase.x;
}
{@}AdidasFBR2.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform vec2 uFogRange;
uniform vec2 uFogRangeNear;
uniform float uFBRStrength;
uniform float uMatcapRotate;
uniform float uDarken;

uniform float uColorMult;
uniform float uColorBrighten;
uniform float uNormalStrength;
uniform float uRoughnessStr;

uniform sampler2D tMRO;
uniform sampler2D tMatcap;
uniform sampler2D tNormal;
uniform vec4 uLight;
uniform vec3 uColor;

uniform float uWaviness;
uniform float uWavinessSpeed;
uniform float uWavinessScale;

#!VARYINGS

varying vec3 vNormal;
varying vec3 vPos;
varying vec3 vEyePos;
varying vec2 vUv;
varying vec3 vMPos;

#!SHADER: Vertex

#require(range.glsl)
#require(simplenoise.glsl)

void setupFBR(vec3 p0) { //inlinemain
    vNormal = normalMatrix * normal;
    vUv = uv;
    vPos = p0;
    vec4 mPos = modelMatrix * vec4(p0, 1.0);
    vMPos = mPos.xyz / mPos.w;
    vEyePos = vec3(modelViewMatrix * vec4(p0, 1.0));
}

void main() {
    vec3 pos = position;
    setupFBR(pos);

    pos += cnoise(pos.xz * uWavinessScale + sin(time * uWavinessSpeed + pos.x)) * uWaviness;

    vec4 modelViewPos = modelViewMatrix * vec4(pos, 1.0);
    gl_Position = projectionMatrix * modelViewPos;
}

#!SHADER: Fragment

#require(transformUV.glsl)

const float PI = 3.14159265359;
const float PI2 = 6.28318530718;
const float RECIPROCAL_PI = 0.31830988618;
const float RECIPROCAL_PI2 = 0.15915494;
const float LOG2 = 1.442695;
const float EPSILON = 1e-6;
const float LN2 = 0.6931472;

vec2 reflectMatcapFBR(vec3 position, mat4 modelViewMatrix, vec3 normal) {
    vec4 p = vec4(position, 1.0);

    vec3 e = normalize(vec3(modelViewMatrix * p));
    vec3 n = normalize(normal);
    vec3 r = reflect(e, n);
    float m = 2.0 * sqrt(
    pow(r.x, 2.0) +
    pow(r.y, 2.0) +
    pow(r.z + 1.0, 2.0)
    );

    vec2 uv = r.xy / m + .5;

    return uv;
}

float prange(float oldValue, float oldMin, float oldMax, float newMin, float newMax) {
    float oldRange = oldMax - oldMin;
    float newRange = newMax - newMin;
    return (((oldValue - oldMin) * newRange) / oldRange) + newMin;
}

float pcrange(float oldValue, float oldMin, float oldMax, float newMin, float newMax) {
    return clamp(prange(oldValue, oldMin, oldMax, newMin, newMax), min(newMax, newMin), max(newMin, newMax));
}

vec3 unpackNormalFBR( vec3 eye_pos, vec3 surf_norm, sampler2D normal_map, float intensity, float scale, vec2 uv ) {
    surf_norm = normalize(surf_norm);

    vec3 q0 = dFdx( eye_pos.xyz );
    vec3 q1 = dFdy( eye_pos.xyz );
    vec2 st0 = dFdx( uv.st );
    vec2 st1 = dFdy( uv.st );

    vec3 S = normalize( q0 * st1.t - q1 * st0.t );
    vec3 T = normalize( -q0 * st1.s + q1 * st0.s );
    vec3 N = normalize( surf_norm );

    vec3 mapN = texture2D( normal_map, uv * scale ).xyz * 2.0 - 1.0;
    mapN.xy *= intensity;
    mat3 tsn = mat3( S, T, N );
    return normalize( tsn * mapN );
}

float geometricOcclusion(float NdL, float NdV, float roughness) {
    float r = roughness;
    float attenuationL = 2.0 * NdL / (NdL + sqrt(r * r + (1.0 - r * r) * (NdL * NdL)));
    float attenuationV = 2.0 * NdV / (NdV + sqrt(r * r + (1.0 - r * r) * (NdV * NdV)));
    return attenuationL * attenuationV;
}

float microfacetDistribution(float roughness, float NdH) {
    float roughnessSq = roughness * roughness;
    float f = (NdH * roughnessSq - NdH) * NdH + 1.0;
    return roughnessSq / (PI * f * f);
}

vec3 getFBR(vec3 baseColor) {
    vec3 mro = texture2D(tMRO, vUv).rgb;
    float roughness = mro.g * uRoughnessStr;

    vec3 normal = unpackNormalFBR(vEyePos, vNormal, tNormal, uNormalStrength, 1.0, vUv);
    vec2 aUV = reflectMatcapFBR(vPos, projectionMatrix, normal);
    vec2 bUV = reflectMatcapFBR(vPos, modelMatrix, normal);
    vec2 mUV = mix(aUV, bUV, roughness);

    vec3 V = normalize(cameraPosition - vMPos);
    vec3 L = normalize(uLight.xyz);
    vec3 H = normalize(L + V);
    vec3 reflection = -normalize(reflect(V, normal));

    float NdL = pcrange(clamp(dot(normal, L), 0.001, 1.0), 0.0, 1.0, 0.4, 1.0);
    float NdV = pcrange(clamp(abs(dot(normal, V)), 0.001, 1.0), 0.0, 1.0, 0.4, 1.0);
    float NdH = clamp(dot(normal, H), 0.0, 1.0);
    float VdH = clamp(dot(V, H), 0.0, 1.0);

    float G = geometricOcclusion(NdL, NdV, roughness);
    float D = microfacetDistribution(roughness, NdH);

    vec3 specContrib = G * D / (4.0 * NdL * NdV) * uColor;
    vec3 color = NdL * specContrib * uLight.w;

    return ((baseColor * texture2D(tMatcap, rotateUV(mUV, uMatcapRotate)).rgb) + color) * mro.b;
}

vec3 getFBR() {
    float roughness = texture2D(tMRO, vUv).g * uRoughnessStr;

    vec3 normal = unpackNormalFBR(vEyePos, vNormal, tNormal, uNormalStrength, 1.0, vUv);
    vec2 aUV = reflectMatcapFBR(vPos, projectionMatrix, normal);
    vec2 bUV = reflectMatcapFBR(vPos, modelMatrix, normal);
    vec2 mUV = mix(aUV, bUV, roughness);
    vec2 rUV = rotateUV(mUV, uMatcapRotate);

    return texture2D(tMatcap, rUV).rgb;
}

vec3 getFBRSimplified() {
    vec2 mUV = reflectMatcapFBR(vPos, modelViewMatrix, vNormal);
    return texture2D(tMatcap, mUV).rgb;
}


void main() {
    vec3 color = texture2D(tMap, vUv).rgb;
    vec3 fbr = getFBR(vec3(1.0));
    float strength = uFBRStrength * texture2D(tMRO, vUv).b;

    color *= uColorMult;
    color += uColorBrighten;
    color += fbr * strength;

    color = mix(color, vec3(0.05 + color.r * 0.1), uDarken);

    gl_FragColor = vec4(color, 1.0);

    float d = length(vEyePos);
    gl_FragColor.a *= smoothstep(uFogRange.y, uFogRange.x, vMPos.z) * smoothstep(uFogRangeNear.y, uFogRangeNear.x, vMPos.z);
}{@}AdidasFBR2Env.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform vec2 uFogRange;
uniform vec2 uFogRangeNear;
uniform float uFBRStrength;
uniform float uMatcapRotate;
uniform float uDarken;

uniform float uColorMult;
uniform float uColorBrighten;
uniform float uNormalStrength;
uniform float uRoughnessStr;

uniform sampler2D tMRO;
uniform sampler2D tMatcap;
uniform sampler2D tNormal;
uniform vec4 uLight;
uniform vec3 uColor;

#!VARYINGS

varying vec3 vNormal;
varying vec3 vPos;
varying vec3 vEyePos;
varying vec2 vUv;
varying vec3 vMPos;

#!SHADER: Vertex

#require(range.glsl)
#require(simplenoise.glsl)

void setupFBR(vec3 p0) { //inlinemain
    vNormal = normalMatrix * normal;
    vUv = uv;
    vPos = p0;
    vec4 mPos = modelMatrix * vec4(p0, 1.0);
    vMPos = mPos.xyz / mPos.w;
    vEyePos = vec3(modelViewMatrix * vec4(p0, 1.0));
}

void main() {
    vec3 pos = position;
    setupFBR(pos);

    // TODO: include it on all the product shaders
    //pos += cnoise(pos.xz+time*0.1)*0.01;

    vec4 modelViewPos = modelViewMatrix * vec4(pos, 1.0);
    gl_Position = projectionMatrix * modelViewPos;
}

#!SHADER: Fragment

#require(transformUV.glsl)

const float PI = 3.14159265359;
const float PI2 = 6.28318530718;
const float RECIPROCAL_PI = 0.31830988618;
const float RECIPROCAL_PI2 = 0.15915494;
const float LOG2 = 1.442695;
const float EPSILON = 1e-6;
const float LN2 = 0.6931472;

vec2 reflectMatcapFBR(vec3 position, mat4 modelViewMatrix, vec3 normal) {
    vec4 p = vec4(position, 1.0);

    vec3 e = normalize(vec3(modelViewMatrix * p));
    vec3 n = normalize(normal);
    vec3 r = reflect(e, n);
    float m = 2.0 * sqrt(
    pow(r.x, 2.0) +
    pow(r.y, 2.0) +
    pow(r.z + 1.0, 2.0)
    );

    vec2 uv = r.xy / m + .5;

    return uv;
}

float prange(float oldValue, float oldMin, float oldMax, float newMin, float newMax) {
    float oldRange = oldMax - oldMin;
    float newRange = newMax - newMin;
    return (((oldValue - oldMin) * newRange) / oldRange) + newMin;
}

float pcrange(float oldValue, float oldMin, float oldMax, float newMin, float newMax) {
    return clamp(prange(oldValue, oldMin, oldMax, newMin, newMax), min(newMax, newMin), max(newMin, newMax));
}

vec3 unpackNormalFBR( vec3 eye_pos, vec3 surf_norm, sampler2D normal_map, float intensity, float scale, vec2 uv ) {
    surf_norm = normalize(surf_norm);

    vec3 q0 = dFdx( eye_pos.xyz );
    vec3 q1 = dFdy( eye_pos.xyz );
    vec2 st0 = dFdx( uv.st );
    vec2 st1 = dFdy( uv.st );

    vec3 S = normalize( q0 * st1.t - q1 * st0.t );
    vec3 T = normalize( -q0 * st1.s + q1 * st0.s );
    vec3 N = normalize( surf_norm );

    vec3 mapN = texture2D( normal_map, uv * scale ).xyz * 2.0 - 1.0;
    mapN.xy *= intensity;
    mat3 tsn = mat3( S, T, N );
    return normalize( tsn * mapN );
}

float geometricOcclusion(float NdL, float NdV, float roughness) {
    float r = roughness;
    float attenuationL = 2.0 * NdL / (NdL + sqrt(r * r + (1.0 - r * r) * (NdL * NdL)));
    float attenuationV = 2.0 * NdV / (NdV + sqrt(r * r + (1.0 - r * r) * (NdV * NdV)));
    return attenuationL * attenuationV;
}

float microfacetDistribution(float roughness, float NdH) {
    float roughnessSq = roughness * roughness;
    float f = (NdH * roughnessSq - NdH) * NdH + 1.0;
    return roughnessSq / (PI * f * f);
}

vec3 getFBR(vec3 baseColor) {
    vec3 mro = texture2D(tMRO, vUv).rgb;
    float roughness = mro.g * uRoughnessStr;

    vec3 normal = unpackNormalFBR(vEyePos, vNormal, tNormal, uNormalStrength, 1.0, vUv);
    vec2 aUV = reflectMatcapFBR(vPos, projectionMatrix, normal);
    vec2 bUV = reflectMatcapFBR(vPos, modelMatrix, normal);
    vec2 mUV = mix(aUV, bUV, roughness);

    vec3 V = normalize(cameraPosition - vMPos);
    vec3 L = normalize(uLight.xyz);
    vec3 H = normalize(L + V);
    vec3 reflection = -normalize(reflect(V, normal));

    float NdL = pcrange(clamp(dot(normal, L), 0.001, 1.0), 0.0, 1.0, 0.4, 1.0);
    float NdV = pcrange(clamp(abs(dot(normal, V)), 0.001, 1.0), 0.0, 1.0, 0.4, 1.0);
    float NdH = clamp(dot(normal, H), 0.0, 1.0);
    float VdH = clamp(dot(V, H), 0.0, 1.0);

    float G = geometricOcclusion(NdL, NdV, roughness);
    float D = microfacetDistribution(roughness, NdH);

    vec3 specContrib = G * D / (4.0 * NdL * NdV) * uColor;
    vec3 color = NdL * specContrib * uLight.w;

    return ((baseColor * texture2D(tMatcap, rotateUV(mUV, uMatcapRotate)).rgb) + color) * mro.b;
}

vec3 getFBR() {
    float roughness = texture2D(tMRO, vUv).g * uRoughnessStr;

    vec3 normal = unpackNormalFBR(vEyePos, vNormal, tNormal, uNormalStrength, 1.0, vUv);
    vec2 aUV = reflectMatcapFBR(vPos, projectionMatrix, normal);
    vec2 bUV = reflectMatcapFBR(vPos, modelMatrix, normal);
    vec2 mUV = mix(aUV, bUV, roughness);
    vec2 rUV = rotateUV(mUV, uMatcapRotate);

    return texture2D(tMatcap, rUV).rgb;
}

vec3 getFBRSimplified() {
    vec2 mUV = reflectMatcapFBR(vPos, modelViewMatrix, vNormal);
    return texture2D(tMatcap, mUV).rgb;
}


void main() {
    vec3 color = texture2D(tMap, vUv).rgb;
    vec3 fbr = getFBR(vec3(1.0));
    float strength = uFBRStrength * texture2D(tMRO, vUv).b;

    color *= uColorMult;
    color += uColorBrighten;
    color += fbr * strength;

    color = mix(color, vec3(0.05 + color.r * 0.1), uDarken);

    gl_FragColor = vec4(color, 1.0);

    float d = length(vEyePos);
    gl_FragColor.a *= smoothstep(uFogRange.y, uFogRange.x, vMPos.z) * smoothstep(uFogRangeNear.y, uFogRangeNear.x, vMPos.z);
}{@}AdidasFBR2Tr2.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform vec2 uFogRange;
uniform vec2 uFogRangeNear;
uniform float uFBRStrength;
uniform float uMatcapRotate;
uniform float uTransition;
uniform vec2 uTransitionLimits;

uniform float uColorBrighten;
uniform float uColorMult;
uniform float uNormalStrength;
uniform float uRoughnessStr;

uniform sampler2D tMRO;
uniform sampler2D tMatcap;
uniform sampler2D tNormal;
uniform vec4 uLight;
uniform vec3 uColor;

uniform float uWaviness;
uniform float uWavinessSpeed;
uniform float uWavinessScale;

#!VARYINGS

varying vec3 vNormal;
varying vec3 vPos;
varying vec3 vEyePos;
varying vec2 vUv;
varying vec3 vMPos;

#!SHADER: Vertex

#require(range.glsl)
#require(simplenoise.glsl)

void setupFBR(vec3 p0) { //inlinemain
    vNormal = normalMatrix * normal;
    vUv = uv;
    vPos = p0;
    vec4 mPos = modelMatrix * vec4(p0, 1.0);
    vMPos = mPos.xyz / mPos.w;
    vEyePos = vec3(modelViewMatrix * vec4(p0, 1.0));
}

void main() {
    vec3 pos = position;
    setupFBR(pos);

    pos += cnoise(pos.xz * uWavinessScale + sin(time * uWavinessSpeed + pos.x)) * uWaviness;

    vec4 modelViewPos = modelViewMatrix * vec4(pos, 1.0);
    gl_Position = projectionMatrix * modelViewPos;
}

#!SHADER: Fragment

#require(transformUV.glsl)
#require(range.glsl)

const float PI = 3.14159265359;
const float PI2 = 6.28318530718;
const float RECIPROCAL_PI = 0.31830988618;
const float RECIPROCAL_PI2 = 0.15915494;
const float LOG2 = 1.442695;
const float EPSILON = 1e-6;
const float LN2 = 0.6931472;

vec2 reflectMatcapFBR(vec3 position, mat4 modelViewMatrix, vec3 normal) {
    vec4 p = vec4(position, 1.0);

    vec3 e = normalize(vec3(modelViewMatrix * p));
    vec3 n = normalize(normal);
    vec3 r = reflect(e, n);
    float m = 2.0 * sqrt(
    pow(r.x, 2.0) +
    pow(r.y, 2.0) +
    pow(r.z + 1.0, 2.0)
    );

    vec2 uv = r.xy / m + .5;

    return uv;
}

float prange(float oldValue, float oldMin, float oldMax, float newMin, float newMax) {
    float oldRange = oldMax - oldMin;
    float newRange = newMax - newMin;
    return (((oldValue - oldMin) * newRange) / oldRange) + newMin;
}

float pcrange(float oldValue, float oldMin, float oldMax, float newMin, float newMax) {
    return clamp(prange(oldValue, oldMin, oldMax, newMin, newMax), min(newMax, newMin), max(newMin, newMax));
}

vec3 unpackNormalFBR( vec3 eye_pos, vec3 surf_norm, sampler2D normal_map, float intensity, float scale, vec2 uv ) {
    surf_norm = normalize(surf_norm);

    vec3 q0 = dFdx( eye_pos.xyz );
    vec3 q1 = dFdy( eye_pos.xyz );
    vec2 st0 = dFdx( uv.st );
    vec2 st1 = dFdy( uv.st );

    vec3 S = normalize( q0 * st1.t - q1 * st0.t );
    vec3 T = normalize( -q0 * st1.s + q1 * st0.s );
    vec3 N = normalize( surf_norm );

    vec3 mapN = texture2D( normal_map, uv * scale ).xyz * 2.0 - 1.0;
    mapN.xy *= intensity;
    mat3 tsn = mat3( S, T, N );
    return normalize( tsn * mapN );
}

float geometricOcclusion(float NdL, float NdV, float roughness) {
    float r = roughness;
    float attenuationL = 2.0 * NdL / (NdL + sqrt(r * r + (1.0 - r * r) * (NdL * NdL)));
    float attenuationV = 2.0 * NdV / (NdV + sqrt(r * r + (1.0 - r * r) * (NdV * NdV)));
    return attenuationL * attenuationV;
}

float microfacetDistribution(float roughness, float NdH) {
    float roughnessSq = roughness * roughness;
    float f = (NdH * roughnessSq - NdH) * NdH + 1.0;
    return roughnessSq / (PI * f * f);
}

vec3 getFBR(vec3 baseColor) {
    vec3 mro = texture2D(tMRO, vUv).rgb;
    float roughness = mro.g * uRoughnessStr;

    vec3 normal = unpackNormalFBR(vEyePos, vNormal, tNormal, uNormalStrength, 1.0, vUv);
    vec2 aUV = reflectMatcapFBR(vPos, projectionMatrix, normal);
    vec2 bUV = reflectMatcapFBR(vPos, modelMatrix, normal);
    vec2 mUV = mix(aUV, bUV, roughness);

    vec3 V = normalize(cameraPosition - vMPos);
    vec3 L = normalize(uLight.xyz);
    vec3 H = normalize(L + V);
    vec3 reflection = -normalize(reflect(V, normal));

    float NdL = pcrange(clamp(dot(normal, L), 0.001, 1.0), 0.0, 1.0, 0.4, 1.0);
    float NdV = pcrange(clamp(abs(dot(normal, V)), 0.001, 1.0), 0.0, 1.0, 0.4, 1.0);
    float NdH = clamp(dot(normal, H), 0.0, 1.0);
    float VdH = clamp(dot(V, H), 0.0, 1.0);

    float G = geometricOcclusion(NdL, NdV, roughness);
    float D = microfacetDistribution(roughness, NdH);

    vec3 specContrib = G * D / (4.0 * NdL * NdV) * uColor;
    vec3 color = NdL * specContrib * uLight.w;

    return ((baseColor * texture2D(tMatcap, rotateUV(mUV, uMatcapRotate)).rgb) + color) * mro.b;
}

vec3 getFBR() {
    float roughness = texture2D(tMRO, vUv).g * uRoughnessStr;

    vec3 normal = unpackNormalFBR(vEyePos, vNormal, tNormal, uNormalStrength, 1.0, vUv);
    vec2 aUV = reflectMatcapFBR(vPos, projectionMatrix, normal);
    vec2 bUV = reflectMatcapFBR(vPos, modelMatrix, normal);
    vec2 mUV = mix(aUV, bUV, roughness);
    vec2 rUV = rotateUV(mUV, uMatcapRotate);

    return texture2D(tMatcap, rUV).rgb;
}

vec3 getFBRSimplified() {
    vec2 mUV = reflectMatcapFBR(vPos, modelViewMatrix, vNormal);
    return texture2D(tMatcap, mUV).rgb;
}

float parabola( float x, float k ) {
    return pow( 4.0*x*(1.0-x), k );
}

float linearstep(float begin, float end, float t) {
    return clamp((t - begin) / (end - begin), 0.0, 1.0);
}

float hscan(float _input, float start, float end, float contrast, float progress) {
    float margin = contrast;
    float p = mix(start + margin, end, progress);
    return linearstep(p - margin, p, _input);
}

float hscansmooth(float _input, float start, float end, float contrast, float progress) {
    float margin = contrast;
    float p = mix(start + margin, end, progress);
    return smoothstep(p - margin, p, _input);
}

const float divisions = 6.0;

void main() {
    float remappedX = crange(vMPos.x, -2.0, 2.0, 0.0, 1.0);
    float pos = vMPos.y + remappedX;
    float stripes = abs(mod(pos * divisions, 1.0) * 2.0 - 1.0);

    float bigtr = hscansmooth(pos, uTransitionLimits.y, uTransitionLimits.x, -0.5, uTransition);
    float tr = hscansmooth(stripes, 0.0, 1.0, 0.0001, bigtr);
    if (tr < 0.01) discard;

    vec3 color = texture2D(tMap, vUv).rgb;
    vec3 fbr = getFBR(vec3(1.0));
    float strength = uFBRStrength * texture2D(tMRO, vUv).g;

    color *= uColorMult;
    color += uColorBrighten;
    color += fbr * strength;

    gl_FragColor = vec4(color, 1.0);

    float d = length(vEyePos);
    gl_FragColor.a *= smoothstep(uFogRange.y, uFogRange.x, vMPos.z) * smoothstep(uFogRangeNear.y, uFogRangeNear.x, vMPos.z);
}{@}AdidasFBR2Tr.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform vec2 uFogRange;
uniform vec2 uFogRangeNear;
uniform float uFBRStrength;
uniform float uMatcapRotate;
uniform float uTransition;
uniform float uColorMult;
uniform vec2 uTransitionLimits;
uniform float uColorBrighten;
uniform float uNormalStrength;
uniform float uRoughnessStr;

uniform sampler2D tMRO;
uniform sampler2D tMatcap;
uniform sampler2D tNormal;
uniform vec4 uLight;
uniform vec3 uColor;

uniform float uWaviness;
uniform float uWavinessSpeed;
uniform float uWavinessScale;

#!VARYINGS

varying vec3 vNormal;
varying vec3 vPos;
varying vec3 vEyePos;
varying vec2 vUv;
varying vec3 vMPos;

#!SHADER: Vertex

#require(range.glsl)
#require(simplenoise.glsl)

void setupFBR(vec3 p0) { //inlinemain
    vNormal = normalMatrix * normal;
    vUv = uv;
    vPos = p0;
    vec4 mPos = modelMatrix * vec4(p0, 1.0);
    vMPos = mPos.xyz / mPos.w;
    vEyePos = vec3(modelViewMatrix * vec4(p0, 1.0));
}

void main() {
    vec3 pos = position;
    setupFBR(pos);

    pos += cnoise(pos.xz * uWavinessScale + sin(time * uWavinessSpeed + pos.x)) * uWaviness;

    vec4 modelViewPos = modelViewMatrix * vec4(pos, 1.0);
    gl_Position = projectionMatrix * modelViewPos;
}

#!SHADER: Fragment

#require(transformUV.glsl)
#require(range.glsl)

const float PI = 3.14159265359;
const float PI2 = 6.28318530718;
const float RECIPROCAL_PI = 0.31830988618;
const float RECIPROCAL_PI2 = 0.15915494;
const float LOG2 = 1.442695;
const float EPSILON = 1e-6;
const float LN2 = 0.6931472;

vec2 reflectMatcapFBR(vec3 position, mat4 modelViewMatrix, vec3 normal) {
    vec4 p = vec4(position, 1.0);

    vec3 e = normalize(vec3(modelViewMatrix * p));
    vec3 n = normalize(normal);
    vec3 r = reflect(e, n);
    float m = 2.0 * sqrt(
    pow(r.x, 2.0) +
    pow(r.y, 2.0) +
    pow(r.z + 1.0, 2.0)
    );

    vec2 uv = r.xy / m + .5;

    return uv;
}

float prange(float oldValue, float oldMin, float oldMax, float newMin, float newMax) {
    float oldRange = oldMax - oldMin;
    float newRange = newMax - newMin;
    return (((oldValue - oldMin) * newRange) / oldRange) + newMin;
}

float pcrange(float oldValue, float oldMin, float oldMax, float newMin, float newMax) {
    return clamp(prange(oldValue, oldMin, oldMax, newMin, newMax), min(newMax, newMin), max(newMin, newMax));
}

vec3 unpackNormalFBR( vec3 eye_pos, vec3 surf_norm, sampler2D normal_map, float intensity, float scale, vec2 uv ) {
    surf_norm = normalize(surf_norm);

    vec3 q0 = dFdx( eye_pos.xyz );
    vec3 q1 = dFdy( eye_pos.xyz );
    vec2 st0 = dFdx( uv.st );
    vec2 st1 = dFdy( uv.st );

    vec3 S = normalize( q0 * st1.t - q1 * st0.t );
    vec3 T = normalize( -q0 * st1.s + q1 * st0.s );
    vec3 N = normalize( surf_norm );

    vec3 mapN = texture2D( normal_map, uv * scale ).xyz * 2.0 - 1.0;
    mapN.xy *= intensity;
    mat3 tsn = mat3( S, T, N );
    return normalize( tsn * mapN );
}

float geometricOcclusion(float NdL, float NdV, float roughness) {
    float r = roughness;
    float attenuationL = 2.0 * NdL / (NdL + sqrt(r * r + (1.0 - r * r) * (NdL * NdL)));
    float attenuationV = 2.0 * NdV / (NdV + sqrt(r * r + (1.0 - r * r) * (NdV * NdV)));
    return attenuationL * attenuationV;
}

float microfacetDistribution(float roughness, float NdH) {
    float roughnessSq = roughness * roughness;
    float f = (NdH * roughnessSq - NdH) * NdH + 1.0;
    return roughnessSq / (PI * f * f);
}

vec3 getFBR(vec3 baseColor) {
    vec3 mro = texture2D(tMRO, vUv).rgb;
    float roughness = mro.g * uRoughnessStr;

    vec3 normal = unpackNormalFBR(vEyePos, vNormal, tNormal, uNormalStrength, 1.0, vUv);
    vec2 aUV = reflectMatcapFBR(vPos, projectionMatrix, normal);
    vec2 bUV = reflectMatcapFBR(vPos, modelMatrix, normal);
    vec2 mUV = mix(aUV, bUV, roughness);

    vec3 V = normalize(cameraPosition - vMPos);
    vec3 L = normalize(uLight.xyz);
    vec3 H = normalize(L + V);
    vec3 reflection = -normalize(reflect(V, normal));

    float NdL = pcrange(clamp(dot(normal, L), 0.001, 1.0), 0.0, 1.0, 0.4, 1.0);
    float NdV = pcrange(clamp(abs(dot(normal, V)), 0.001, 1.0), 0.0, 1.0, 0.4, 1.0);
    float NdH = clamp(dot(normal, H), 0.0, 1.0);
    float VdH = clamp(dot(V, H), 0.0, 1.0);

    float G = geometricOcclusion(NdL, NdV, roughness);
    float D = microfacetDistribution(roughness, NdH);

    vec3 specContrib = G * D / (4.0 * NdL * NdV) * uColor;
    vec3 color = NdL * specContrib * uLight.w;

    return ((baseColor * texture2D(tMatcap, rotateUV(mUV, uMatcapRotate)).rgb) + color) * mro.b;
}

vec3 getFBR() {
    float roughness = texture2D(tMRO, vUv).g * uRoughnessStr;

    vec3 normal = unpackNormalFBR(vEyePos, vNormal, tNormal, uNormalStrength, 1.0, vUv);
    vec2 aUV = reflectMatcapFBR(vPos, projectionMatrix, normal);
    vec2 bUV = reflectMatcapFBR(vPos, modelMatrix, normal);
    vec2 mUV = mix(aUV, bUV, roughness);
    vec2 rUV = rotateUV(mUV, uMatcapRotate);

    return texture2D(tMatcap, rUV).rgb;
}

vec3 getFBRSimplified() {
    vec2 mUV = reflectMatcapFBR(vPos, modelViewMatrix, vNormal);
    return texture2D(tMatcap, mUV).rgb;
}

float parabola( float x, float k ) {
    return pow( 4.0*x*(1.0-x), k );
}

float linearstep(float begin, float end, float t) {
    return clamp((t - begin) / (end - begin), 0.0, 1.0);
}

float hscan(float _input, float start, float end, float contrast, float progress) {
    float margin = contrast;
    float p = mix(start + margin, end, progress);
    return linearstep(p - margin, p, _input);
}

float hscansmooth(float _input, float start, float end, float contrast, float progress) {
    float margin = contrast;
    float p = mix(start + margin, end, progress);
    return smoothstep(p - margin, p, _input);
}

const float divisions = 6.0;

void main() {
    float remappedX = crange(vMPos.x, -2.0, 2.0, 0.0, 1.0);
    float pos = vMPos.y + remappedX;
    float stripes = abs(mod(pos * divisions, 1.0) * 2.0 - 1.0);

    float bigtr = hscansmooth(pos, uTransitionLimits.y, uTransitionLimits.x, -0.5, uTransition);
    float tr = hscansmooth(stripes, 0.0, 1.0, 0.0001, bigtr);
    if (tr < 0.01) discard;

    vec3 color = texture2D(tMap, vUv).rgb;
    vec3 fbr = getFBR(vec3(1.0));
    float strength = uFBRStrength * texture2D(tMRO, vUv).g;

    color *= uColorMult;
    color += uColorBrighten;
    color += fbr * strength;

    gl_FragColor = vec4(color, 1.0);

    float d = length(vEyePos);
    gl_FragColor.a *= smoothstep(uFogRange.y, uFogRange.x, vMPos.z) * smoothstep(uFogRangeNear.y, uFogRangeNear.x, vMPos.z);
}{@}BallPBR.glsl{@}#!ATTRIBUTES

#!UNIFORMS

uniform vec3 uLightRange;
uniform float uShadowAmount;

#!VARYINGS

#!SHADER: Vertex

#require(range.glsl)
#require(pbr.vs)
#require(lighting.vs)

void main() {
    vec3 pos = position;
    vec3 transformedNormal = normal;
    setupLight(pos, transformedNormal);

    setupPBR(pos);

    vec4 modelViewPos = modelViewMatrix * vec4(pos, 1.0);
    gl_Position = projectionMatrix * modelViewPos;
}

#!SHADER: Fragment

#require(pbr.fs)
#require(lighting.fs)
#require(range.glsl)
#require(luma.fs)

void main() {
    setupLight();

    vec3 pbr = getPBR().rgb;

    vec3 pLight = getPointLightColor(getNormal(uNormalScale, tNormal, vUv, vNormal, vMPos));
    pbr += pLight;

    pbr *= 1.0 - crange(luma(pLight), uLightRange.y, uLightRange.x, 0.0, 1.0) * uLightRange.z * uShadowAmount;

    gl_FragColor = vec4(pbr, 1.0);
}{@}Bg1.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 uColor;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex

void main() {
    vUv = uv;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment

void main() {
    vec4 color = vec4(uColor, 1.0);

    gl_FragColor = color;
}{@}FixedBackground.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 uColor;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex

void main() {
    vUv = uv;
    gl_Position = vec4(position, 1.0);
}

#!SHADER: Fragment

#require(range.glsl)
#require(simplenoise.glsl)

void main() {
    vec4 color = vec4(uColor, 1.0);
    color.rgb *= 1.0 + cnoise(vec3(vUv*2.0,time*0.15)) * 0.03;
    gl_FragColor = color;
}{@}CameraTravelOverlay.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 uColor;
uniform float uStr;
uniform float uAlpha;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex

void main() {
    vUv = uv;
    gl_Position = vec4(position, 1.0);
}

#!SHADER: Fragment

void main() {
    vec4 color = vec4(uColor, uStr * uAlpha);
    gl_FragColor = color;
}{@}CircleShadow.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 uColor;
uniform vec2 uMargin;
uniform float uAlpha;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex

void main() {
    vUv = uv;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment

void main() {
    gl_FragColor.rgb = uColor;
    gl_FragColor.a = smoothstep(uMargin.y, uMargin.x, length(vUv - 0.5)) * uAlpha;
}{@}Crease.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 uColor;
uniform sampler2D tCrease;
uniform float uAlpha;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex

void main() {
    vUv = uv;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment

void main() {
    float c = texture2D(tCrease, vUv).r;
    vec4 color = vec4(uColor, 1.0);
    gl_FragColor = color;
    gl_FragColor.a = c * uAlpha;
}{@}EquirectBg.glsl{@}#!ATTRIBUTES

#!UNIFORMS

uniform sampler2D tEquirect;
uniform float uEquirectStr;
uniform float uAlpha;
uniform vec3 uBgColor;
uniform float uNoiseIntensity;
uniform float uNoiseFrequency;

#!VARYINGS

varying vec2 vUv;
varying vec3 wDir;

#!SHADER: Vertex

void main() {
    vUv = uv;
    wDir = (modelMatrix * vec4(position, 0.0)).xyz;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment

#require(parabolas.glsl)
#require(range.glsl)

#define RECIPROCAL_PI 0.31830988618
#define RECIPROCAL_PI2 0.15915494

void main() {
    vec3 direction = normalize(wDir);

    vec2 sampleUV;
    sampleUV.y = asin(clamp(direction.y, - 1.0, 1.0)) * RECIPROCAL_PI + 0.5;
    sampleUV.x = atan(direction.z, direction.x) * RECIPROCAL_PI2 + 0.5;

    vec3 color = texture2D(tEquirect, sampleUV).rgb;
    float t = 1.0 - parabola(crange(mod(time * uNoiseFrequency, 1.0), 0.9, 1.0, 0.0, 1.0), 1.0) * uNoiseIntensity;
    color = mix(uBgColor, color, uEquirectStr * t);

    gl_FragColor = vec4(mix(uBgColor, color, uAlpha), 1.0);
}{@}FloatingParticles.glsl{@}#!ATTRIBUTES

attribute vec4 random;

#!UNIFORMS

uniform sampler2D tParticle;
uniform float uSpan;
uniform float uMinSize;
uniform float uMaxSize;
uniform float uOpacity;
uniform float uSpeed;
uniform float uAlpha;

#!VARYINGS

varying vec4 vRandom;

#!SHADER: Vertex

void main() {
    vRandom = random;

    vec3 pos = vec3(
        mix(-uSpan, uSpan, position.x),
        mix(-uSpan, uSpan, position.y),
        mix(-uSpan, uSpan, position.z)
    );

    float timeMult = uSpeed;

    pos.x += sin(time * timeMult * random.x + random.y * 6.28) * mix(uSpan * 0.1, uSpan * 0.5, random.z);
    pos.y += sin(time * timeMult * random.w + random.x * 6.28) * mix(uSpan * 0.1, uSpan * 0.5, random.y);
    pos.z += sin(time * timeMult * random.z + random.w * 6.28) * mix(uSpan * 0.1, uSpan * 0.5, random.x);

    vec4 mvPos = modelViewMatrix * vec4(pos, 1.0);
    gl_Position = projectionMatrix * mvPos;
    gl_PointSize = mix(uMinSize, uMaxSize, random.x) * 500.0 / length(mvPos.xyz);
}

#!SHADER: Fragment

void rotate2D(inout vec2 v, float a) {
	float s = sin(a);
	float c = cos(a);
	mat2 m = mat2(c, -s, s, c);
	v = m * v;
}

void main() {
    vec2 uv = vec2(gl_PointCoord.x, 1.0 - gl_PointCoord.y);
    uv -= 0.5;
    rotate2D(uv, mix(0.0, 6.26, vRandom.x));
    uv.x *= mix(1.0, 1.5, vRandom.y);
    uv.y *= mix(1.0, 1.5, vRandom.w);
    uv += 0.5;

    float alpha = mix(0.05, uOpacity, vRandom.y);
    alpha *= max(0.0, mix(-0.5, 1.0, sin(time * 0.5 * vRandom.x + vRandom.w * 6.28) * 0.5 + 0.5));

    gl_FragColor.rgb = texture2D(tParticle, uv).rgb;
    gl_FragColor.a = alpha * uAlpha;
}
{@}GradientPlane.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 uColor;
uniform float uPower;
uniform float uAlpha;
uniform float uTransition;

#!VARYINGS
varying vec2 vUv;
varying vec3 vMPos;

#!SHADER: Vertex

void main() {
    vUv = uv;
    vMPos = (modelMatrix * vec4(position, 1.0)).xyz;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment

#require(range.glsl)

float parabola( float x, float k ) {
    return pow( 4.0*x*(1.0-x), k );
}

float hscansmooth(float _input, float start, float end, float contrast, float progress) {
    float margin = contrast;
    float p = mix(start + margin, end, progress);
    return smoothstep(p - margin, p, _input);
}

// range: 1.25, -0.25

const float divisions = 6.0;

void main() {
    float remappedX = crange(vMPos.x, -2.0, 2.0, 0.0, 1.0);
    float pos = vMPos.y + remappedX;

    float stripes = abs(mod(pos * divisions, 1.0) * 2.0 - 1.0);
    float bigtr = hscansmooth(pos, -0.25, 1.25, -0.5, uTransition);
    float tr = hscansmooth(stripes, 0.0, 1.0, 0.0, bigtr);
    if (tr < 0.01) discard;

    float opacity = smoothstep(0.0, uPower, vUv.y) * smoothstep(1.0, 1.0 - uPower, vUv.y) * uAlpha;
    opacity *= smoothstep(0.55, 0.5, length(vUv - 0.5));
    vec4 color = vec4(uColor, opacity);
    gl_FragColor = color;
}{@}Line.glsl{@}#!ATTRIBUTES

#!UNIFORMS
#!VARYINGS

varying vec2 vUv;
uniform vec3 uColor;

#!SHADER: Line.vs

void main() {
    vUv = uv;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Line.fs

void main() {
    gl_FragColor.rgb = uColor;
    gl_FragColor.a = 1.;
}
{@}SkatePBR.glsl{@}#!ATTRIBUTES

#!UNIFORMS

uniform vec3 uLightRange;
uniform float uShadowAmount;

#!VARYINGS

#!SHADER: Vertex

#require(range.glsl)
#require(pbr.vs)
#require(lighting.vs)

void main() {
    vec3 pos = position;
    vec3 transformedNormal = normal;
    setupLight(pos, transformedNormal);

    setupPBR(pos);

    vec4 modelViewPos = modelViewMatrix * vec4(pos, 1.0);
    gl_Position = projectionMatrix * modelViewPos;
}

#!SHADER: Fragment

#require(pbr.fs)
#require(lighting.fs)
#require(range.glsl)
#require(luma.fs)

void main() {
    setupLight();

    vec3 pbr = getPBR().rgb;

    vec3 pLight = getPointLightColor(getNormal(uNormalScale, tNormal, vUv, vNormal, vMPos));
    pbr += pLight;

    pbr *= 1.0 - crange(luma(pLight), uLightRange.y, uLightRange.x, 0.0, 1.0) * uLightRange.z * uShadowAmount;

    gl_FragColor = vec4(pbr, 1.0);
}{@}Steam.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform float uSpeed;
uniform float uStrength;
uniform vec2 uBottomFadeRange;
uniform vec2 uSidesFadeRange;
uniform vec3 uTint;
uniform vec2 uScale;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
void main() {
    vUv = uv;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment

#require(range.glsl)

void main() {
    float t = time * uSpeed;
    float verticalGradient = 1.0 - vUv.y;

    verticalGradient *= smoothstep(uBottomFadeRange.x, uBottomFadeRange.y, vUv.y);
    verticalGradient *= smoothstep(uSidesFadeRange.x, uSidesFadeRange.y, vUv.x);
    verticalGradient *= smoothstep(uSidesFadeRange.x, uSidesFadeRange.y, 1.0 - vUv.x);

    float color = 1.0;
    vec4 color1 = texture2D(tMap, vUv * uScale + vec2(t * -0.03, 0.0));
    vec4 color2 = texture2D(tMap, vUv * 0.5 * uScale + vec2(t * -0.041, t * -0.025));
    color = color1.r * color2.g;
    color = crange(color, 0.2, 1.0, 0.0, 1.0);

    gl_FragColor.rgb = uTint.rgb;
    gl_FragColor.a = color * uStrength * verticalGradient;
}{@}CongratsBG.glsl{@}#!ATTRIBUTES


#!UNIFORMS
uniform sampler2D tMap;
uniform sampler2D tFabric;
uniform sampler2D tNormal;
uniform float uTime;
uniform float uScale;
uniform float uFrequency;
uniform float uDeform;
uniform float uvScale;
uniform vec3 uColor;
uniform float uColorMix;

#!VARYINGS
varying vec2 vUV;
varying vec4 vMPos;

#!SHADER: Vertex


void main() {
    vUV = uv;
    vMPos = modelViewMatrix * vec4(position, 1.0);
    gl_Position = projectionMatrix * vMPos;
}

#!SHADER: Fragment

float noise(vec3 pp) {

    vec3 p = pp;
    float f = uFrequency;
    p += .2*cos( f * 1.5*p.yxz + 1.0*uTime + vec3(0.1,1.1, 0.) );
	p += .2*cos( f * 2.4*p.yxz + 1.6*uTime + vec3(4.5,2.6, 0.) );
	p += .2*cos( f * 3.3*p.yxz + 1.2*uTime + vec3(3.2,3.4,0.) );
	p += .2*cos( f * 4.2*p.yzx + 1.7*uTime + vec3(1.8,5.2,0.) );
	p += .2*cos( f * 6.1*p.yxz + 1.1*uTime + vec3(6.3,3.9,0.) );

	float r = 0.1 * length( p );
    
    return r;
}


void main() {

    float eps = .003;
    vec2 st = 2. * vUV - 1.;
    vec3 pos0 = vec3(st, 0.);
    vec3 pos1 = vec3(st + vec2(eps, 0.), 0.);
    vec3 pos2 = vec3(st + vec2(0., eps), 0.);

    pos0.z = uScale * noise(pos0);
    pos1.z = uScale * noise(pos1);
    pos2.z = uScale * noise(pos2);

    vec3 n1 = normalize(pos0 - pos1);
    vec3 n2 = normalize(pos0 - pos2);

    vec3 normal = normalize(cross(n1, n2));  
    n1 = normalize(cross(normal, n2));
    n2 = normalize(cross(normal, n1));

    mat3 mat = mat3(normal, n1, n2);

    vec2 hg = 2. * vUV - 1.;
    float deformation = uvScale * (1. + 0.1 * uDeform * abs(normal.z));
    hg *= deformation;
    hg = 0.5 * hg + 0.5;

    vec3 texel = texture2D(tMap, hg).xyz;
    vec3 fabric = texture2D(tFabric, hg).xyz;

    vec3 fabricNormal = texture2D(tNormal, hg).xyz;
    fabricNormal = 2. * fabricNormal - 1.;

    fabricNormal = mat * fabricNormal;


    //phong shading
    vec3 light_dir = normalize(vec3(0., .10 , 0.1));
	float d = clamp(dot(fabricNormal, light_dir), 0., 1.);
    float light= d;

    texel = mix(texel, uColor, uColorMix);

    gl_FragColor = vec4(light * texel, 1.);


}{@}BallFXLines.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform vec3 uColor;
uniform vec2 uStep;
uniform float uTransition;
uniform float uDirection;

#!VARYINGS
varying vec2 vUv;
varying vec4 vPos;
varying vec3 vNormal;

#!SHADER: Vertex

void main() {
    vec3 pos = position;
    vUv = uv;
    vNormal = normalize(normalMatrix * normal);
    vPos = modelViewMatrix * vec4(position, 1.0);
    gl_Position = projectionMatrix * vPos;
}

#!SHADER: Fragment

#require(transformUV.glsl)

float parabola( float x, float k ) {
    return pow( 4.0*x*(1.0-x), k );
}
float cheapParabola(float x) {
    return 1.0 - abs(x * 2.0 - 1.0);
}

float getFresnel(vec3 normal, vec3 viewDir, float power) {
    float d = dot(normalize(normal), normalize(viewDir));
    return 1.0 - pow(abs(d), power);
}

void main() {

    vec2 uv = vUv;
    // uv *= 0.8;
    uv.x += time * 0.5 * uDirection;
    uv.y -= time * 0.01 + 0.1 * uTransition;

    float texel = texture2D(tMap, uv).r;
    float a = smoothstep(uStep.x,uStep.y, texel);
    a *= 1.0 - getFresnel(vNormal, vPos.xyz, 2.5);

    gl_FragColor.rgb = vec3(uColor);
    gl_FragColor.a = a * parabola(vUv.y, 2.0) * uTransition * 0.5;
}{@}InteractiveBall.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 uColor;

#!VARYINGS
varying vec2 vUv;
varying vec3 vNormal;

#!SHADER: Vertex

void main() {
    vUv = uv;
    vNormal = normalize(normalMatrix * normal);
    vec3 pos = (modelMatrix * vec4(position, 1.0)).xyz + vec3(0.0, sin(time) * 0.5, 0.0);
    gl_Position = projectionMatrix * viewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment

void main() {
    vec4 color = vec4(vec3(0.95), 1.0);
    gl_FragColor = color;
}{@}InteractiveScreen.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform float uWarp;
uniform float uHover;
uniform sampler2D tHover;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex

void main() {
    vUv = uv;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment

#require(parabolas.glsl)

void main() {
    float mult = 1.7;
    vec2 uv = vec2(vUv.x, vUv.y * mult - 0.725);

    vec2 uvWarp = vUv - vec2(0.5, 0.725);
    float l = length(uvWarp);
    vec2 dir = normalize(uvWarp);
    uv -= dir * smoothstep(0.0, 1.0, l) * (1.0 - uWarp) * 0.5;

    float lines = texture2D(tHover, vUv * vec2(4.5)).r * 2.0 - 1.0;
    float par =  parabola(uHover, 1.0);
    uv.x += mod(lines * par * 135.35654, 1.0) * 0.025 * par;

    vec4 color = texture2D(tMap, uv);
    gl_FragColor = color;
}{@}IntroFloorPBR.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform mat4 uMirrorMatrix;
uniform sampler2D tMirrorReflection;
uniform float uReflect;
uniform float uDarken;
uniform float uAlpha;

uniform float uPhongAttenuation;
uniform float uPhongShininess;
uniform vec3 uPhongColor;

uniform vec2 uRough;

uniform vec3 uFogPosition;
uniform vec2 uFogRange;

#!VARYINGS
varying vec4 vMirrorCoord;

#!SHADER: Vertex

#require(pbr.vs)
#require(lighting.vs)

void main() {
    setupLight(position, normal);
    setupPBR(position);

    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);

    vec4 worldPos = modelMatrix * vec4(position, 1.0);
    vMirrorCoord = uMirrorMatrix * worldPos;
}

#!SHADER: Fragment

#require(pbr.fs)
#require(lighting.fs)
#require(range.glsl)

void main() {
    setupLight();

    // get floor normal
    vec3 flNormal = getNormal(uNormalScale, tNormal, vUv, vNormal, vMPos);

    // get mirror image
    vec4 mirrorCoord = vMirrorCoord;
    mirrorCoord.xz += flNormal.xy;
    vec3 r = vec3(texture2D(tMirrorReflection, mirrorCoord.xy / mirrorCoord.w));

    // get mro
    vec3 mro = texture2D(tMRO, vUv).rgb;
    mro.y = crange(mro.y, uRough.x, uRough.y, 0.0, 1.0);


    // light config
    LightConfig lightConfig;
    lightConfig.normal = flNormal;
    lightConfig.phong = true;
    lightConfig.phongAttenuation = uPhongAttenuation;
    lightConfig.phongShininess = mro.y * uPhongShininess;
    lightConfig.phongColor = uPhongColor + mro.y * 2.0;

    // get color
    vec3 baseColor = texture2D(tBaseColor, vUv).rgb * uDarken;
    vec3 color = getPBR(baseColor).rgb;

    // add light
    color += getPointLightColor(lightConfig);

    // add mirror
    color += r * uReflect * crange(1.0 - mro.y, 0.0, 1.0, 0.2, 1.0);

    // set some fog
    gl_FragColor.rgb = color;
    gl_FragColor.a = smoothstep(uFogRange.y, uFogRange.x, length(vMPos.xyz - uFogPosition.xyz)) * uAlpha;
}{@}IntroHit.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 uColor;

#!VARYINGS

#!SHADER: Vertex

void main() {
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment

void main() {
    gl_FragColor.rgb = uColor;
    gl_FragColor.a = 1.0;
}{@}IntroStripe.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 uColor1;
uniform float uRatio;
uniform float uDisplacement;
uniform vec2 uDefaultImage;

uniform vec4 uLight;

uniform vec3 uColorImage1;
uniform vec3 uColorImage2;
uniform vec3 uColorImage3;

uniform vec3 uBlendStrImages;
uniform vec3 uHoveringImages;
uniform vec3 uDarkenImages;
uniform vec3 uOffsetImages;

uniform sampler2D tMap;
uniform sampler2D tMap2;
uniform sampler2D tMap3;
uniform sampler2D tEnv;
uniform sampler2D tDetails;
uniform sampler2D tMapBaked;

#!VARYINGS
varying vec2 vUv;
varying vec3 vNormal;
varying float vLight;
varying vec3 wPos;
varying vec3 vPos;

#!SHADER: Vertex

void main() {
    vUv = uv;

    vNormal = normalize(normalMatrix * normal);
    vLight = step(0.0, dot(normalize(normal), normalize(uLight.xyz)));
    wPos = (modelMatrix * vec4(position, 1.0)).xyz;
    vPos = (viewMatrix * vec4(wPos, 1.0)).xyz;

    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment

#define RECIPROCAL_PI 0.31830988618
#define RECIPROCAL_PI2 0.15915494

vec3 inverseTformDir(in vec3 dir, in mat4 matrix) {
	return normalize((vec4(dir, 0.0) * matrix).xyz);
}

// For use in fragment shader alone
vec4 envmap(vec3 mPos, vec3 normal, sampler2D uEnv) {

    // Requires uniforms cameraPosition, viewMatrix
    vec3 cameraToVertex = normalize(mPos - cameraPosition);
    vec3 worldNormal = inverseTformDir(normalize(normal), viewMatrix);
    vec3 reflect = normalize(reflect(cameraToVertex, worldNormal));

    vec2 uv;
    uv.y = asin(clamp(reflect.y, -1.0, 1.0)) * RECIPROCAL_PI + 0.5;
    uv.x = atan(reflect.z, reflect.x) * RECIPROCAL_PI2 + 0.5;
    return texture2D(uEnv, uv);
}

#require(transformUV.glsl)
#require(range.glsl)
#require(blendmodes.glsl)

vec3 getImage(sampler2D diffuse, float xOffset, float darken, vec3 blendColor, float blendStr) {
    vec2 uv = vec2(1.0 - vUv.x, 1.0 - vUv.y);
    uv = uv - vec2(1.5, 0.5); // uv trick
    uv.x *= uRatio;
    uv.x += xOffset;

    // displace here
    float disp = (wPos.x - cameraPosition.x) * uDisplacement;
    uv.x += disp;
    uv += 0.5;

    vec3 color = texture2D(diffuse, uv).rgb * (1.0 - darken);
    color = mix(color, blendLinearDodge(color, blendColor), blendStr);

    return color;
}

float parabola( float x, float k ) {
    return pow( 4.0*x*(1.0-x), k );
}

float linearstep(float begin, float end, float t) {
    return clamp((t - begin) / (end - begin), 0.0, 1.0);
}

float hscan(float _input, float start, float end, float contrast, float progress) {
    float margin = contrast;
    float p = mix(start + margin, end, progress);
    return linearstep(p - margin, p, _input);
}

float hscansmooth(float _input, float start, float end, float contrast, float progress) {
    float margin = contrast;
    float p = mix(start + margin, end, progress);
    return smoothstep(p - margin, p, _input);
}

vec3 getStripeColor(vec2 offset) {
    return texture2D(tMapBaked, vUv * 0.5 + offset).rgb;
}

const float divisions = 3.0;

void main() {
    vec3 color = vec3(1.0);

    // box
    if (vUv.x < 1.0) {
        vec3 c1 = getStripeColor(vec2(0.0, 0.5));
        vec3 c2 = getStripeColor(vec2(0.5, 0.5));
        vec3 c3 = getStripeColor(vec2(0.0, 0.0));
        vec3 c4 = getStripeColor(vec2(0.5, 0.0));

        // get color
        color = mix(c1, c2, uHoveringImages.x);
        color = mix(color, c3, uHoveringImages.y);
        color = mix(color, c4, uHoveringImages.z);

        // color = uColor1;
        // color *= 1.0 - vLight * uLight.w;

        // get matcap
        vec3 mat = envmap(wPos, vNormal, tEnv).rgb;
        mat = mat * mat;
        color += mat * 0.1;

        float detail = 1.0 - texture2D(tDetails, vUv + vec2(0.0, wPos.x)).r;
        color += detail * 0.05;

    } else {
        // get images
        vec3 img1 = getImage(tMap, uOffsetImages.x, uDarkenImages.x, uColorImage1, uBlendStrImages.x);
        vec3 img2 = getImage(tMap2, uOffsetImages.y, uDarkenImages.y, uColorImage2, uBlendStrImages.y);
        vec3 img3 = getImage(tMap3, uOffsetImages.z, uDarkenImages.z, uColorImage3, uBlendStrImages.z);

        // default image
        color = mix(img1, img2, uDefaultImage.x);
        color = mix(color, img3, uDefaultImage.y);

        // hover
        color = mix(color, img1, uHoveringImages.x);
        color = mix(color, img2, uHoveringImages.y);
        color = mix(color, img3, uHoveringImages.z);
    }

    gl_FragColor.rgb = color;
    gl_FragColor.a = 1.0;
}{@}PlexusEffect.glsl{@}#!ATTRIBUTES

attribute vec4 random;

#!UNIFORMS

uniform sampler2D tParticle;
uniform float uSpan;
uniform float uMinSize;
uniform float uMaxSize;
uniform float uOpacity;
uniform float uSpeed;
uniform float uAlpha;

#!VARYINGS

varying vec4 vRandom;

#!SHADER: Vertex

void main() {
    vRandom = random;

    vec4 mvPos = modelViewMatrix * vec4(position, 1.0);
    gl_Position = projectionMatrix * mvPos;
    gl_PointSize = mix(uMinSize, uMaxSize, random.x) * 100.0 / length(mvPos.xyz);
}

#!SHADER: Fragment

void rotate2D(inout vec2 v, float a) {
	float s = sin(a);
	float c = cos(a);
	mat2 m = mat2(c, -s, s, c);
	v = m * v;
}

void main() {

    vec2 uv = vec2(gl_PointCoord.x, 1.0 - gl_PointCoord.y);
    uv -= 0.5;
    rotate2D(uv, mix(0.0, 6.26, vRandom.x));
    uv.x *= mix(1.0, 1.5, vRandom.y);
    uv.y *= mix(1.0, 1.5, vRandom.w);
    uv += 0.5;

    float alpha = mix(0.05, uOpacity, vRandom.y);
    alpha *= max(0.0, mix(-0.5, 1.0, sin(time * 0.5 * vRandom.x + vRandom.w * 6.28) * 0.5 + 0.5));

    gl_FragColor.rgb = texture2D(tParticle, uv).rgb;
    gl_FragColor.a = alpha * uAlpha;
}
{@}PlexusLine.glsl{@}#!ATTRIBUTES
attribute vec3 colorAlpha;

#!UNIFORMS
uniform float uAlpha;

#!VARYINGS

varying vec2 vUv;
varying vec3 vColor;

#!SHADER: PlexusLine.vs

void main() {
    vUv = uv;
    vColor = colorAlpha;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: PlexusLine.fs

void main() {
    gl_FragColor.rgb = vec3(1.0);
    gl_FragColor.a = vColor.r * uAlpha;
}
{@}GradientLayerShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform float uType;
uniform float uAlpha;

uniform vec3 uColorA;
uniform vec3 uColorB;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
void main() {
    vUv = uv;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment
void main() {
    vec2 uv = vUv;
    vec4 gradient = vec4(0.);

    if (uType == 0.) {
        float dis = distance(vUv, vec2(1.));
        gradient = vec4(uColorA, dis);
    }
    if (uType == 1.) {
        gradient = vec4(mix(uColorB, uColorA, vUv.y) , 1.);
    }

    gl_FragColor = vec4(gradient);
    gl_FragColor.a *= uAlpha;
}{@}SmokeSphere.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform float uSpeed;
uniform float uStrength;
uniform vec3 uTint;
uniform vec2 uScale;
uniform float uAlpha;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
void main() {
    vUv = uv;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment

#require(range.glsl)

void main() {
    float t = time * uSpeed;

    float color = 1.0;
    vec4 color1 = texture2D(tMap, vUv * uScale + vec2(t * -0.002, -t * .03));
    vec4 color2 = texture2D(tMap, vUv * 0.5 * uScale + vec2(t * 0.0015, -t * 0.025));
    vec4 color3 = texture2D(tMap, vUv * 0.7 * uScale + vec2(t * 0.01, -t * 0.01));
    color = color1.r * color2.g * color3.b;
    color = crange(color, 0.2, 1.0, 0.0, 1.0);

    float fade = uAlpha;
    fade *= smoothstep(0., .15, vUv.x);
    fade *= smoothstep(0., .15, 1.0 - vUv.x);

    gl_FragColor.rgb = uTint.rgb;
    gl_FragColor.a = color * uStrength * fade;
}{@}Stripe.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 uColor;
uniform vec2 uIntroScale;
uniform vec2 uProductScale;
uniform vec2 uImgScale;
uniform vec2 uImageHoverScale;
uniform vec2 uImgOffset;
uniform float uTransition;
uniform float uIntro;
uniform float uScreenRatio;
uniform sampler2D tMap;
uniform sampler2D tProduct;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex

void main() {
    vUv = uv;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment
#require(transformUV.glsl)

void main() {
    // get the uv of screen
    vec2 uv = gl_FragCoord.xy / resolution.xy;

    vec3 bg = texture2D(tMap, uv).rgb;
    vec3 color = texture2D(tProduct, scaleUV(vUv + uImgOffset, uImgScale * uImageHoverScale)).rgb;
    // vec3 color = uColor;

    gl_FragColor.rgb = mix(color, bg, uTransition);
    gl_FragColor.a = 1.0;
}{@}TextSpline.glsl{@}#!ATTRIBUTES
attribute vec3 animation;
attribute vec4 uvLimits;

#!UNIFORMS
uniform sampler2D tMap;
uniform vec3 uColor;
uniform float uAlpha;
uniform vec3 uTranslate;
uniform vec3 uRotate;
uniform float uTransition;
uniform float uWordCount;
uniform float uLineCount;
uniform float uLetterCount;
uniform float uByWord;
uniform float uByLine;
uniform float uPadding;
uniform vec3 uBoundingMin;
uniform vec3 uBoundingMax;
uniform vec2 uAlphaDist;
uniform vec3 uFadeInColor;

uniform float uScreenRatio;
uniform float uCut;

#!VARYINGS
varying float vTrans;
varying vec2 vUv;
varying vec3 vPos;
varying vec3 vAnim;
varying vec4 vLimits;

#!SHADER: Vertex

#require(range.glsl)
#require(eases.glsl)
#require(rotation.glsl)
#require(conditionals.glsl)

float parabola( float x, float k ){
    return pow( 4.0*x*(1.0-x), k );
}

float linearstep(float begin, float end, float t) {
    return clamp((t - begin) / (end - begin), 0.0, 1.0);
}

float hscan(float _input, float start, float end, float contrast, float progress) {
    float margin = contrast;
    float p = mix(start + margin, end, progress);
    return linearstep(p - margin, p, _input);
}

float hscansmooth(float _input, float start, float end, float contrast, float progress) {
    float margin = contrast;
    float p = mix(start + margin, end, progress);
    return smoothstep(p - margin, p, _input);
}

void main() {
    vUv = uv;
    vAnim = animation;
    vLimits = uvLimits;

    vec3 pos = position;

    pos.z -= (1.0 - parabola(crange(pos.x, uBoundingMin.x, uBoundingMax.x, 0.0, 1.0), 0.5)) * .03;

    // letter progress
    const float margin = 0.6;
    float textA = hscan(vAnim.z, 0.0, 1.0, -margin, uTransition);
    float textB = hscan(vAnim.z, 1.0, 0.0, margin, uTransition);
    float textTR = mix(textA, textB, uByLine);

    float verticalDisp = 0.015 * vAnim.y * sineInOut(1.0 - textTR);
    pos.y -= verticalDisp;

    vPos = pos;

    // vec4 mvPos = modelMatrix * vec4(pos, 1.0);
    // vTrans = crange(distance(cameraPosition, mvPos.xyz), uAlphaDist.x, uAlphaDist.y, 1., 0.);
    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment

#require(range.glsl)
#require(msdf.glsl)
#require(simplenoise.glsl)

float aastep(float threshold, float value) {
    float afwidth = length(vec2(dFdx(value), dFdy(value))) * 0.70710678118654757;
    return smoothstep(threshold-afwidth, threshold+afwidth, value);
}

float getCutMask() {
    vec2 screen = gl_FragCoord.xy / resolution.xy;
    float inclination = 0.07 * uScreenRatio;
    float cutSt = screen.y + screen.x * inclination;
    float cutTop = aastep(cutSt, crange(uCut, -1., 0., 0.0, 1.0 + inclination));
    float cutBottom = 1. - aastep(cutSt, crange(uCut, 0.,1., 0.0, 1.0 + inclination));
    return cutTop * cutBottom;
}

vec2 getBoundingUV() {
    vec2 uv;
    uv.x = crange(vPos.x, uBoundingMin.x, uBoundingMax.x, 0.0, 1.0);
    uv.y = crange(vPos.y, uBoundingMin.y, uBoundingMax.y, 0.0, 1.0);
    return uv;
}

float parabola( float x, float k ) {
    return pow( 4.0*x*(1.0-x), k );
}

float linearstep(float begin, float end, float t) {
    return clamp((t - begin) / (end - begin), 0.0, 1.0);
}

float hscan(float _input, float start, float end, float contrast, float progress) {
    float margin = contrast;
    float p = mix(start + margin, end, progress);
    return linearstep(p - margin, p, _input);
}

float hscansmooth(float _input, float start, float end, float contrast, float progress) {
    float margin = contrast;
    float p = mix(start + margin, end, progress);
    return smoothstep(p - margin, p, _input);
}

void main() {

    // letter progress
    const float margin = 0.6;
    float textA = hscansmooth(vAnim.z, 0.0, 1.0, -margin, uTransition);
    float textB = hscansmooth(vAnim.z, 1.0, 0.0, margin, uTransition);
    float textTR = mix(textA, textB, uByLine);

    // manipulate uv for masking
    vec2 uv = vUv;
    uv.x += vLimits.z * (1.0 - textTR) * mix(-1.0, 1.0, uByLine);
    uv.x = clamp(uv.x, vLimits.x, vLimits.y);

    // opacity
    float op = smoothstep(0.0, 0.1, textTR);

    // color
    vec3 color = uColor;
    color = mix(uFadeInColor, color, smoothstep(0.0, 1.0, textTR));

    float alpha = msdf(tMap, uv);
    float cut = getCutMask();
    gl_FragColor.rgb = color;
    gl_FragColor.a = alpha * uAlpha * cut * op;
}
{@}ShareGround.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tNormal;
uniform vec2 uFog;
uniform vec2 uFogNear;
uniform vec2 uTile;
uniform vec3 uColor;
uniform float uAlpha;
uniform float uLightIntensity;

#!VARYINGS
varying float vFogDepth;
varying vec3 vNormal; // use this for light without pbr

#!SHADER: Vertex
#require(lighting.vs)

void main() {
    vec3 pos = position;
    vec3 transformedNormal = normal;
    setupLight(pos, transformedNormal);
    vNormal = normalize(normalMatrix * p1); // use this for light without pbr
    vUv = uv;
    vec4 mvPosition = modelViewMatrix * vec4(position, 1.0);
    vFogDepth = -mvPosition.z;
    gl_Position = projectionMatrix * mvPosition;
}

#!SHADER: Fragment
#require(range.glsl)
#require(lighting.fs)

void main() {
    vec2 normalUv = vec2(fract(vUv.x * uTile.x), fract(vUv.y * uTile.y));
    vec3 n = texture2D(tNormal, normalUv).rgb;

    setupLight();

    vec4 color = vec4(uColor, 1.0);
    color.rgb += getPointLightColor(n) * uLightIntensity;

    color.rgb = mix(color.rgb, vec3(0.0), crange(vFogDepth, uFog.x, uFog.y, 0., 1.));
    color.rgb = mix(vec3(0.0), color.rgb, smoothstep(uFogNear.x, uFogNear.y, abs(vViewDir.z))); // 3.5, 5.5
    gl_FragColor.rgb = color.rgb;

    gl_FragColor.a = uAlpha;
}{@}ShareGround2.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tNormal;
uniform vec2 uFog;
uniform vec2 uFogNear;
uniform vec2 uTile;
uniform vec3 uColor;
uniform float uAlpha;
uniform float uLightIntensity;

#!VARYINGS
varying float vFogDepth;
varying vec3 vNormal; // use this for light without pbr

#!SHADER: Vertex
#require(lighting.vs)

void main() {
    vec3 pos = position;
    vec3 transformedNormal = normal;
    setupLight(pos, transformedNormal);
    vNormal = normalize(normalMatrix * p1); // use this for light without pbr
    vUv = uv;
    vec4 mvPosition = modelViewMatrix * vec4(position, 1.0);
    vFogDepth = -mvPosition.z;
    gl_Position = projectionMatrix * mvPosition;
}

#!SHADER: Fragment
#require(range.glsl)
#require(lighting.fs)

void main() {
    vec2 normalUv = vec2(fract(vUv.x * uTile.x), fract(vUv.y * uTile.y));
    vec3 n = texture2D(tNormal, normalUv).rgb;

    setupLight();

    vec4 color = vec4(uColor, 1.0);
    color.rgb += getPointLightColor(n) * uLightIntensity;

    color.rgb = mix(color.rgb, vec3(0.0), crange(vFogDepth, uFog.x, uFog.y, 0., 1.));
    color.rgb = mix(vec3(0.0), color.rgb, smoothstep(uFogNear.x, uFogNear.y, abs(vViewDir.z))); // 3.5, 5.5

    gl_FragColor.rgb = color.rgb;
    gl_FragColor.a = uAlpha;
}{@}TickerShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
// uniform vec2 uR;
uniform vec3 uColor;
uniform float uSpeed;
uniform float uRatio;
uniform float uAlpha;
uniform float uRepeat;
uniform float uFocus;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex

void main() {
    vec3 pos = position;
    vec3 transformedNormal = normal;

    vUv = uv;
    vec4 mvPosition = modelViewMatrix * vec4(position, 1.0);
    gl_Position = projectionMatrix * mvPosition;
}

#!SHADER: Fragment

float aastep(float threshold, float value) {
    float afwidth = length(vec2(dFdx(value), dFdy(value))) * 0.70710678118654757;
    return smoothstep(threshold-afwidth, threshold+afwidth, value);
}

float rectangle(vec2 st, vec2 size) {
    size = vec2(0.5) - size * 0.5;
    vec2 uv = vec2(aastep(size.x, st.x), aastep(size.y, st.y));
    uv *= vec2(aastep(size.x, 1.0 - st.x), aastep(size.y, 1.0 - st.y));

    return uv.x * uv.y;
}


void main() {

    vec2 uv = vUv;
    uv.x = fract(uv.x * uRepeat + time * .03 * uSpeed);

    vec4 texel = texture2D(tMap, uv);

    float rectSize = .004 * uRatio;
    vec2 rectUV = vUv;
    rectUV.x = fract(rectUV.x * uRepeat + time * .03 * uSpeed);
    rectUV.x -= .5 - rectSize * 2.;
    rectUV.y -= .08;
    float rect = rectangle(rectUV, vec2(rectSize, .95));
    rect *= step(fract(time), .5);
    rect *= 1. * uFocus; // opacity
    rect *= step(rectUV.x, .5);

    vec3 color = texel.rgb * uColor;
    // color.rgb = mix(color.rgb, getPointLightColor(), 0.1);


    float edgeMask = smoothstep(vUv.x + .1, .02, 0.15) * smoothstep(vUv.x - .1, .98, .85);
    float att = edgeMask * .005;
    gl_FragColor.r = min(1., color.r + rect * uColor.r) - att;
    gl_FragColor.g = min(1., color.g + rect * uColor.g) - att;
    gl_FragColor.b = min(1., color.b + rect * uColor.b) - att;
    // gl_FragColor.rgb = texel.rgb;
    if(texel.g + rect < .9) discard;
    gl_FragColor.a = min(1., texel.g + rect) * edgeMask * uAlpha;
    // gl_FragColor = texel;
}{@}VideoFloorPBR.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform mat4 uMirrorMatrix;
uniform sampler2D tMirrorReflection;
uniform float uReflect;
uniform float uDarken;
uniform float uAlpha;

uniform float uPhongAttenuation;
uniform float uPhongShininess;
uniform vec3 uPhongColor;

uniform vec2 uRough;

uniform vec3 uFogPosition;
uniform vec2 uFogRange;

#!VARYINGS
varying vec4 vMirrorCoord;

#!SHADER: Vertex

#require(pbr.vs)
#require(lighting.vs)

void main() {
    setupLight(position, normal);
    setupPBR(position);

    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);

    vec4 worldPos = modelMatrix * vec4(position, 1.0);
    vMirrorCoord = uMirrorMatrix * worldPos;
}

#!SHADER: Fragment

#require(pbr.fs)
#require(lighting.fs)
#require(range.glsl)

void main() {
    setupLight();

    // get floor normal
    vec3 flNormal = getNormal(uNormalScale, tNormal, vUv, vNormal, vMPos);

    // get mirror image
    vec4 mirrorCoord = vMirrorCoord;
    mirrorCoord.xz += flNormal.xy;
    vec3 r = vec3(texture2D(tMirrorReflection, mirrorCoord.xy / mirrorCoord.w));

    // get mro
    vec3 mro = texture2D(tMRO, vUv).rgb;
    mro.y = crange(mro.y, uRough.x, uRough.y, 0.0, 1.0);


    // light config
    LightConfig lightConfig;
    lightConfig.normal = flNormal;
    lightConfig.phong = true;
    lightConfig.phongAttenuation = uPhongAttenuation;
    lightConfig.phongShininess = mro.y * uPhongShininess;
    lightConfig.phongColor = uPhongColor + mro.y * 2.0;

    // get color
    vec3 baseColor = texture2D(tBaseColor, vUv).rgb * uDarken;
    vec3 color = getPBR(baseColor).rgb;

    // add light
    color += getPointLightColor(lightConfig);

    // add mirror
    color += r * uReflect * crange(1.0 - mro.y, 0.0, 1.0, 0.2, 1.0);

    // set some fog
    gl_FragColor.rgb = color;
    gl_FragColor.a = smoothstep(uFogRange.y, uFogRange.x, length(vMPos.xyz - uFogPosition.xyz)) * uAlpha;
}{@}VideoFloorShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform mat4 uMirrorMatrix;
uniform sampler2D tMirrorReflection;
uniform vec3 uColor;

#!VARYINGS
varying vec2 vUv;
varying vec4 vMirrorCoord;

#!SHADER: Vertex
void main() {
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);

    vec4 worldPos = modelMatrix * vec4(position, 1.0);
    vMirrorCoord = uMirrorMatrix * worldPos;
    vUv = uv;
}

#!SHADER: Fragment

#require(range.glsl)

void main() {
    vec4 mirrorCoord = vMirrorCoord;
    // mirrorCoord.xz += waternormal.xy * uMirrorDistort;

    gl_FragColor.rgb = vec3(texture2D(tMirrorReflection, mirrorCoord.xy / mirrorCoord.w));
    gl_FragColor.a = 1.0;
}{@}VideoPlayIcon.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform float uAlpha;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
void main() {
    vUv = uv;
    vec4 mvPosition = modelViewMatrix * vec4(position, 1.0);
    gl_Position = projectionMatrix * mvPosition;
}

#!SHADER: Fragment
void main() {
    vec2 uv = vUv;
    vec4 texel = texture2D(tMap, uv);
    gl_FragColor = vec4(texel.rgb, texel.a * uAlpha);
}{@}VideoShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform sampler2D tPreview;
uniform vec3 uColor;
uniform float uPlay;
uniform float uBrightness;
uniform float uAlpha;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
void main() {
    vUv = uv;
    vec4 mvPosition = modelViewMatrix * vec4(position, 1.0);
    gl_Position = projectionMatrix * mvPosition;
}

#!SHADER: Fragment

#require(range.glsl)
#require(simplenoise.glsl)

void main() {
    vec2 uv = vUv;
    vec3 preview = texture2D(tPreview, uv).rgb;
    vec3 texel = texture2D(tMap, uv).rgb;

    vec3 color = mix(preview, texel, uPlay);
    //color *= 1.0+getNoise(vUv,time)*0.5;

    gl_FragColor = vec4(color + vec3(uBrightness), uAlpha);
}{@}VideoLogo.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform float uAlpha;
uniform float uScreenRatio;
uniform float uCut;
uniform vec3 uColor;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
void main() {
    vUv = uv;
    vec4 mvPosition = modelViewMatrix * vec4(position, 1.0);
    gl_Position = projectionMatrix * mvPosition;
}

#!SHADER: Fragment

#require(range.glsl)
#require(transformUV.glsl)

float aastep(float threshold, float value) {
    float afwidth = length(vec2(dFdx(value), dFdy(value))) * 0.70710678118654757;
    return smoothstep(threshold-afwidth, threshold+afwidth, value);
}

float rectangle(vec2 st, vec2 size) {
    size = vec2(0.5) - size * 0.5;
    vec2 uv = vec2(aastep(size.x, st.x), aastep(size.y, st.y));
    uv *= vec2(aastep(size.x, 1.0 - st.x), aastep(size.y, 1.0 - st.y));

    return uv.x * uv.y;
}

float getCutMask() {
    vec2 screen = gl_FragCoord.xy / resolution.xy;
    float inclination = 0.07 * uScreenRatio;
    float cutSt = screen.y + screen.x * inclination;
    float cutTop = aastep(cutSt, crange(uCut, -1., 0., 0.0, 1.0 + inclination));
    float cutBottom = 1. - aastep(cutSt, crange(uCut, 0.,1., 0.0, 1.0 + inclination));
    return cutTop * cutBottom;
}

void main() {
    vec2 uv = vUv;

    vec4 texel = texture2D(tMap, vUv);
    float cut = getCutMask();

    gl_FragColor = vec4(texel.rgb * uColor, texel.a * uAlpha * cut);
}{@}SoundShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform float uTime;
uniform float uFrequency;
uniform float uAmplitude;
uniform float uRMS;
uniform vec3 uColor;
uniform float uReflectivity;
uniform float uTransition;
uniform vec4 uEnergy;
uniform sampler2D tMap;

#!VARYINGS
varying vec3 vPos;
varying vec3 vPosC;
varying vec3 vNormal;

#!SHADER: Vertex

float noise(vec3 pp) {

    vec3 p = pp;
    float f = uFrequency;
    p += .2*cos( f * 1.5*p.yxz + 1.0*uTime + vec3(0.1,1.1, 0.) );
	p += .2*cos( f * 2.4*p.yxz + 1.6*uTime + vec3(4.5,2.6, 0.) );
	p += .2*cos( f * 3.3*p.yxz + 1.2*uTime + vec3(3.2,3.4,0.) );
	p += .2*cos( f * 4.2*p.yzx + 1.7*uTime + vec3(1.8,5.2,0.) );
	p += .2*cos( f * 9.1*p.yxz + 1.1*uTime + vec3(6.3,3.9,0.) );

	float r = uRMS * uAmplitude * length( p );
    
    return r;
}

vec3 generatePoint(float alpha, float beta) {
    return vec3(sin(alpha) * cos(beta), cos(alpha), sin(alpha) * sin(beta));
}

void main() {

    float eps = .005;

    vec3 nPos0 = normalize(position);

    float alpha = acos(nPos0.y);
    float beta = atan(nPos0.z, nPos0.x) + 2. * 3.14159265;

    nPos0 += 0.2 * noise(nPos0) * nPos0;

    vec3 nPos1 = generatePoint(alpha + eps, beta + eps);
    vec3 nPos2 = generatePoint(alpha - eps, beta);

    nPos1 += 0.2 * noise(nPos1) * nPos1;
    nPos2 += 0.2 * noise(nPos2) * nPos2;

    vNormal = normalize(cross(normalize(nPos0 - nPos1), normalize(nPos0 - nPos2)));
    vNormal = normalMatrix * - vNormal;
    //vNormal = 0.5 * vNormal + 0.5;
    

    vPos = nPos0;
    
    nPos0 *= 0.75;

    vec4 mvPosition = modelViewMatrix * vec4(nPos0, 1.0);

    vPosC = mvPosition.rgb;

    gl_Position = projectionMatrix * mvPosition;

}

#!SHADER: Fragment

#require(range.glsl)
#require(simplenoise.glsl)
#require(blendmodes.glsl)
#require(rgb2hsv.fs)

void main() {

    //Simple phong lighting
    float intensity = 0.;
    vec3 light = vec3(0., 10., 10.);

    vec3 l = normalize(light - vPos);
    vec3 v = normalize(vPosC);

    //schlick approximation
    float n = uReflectivity;
    float r0 = (1. - n) / (1. + n);
    r0 *= r0;
    float r= r0 + (1. - r0) * pow(1. - dot(-v, vNormal), 5.);

    //diffuse, using abs to simulate two lights for free.
    float diffuse = abs(dot(vNormal, l));

    //specular
    vec3 reflectL = reflect(l, vNormal);
    v = normalize(vec3(0., 10., 0.) - vPos);
    float specular = pow(max(dot(v, reflectL), 0.0), uEnergy.a);

    intensity = uEnergy.x + diffuse * uEnergy.y + uEnergy.z * specular;

    vec3 color = mix(uColor * intensity, vec3(1.), vec3(r));

    //matcap
    vec3 mp = reflect( vPosC, vNormal);
    float m = 2. * sqrt( pow( mp.x, 2. ) + pow( mp.y, 2. ) + pow( mp.z + 1., 2. ) );
    vec2 vN = mp.xy / m + .5;

    vec3 colorMatcap = texture2D( tMap, vN ).rgb;

    color = mix(color, colorMatcap, vec3(0.3));

    vec3 gradient = rgb2hsv(vec3(0.5));
    gradient.x = 0.68+cnoise(vPos*0.8-time*0.15)*0.05;
    gradient.y = 0.6;
    gradient.z = 1.0;
    gradient = hsv2rgb(gradient);

    color = blendScreen(color, gradient, (0.7+abs(cnoise(vPos*0.4+time*0.1))*0.3)*mix(0.3,0.6, uTransition));

    color *= 1.02;

    gl_FragColor.rgb = color;
    gl_FragColor.a = 1.0;

}{@}hover.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform float uMultiply;
uniform float uSpeed;
uniform vec3 uColor;
uniform float uAlpha;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
#require(range.glsl)

void main() {
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
    vUv = uv;
}

#!SHADER: Fragment
#require(range.glsl)

void main() {
    vec3 color = uColor;

    float alpha = color.x * vUv.y * ( 1.0 + (uMultiply * cos(time * uSpeed)));

    gl_FragColor = vec4(color, alpha * uAlpha);
}{@}UnrealBloom.fs{@}uniform sampler2D tUnrealBloom;

vec3 getUnrealBloom(vec2 uv) {
    return texture2D(tUnrealBloom, uv).rgb;
}{@}UnrealBloomComposite.glsl{@}#!ATTRIBUTES

#!UNIFORMS

uniform sampler2D blurTexture1;
uniform float bloomStrength;
uniform float bloomRadius;
uniform vec3 bloomTintColor;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex.vs
void main() {
    vUv = uv;
    gl_Position = vec4(position, 1.0);
}

#!SHADER: Fragment.fs

float lerpBloomFactor(const in float factor) {
    float mirrorFactor = 1.2 - factor;
    return mix(factor, mirrorFactor, bloomRadius);
}

void main() {
    gl_FragColor = bloomStrength * (lerpBloomFactor(1.0) * vec4(bloomTintColor, 1.0) * texture2D(blurTexture1, vUv));
}{@}UnrealBloomGaussian.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D colorTexture;
uniform vec2 texSize;
uniform vec2 direction;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex.vs
void main() {
    vUv = uv;
    gl_Position = vec4(position, 1.0);
}

#!SHADER: Fragment.fs

float gaussianPdf(in float x, in float sigma) {
    return 0.39894 * exp(-0.5 * x * x / (sigma * sigma)) / sigma;
}

void main() {
    vec2 invSize = 1.0 / texSize;
    float fSigma = float(SIGMA);
    float weightSum = gaussianPdf(0.0, fSigma);
    vec3 diffuseSum = texture2D( colorTexture, vUv).rgb * weightSum;
    for(int i = 1; i < KERNEL_RADIUS; i ++) {
        float x = float(i);
        float w = gaussianPdf(x, fSigma);
        vec2 uvOffset = direction * invSize * x;
        vec3 sample1 = texture2D( colorTexture, vUv + uvOffset).rgb;
        vec3 sample2 = texture2D( colorTexture, vUv - uvOffset).rgb;
        diffuseSum += (sample1 + sample2) * w;
        weightSum += 2.0 * w;
    }
    gl_FragColor = vec4(diffuseSum/weightSum, 1.0);
}{@}UnrealBloomLuminosity.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tDiffuse;
uniform vec3 defaultColor;
uniform float defaultOpacity;
uniform float luminosityThreshold;
uniform float smoothWidth;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex.vs
void main() {
    vUv = uv;
    gl_Position = vec4(position, 1.0);
}

#!SHADER: Fragment.fs

#require(luma.fs)

void main() {
    vec4 texel = texture2D(tDiffuse, vUv);
    float v = luma(texel.xyz);
    vec4 outputColor = vec4(defaultColor.rgb, defaultOpacity);
    float alpha = smoothstep(luminosityThreshold, luminosityThreshold + smoothWidth, v);
    gl_FragColor = mix(outputColor, texel, alpha);
}{@}UnrealBloomPass.fs{@}#require(UnrealBloom.fs)

void main() {
    vec4 color = texture2D(tDiffuse, vUv);
    color.rgb += getUnrealBloom(vUv);
    gl_FragColor = color;
}{@}curve3d.vs{@}uniform sampler2D tCurve;
uniform float uCurveSize;

vec2 getCurveUVFromIndex(float index) {
    float size = uCurveSize;
    vec2 ruv = vec2(0.0);
    float p0 = index / size;
    float y = floor(p0);
    float x = p0 - y;
    ruv.x = x;
    ruv.y = y / size;
    return ruv;
}

vec3 transformAlongCurve(vec3 pos, float idx) {
    vec3 offset = texture2D(tCurve, getCurveUVFromIndex(idx * (uCurveSize * uCurveSize))).xyz;
    vec3 p = pos;
    p.xz += offset.xz;
    return p;
}
{@}fbr.fs{@}uniform sampler2D tShininess;
uniform sampler2D tMatcap;
uniform sampler2D tNormal;
uniform float uShininess;

varying vec3 vNormal;
varying vec3 vPos;
varying vec3 vEyePos;
varying vec2 vUv;

vec2 reflectMatcapFBR(vec3 position, mat4 modelViewMatrix, vec3 normal) {
    vec4 p = vec4(position, 1.0);

    vec3 e = normalize(vec3(modelViewMatrix * p));
    vec3 n = normalize(normal);
    vec3 r = reflect(e, n);
    float m = 2.0 * sqrt(
    pow(r.x, 2.0) +
    pow(r.y, 2.0) +
    pow(r.z + 1.0, 2.0)
    );

    vec2 uv = r.xy / m + .5;

    return uv;
}

vec3 unpackNormalFBR( vec3 eye_pos, vec3 surf_norm, sampler2D normal_map, float intensity, float scale, vec2 uv ) {
    surf_norm = normalize(surf_norm);

    vec3 q0 = dFdx( eye_pos.xyz );
    vec3 q1 = dFdy( eye_pos.xyz );
    vec2 st0 = dFdx( uv.st );
    vec2 st1 = dFdy( uv.st );

    vec3 S = normalize( q0 * st1.t - q1 * st0.t );
    vec3 T = normalize( -q0 * st1.s + q1 * st0.s );
    vec3 N = normalize( surf_norm );

    vec3 mapN = texture2D( normal_map, uv * scale ).xyz * 2.0 - 1.0;
    mapN.xy *= intensity;
    mat3 tsn = mat3( S, T, N );
    return normalize( tsn * mapN );
}

vec3 getFBR(float shininess) {
    vec3 normal = unpackNormalFBR(vEyePos, vNormal, tNormal, 1.0, 1.0, vUv);
    vec2 aUV = reflectMatcapFBR(vPos, projectionMatrix, normal);
    vec2 bUV = reflectMatcapFBR(vPos, modelMatrix, normal);
    vec2 mUV = mix(bUV, aUV, shininess * uShininess);
    return texture2D(tMatcap, mUV).rgb;
}

vec3 getFBR() {
    float shininess = texture2D(tShininess, vUv).r;
    return getFBR(shininess);
}{@}fbr.vs{@}varying vec3 vNormal;
varying vec3 vPos;
varying vec3 vEyePos;
varying vec2 vUv;

void setupFBR(vec3 p0) { //inlinemain
    vNormal = normalMatrix * normal;
    vUv = uv;
    vPos = p0;
    vEyePos = vec3(modelViewMatrix * vec4(p0, 1.0));
}{@}fbrnew.fs{@}uniform sampler2D tMRO;
uniform sampler2D tMatcap;
uniform sampler2D tNormal;
uniform vec4 uLight;
uniform vec3 uColor;

varying vec3 vNormal;
varying vec3 vPos;
varying vec3 vEyePos;
varying vec2 vUv;
varying vec3 vMPos;

const float PI = 3.14159265359;
const float PI2 = 6.28318530718;
const float RECIPROCAL_PI = 0.31830988618;
const float RECIPROCAL_PI2 = 0.15915494;
const float LOG2 = 1.442695;
const float EPSILON = 1e-6;
const float LN2 = 0.6931472;

vec2 reflectMatcapFBR(vec3 position, mat4 modelViewMatrix, vec3 normal) {
    vec4 p = vec4(position, 1.0);

    vec3 e = normalize(vec3(modelViewMatrix * p));
    vec3 n = normalize(normal);
    vec3 r = reflect(e, n);
    float m = 2.0 * sqrt(
    pow(r.x, 2.0) +
    pow(r.y, 2.0) +
    pow(r.z + 1.0, 2.0)
    );

    vec2 uv = r.xy / m + .5;

    return uv;
}

float prange(float oldValue, float oldMin, float oldMax, float newMin, float newMax) {
    float oldRange = oldMax - oldMin;
    float newRange = newMax - newMin;
    return (((oldValue - oldMin) * newRange) / oldRange) + newMin;
}

float pcrange(float oldValue, float oldMin, float oldMax, float newMin, float newMax) {
    return clamp(prange(oldValue, oldMin, oldMax, newMin, newMax), min(newMax, newMin), max(newMin, newMax));
}

vec3 unpackNormalFBR( vec3 eye_pos, vec3 surf_norm, sampler2D normal_map, float intensity, float scale, vec2 uv ) {
    surf_norm = normalize(surf_norm);

    vec3 q0 = dFdx( eye_pos.xyz );
    vec3 q1 = dFdy( eye_pos.xyz );
    vec2 st0 = dFdx( uv.st );
    vec2 st1 = dFdy( uv.st );

    vec3 S = normalize( q0 * st1.t - q1 * st0.t );
    vec3 T = normalize( -q0 * st1.s + q1 * st0.s );
    vec3 N = normalize( surf_norm );

    vec3 mapN = texture2D( normal_map, uv * scale ).xyz * 2.0 - 1.0;
    mapN.xy *= intensity;
    mat3 tsn = mat3( S, T, N );
    return normalize( tsn * mapN );
}

float geometricOcclusion(float NdL, float NdV, float roughness) {
    float r = roughness;
    float attenuationL = 2.0 * NdL / (NdL + sqrt(r * r + (1.0 - r * r) * (NdL * NdL)));
    float attenuationV = 2.0 * NdV / (NdV + sqrt(r * r + (1.0 - r * r) * (NdV * NdV)));
    return attenuationL * attenuationV;
}

float microfacetDistribution(float roughness, float NdH) {
    float roughnessSq = roughness * roughness;
    float f = (NdH * roughnessSq - NdH) * NdH + 1.0;
    return roughnessSq / (PI * f * f);
}

vec3 getFBR(vec3 baseColor) {
    vec3 mro = texture2D(tMRO, vUv).rgb;
    float roughness = mro.g;

    vec3 normal = unpackNormalFBR(vEyePos, vNormal, tNormal, 1.0, 1.0, vUv);
    vec2 aUV = reflectMatcapFBR(vPos, projectionMatrix, normal);
    vec2 bUV = reflectMatcapFBR(vPos, modelMatrix, normal);
    vec2 mUV = mix(aUV, bUV, roughness);

    vec3 V = normalize(cameraPosition - vMPos);
    vec3 L = normalize(uLight.xyz);
    vec3 H = normalize(L + V);
    vec3 reflection = -normalize(reflect(V, normal));

    float NdL = pcrange(clamp(dot(normal, L), 0.001, 1.0), 0.0, 1.0, 0.4, 1.0);
    float NdV = pcrange(clamp(abs(dot(normal, V)), 0.001, 1.0), 0.0, 1.0, 0.4, 1.0);
    float NdH = clamp(dot(normal, H), 0.0, 1.0);
    float VdH = clamp(dot(V, H), 0.0, 1.0);

    float G = geometricOcclusion(NdL, NdV, roughness);
    float D = microfacetDistribution(roughness, NdH);

    vec3 specContrib = G * D / (4.0 * NdL * NdV) * uColor;
    vec3 color = NdL * specContrib * uLight.w;

    return ((baseColor * texture2D(tMatcap, mUV).rgb) + color) * mro.b;
}

vec3 getFBR() {
    float roughness = texture2D(tMRO, vUv).g;

    vec3 normal = unpackNormalFBR(vEyePos, vNormal, tNormal, 1.0, 1.0, vUv);
    vec2 aUV = reflectMatcapFBR(vPos, projectionMatrix, normal);
    vec2 bUV = reflectMatcapFBR(vPos, modelMatrix, normal);
    vec2 mUV = mix(aUV, bUV, roughness);

    return texture2D(tMatcap, mUV).rgb;
}

vec3 getFBRSimplified() {
    vec2 mUV = reflectMatcapFBR(vPos, modelViewMatrix, vNormal);
    return texture2D(tMatcap, mUV).rgb;
}
{@}fbrnew.vs{@}varying vec3 vNormal;
varying vec3 vPos;
varying vec3 vEyePos;
varying vec2 vUv;
varying vec3 vMPos;

void setupFBR(vec3 p0) { //inlinemain
    vNormal = normalMatrix * normal;
    vUv = uv;
    vPos = p0;
    vec4 mPos = modelMatrix * vec4(p0, 1.0);
    vMPos = mPos.xyz / mPos.w;
    vEyePos = vec3(modelViewMatrix * vec4(p0, 1.0));
}{@}advectionManualFilteringShader.fs{@}varying vec2 vUv;
uniform sampler2D uVelocity;
uniform sampler2D uSource;
uniform vec2 texelSize;
uniform vec2 dyeTexelSize;
uniform float dt;
uniform float dissipation;
vec4 bilerp (sampler2D sam, vec2 uv, vec2 tsize) {
    vec2 st = uv / tsize - 0.5;
    vec2 iuv = floor(st);
    vec2 fuv = fract(st);
    vec4 a = texture2D(sam, (iuv + vec2(0.5, 0.5)) * tsize);
    vec4 b = texture2D(sam, (iuv + vec2(1.5, 0.5)) * tsize);
    vec4 c = texture2D(sam, (iuv + vec2(0.5, 1.5)) * tsize);
    vec4 d = texture2D(sam, (iuv + vec2(1.5, 1.5)) * tsize);
    return mix(mix(a, b, fuv.x), mix(c, d, fuv.x), fuv.y);
}
void main () {
    vec2 coord = vUv - dt * bilerp(uVelocity, vUv, texelSize).xy * texelSize;
    gl_FragColor = dissipation * bilerp(uSource, coord, dyeTexelSize);
    gl_FragColor.a = 1.0;
}{@}advectionShader.fs{@}varying vec2 vUv;
uniform sampler2D uVelocity;
uniform sampler2D uSource;
uniform vec2 texelSize;
uniform float dt;
uniform float dissipation;
void main () {
    vec2 coord = vUv - dt * texture2D(uVelocity, vUv).xy * texelSize;
    gl_FragColor = dissipation * texture2D(uSource, coord);
    gl_FragColor.a = 1.0;
}{@}backgroundShader.fs{@}varying vec2 vUv;
uniform sampler2D uTexture;
uniform float aspectRatio;
#define SCALE 25.0
void main () {
    vec2 uv = floor(vUv * SCALE * vec2(aspectRatio, 1.0));
    float v = mod(uv.x + uv.y, 2.0);
    v = v * 0.1 + 0.8;
    gl_FragColor = vec4(vec3(v), 1.0);
}{@}clearShader.fs{@}varying vec2 vUv;
uniform sampler2D uTexture;
uniform float value;
void main () {
    gl_FragColor = value * texture2D(uTexture, vUv);
}{@}colorShader.fs{@}uniform vec4 color;
void main () {
    gl_FragColor = color;
}{@}curlShader.fs{@}varying highp vec2 vUv;
varying highp vec2 vL;
varying highp vec2 vR;
varying highp vec2 vT;
varying highp vec2 vB;
uniform sampler2D uVelocity;
void main () {
    float L = texture2D(uVelocity, vL).y;
    float R = texture2D(uVelocity, vR).y;
    float T = texture2D(uVelocity, vT).x;
    float B = texture2D(uVelocity, vB).x;
    float vorticity = R - L - T + B;
    gl_FragColor = vec4(0.5 * vorticity, 0.0, 0.0, 1.0);
}{@}displayShader.fs{@}varying vec2 vUv;
uniform sampler2D uTexture;
void main () {
    vec3 C = texture2D(uTexture, vUv).rgb;
    float a = max(C.r, max(C.g, C.b));
    gl_FragColor = vec4(C, a);
}{@}divergenceShader.fs{@}varying highp vec2 vUv;
varying highp vec2 vL;
varying highp vec2 vR;
varying highp vec2 vT;
varying highp vec2 vB;
uniform sampler2D uVelocity;
void main () {
    float L = texture2D(uVelocity, vL).x;
    float R = texture2D(uVelocity, vR).x;
    float T = texture2D(uVelocity, vT).y;
    float B = texture2D(uVelocity, vB).y;
    vec2 C = texture2D(uVelocity, vUv).xy;
//    if (vL.x < 0.0) { L = -C.x; }
//    if (vR.x > 1.0) { R = -C.x; }
//    if (vT.y > 1.0) { T = -C.y; }
//    if (vB.y < 0.0) { B = -C.y; }
    float div = 0.5 * (R - L + T - B);
    gl_FragColor = vec4(div, 0.0, 0.0, 1.0);
}{@}fluidBase.vs{@}varying vec2 vUv;
varying vec2 vL;
varying vec2 vR;
varying vec2 vT;
varying vec2 vB;
uniform vec2 texelSize;

void main () {
    vUv = uv;
    vL = vUv - vec2(texelSize.x, 0.0);
    vR = vUv + vec2(texelSize.x, 0.0);
    vT = vUv + vec2(0.0, texelSize.y);
    vB = vUv - vec2(0.0, texelSize.y);
    gl_Position = vec4(position, 1.0);
}{@}gradientSubtractShader.fs{@}varying highp vec2 vUv;
varying highp vec2 vL;
varying highp vec2 vR;
varying highp vec2 vT;
varying highp vec2 vB;
uniform sampler2D uPressure;
uniform sampler2D uVelocity;
vec2 boundary (vec2 uv) {
    return uv;
    // uv = min(max(uv, 0.0), 1.0);
    // return uv;
}
void main () {
    float L = texture2D(uPressure, boundary(vL)).x;
    float R = texture2D(uPressure, boundary(vR)).x;
    float T = texture2D(uPressure, boundary(vT)).x;
    float B = texture2D(uPressure, boundary(vB)).x;
    vec2 velocity = texture2D(uVelocity, vUv).xy;
    velocity.xy -= vec2(R - L, T - B);
    gl_FragColor = vec4(velocity, 0.0, 1.0);
}{@}pressureShader.fs{@}varying highp vec2 vUv;
varying highp vec2 vL;
varying highp vec2 vR;
varying highp vec2 vT;
varying highp vec2 vB;
uniform sampler2D uPressure;
uniform sampler2D uDivergence;
vec2 boundary (vec2 uv) {
    return uv;
    // uncomment if you use wrap or repeat texture mode
    // uv = min(max(uv, 0.0), 1.0);
    // return uv;
}
void main () {
    float L = texture2D(uPressure, boundary(vL)).x;
    float R = texture2D(uPressure, boundary(vR)).x;
    float T = texture2D(uPressure, boundary(vT)).x;
    float B = texture2D(uPressure, boundary(vB)).x;
    float C = texture2D(uPressure, vUv).x;
    float divergence = texture2D(uDivergence, vUv).x;
    float pressure = (L + R + B + T - divergence) * 0.25;
    gl_FragColor = vec4(pressure, 0.0, 0.0, 1.0);
}{@}splatShader.fs{@}varying vec2 vUv;
uniform sampler2D uTarget;
uniform float aspectRatio;
uniform vec3 color;
uniform vec3 bgColor;
uniform vec2 point;
uniform vec2 prevPoint;
uniform float radius;
uniform float canRender;
uniform float uAdd;

float blendScreen(float base, float blend) {
    return 1.0-((1.0-base)*(1.0-blend));
}

vec3 blendScreen(vec3 base, vec3 blend) {
    return vec3(blendScreen(base.r, blend.r), blendScreen(base.g, blend.g), blendScreen(base.b, blend.b));
}

float l(vec2 uv, vec2 point1, vec2 point2) {
    vec2 pa = uv - point1, ba = point2 - point1;
    pa.x *= aspectRatio;
    ba.x *= aspectRatio;
    float h = clamp(dot(pa, ba) / dot(ba, ba), 0.0, 1.0);
    return length(pa - ba * h);
}

float cubicOut(float t) {
    float f = t - 1.0;
    return f * f * f + 1.0;
}

void main () {
    vec3 splat = (1.0 - cubicOut(clamp(l(vUv, prevPoint.xy, point.xy) / radius, 0.0, 1.0))) * color;
    vec3 base = texture2D(uTarget, vUv).xyz;
    base *= canRender;

    vec3 outColor = mix(blendScreen(base, splat), base + splat, uAdd);
    gl_FragColor = vec4(outColor, 1.0);
}{@}vorticityShader.fs{@}varying vec2 vUv;
varying vec2 vL;
varying vec2 vR;
varying vec2 vT;
varying vec2 vB;
uniform sampler2D uVelocity;
uniform sampler2D uCurl;
uniform float curl;
uniform float dt;
void main () {
    float L = texture2D(uCurl, vL).x;
    float R = texture2D(uCurl, vR).x;
    float T = texture2D(uCurl, vT).x;
    float B = texture2D(uCurl, vB).x;
    float C = texture2D(uCurl, vUv).x;
    vec2 force = 0.5 * vec2(abs(T) - abs(B), abs(R) - abs(L));
    force /= length(force) + 0.0001;
    force *= curl * C;
    force.y *= -1.0;
//    force.y += 400.3;
    vec2 vel = texture2D(uVelocity, vUv).xy;
    gl_FragColor = vec4(vel + force * dt, 0.0, 1.0);
}{@}AreaLights.glsl{@}mat3 transposeMat3(  mat3 m ) {
	mat3 tmp;
	tmp[ 0 ] = vec3( m[ 0 ].x, m[ 1 ].x, m[ 2 ].x );
	tmp[ 1 ] = vec3( m[ 0 ].y, m[ 1 ].y, m[ 2 ].y );
	tmp[ 2 ] = vec3( m[ 0 ].z, m[ 1 ].z, m[ 2 ].z );
	return tmp;
}

// Real-Time Polygonal-Light Shading with Linearly Transformed Cosines
// by Eric Heitz, Jonathan Dupuy, Stephen Hill and David Neubelt
// code: https://github.com/selfshadow/ltc_code/
vec2 LTC_Uv(  vec3 N,  vec3 V,  float roughness ) {
	float LUT_SIZE  = 64.0;
	float LUT_SCALE = ( LUT_SIZE - 1.0 ) / LUT_SIZE;
	float LUT_BIAS  = 0.5 / LUT_SIZE;
	float dotNV = clamp( dot( N, V ), 0.0, 1.0 );
	// texture parameterized by sqrt( GGX alpha ) and sqrt( 1 - cos( theta ) )
	vec2 uv = vec2( roughness, sqrt( 1.0 - dotNV ) );
	uv = uv * LUT_SCALE + LUT_BIAS;
	return uv;
}

float LTC_ClippedSphereFormFactor(  vec3 f ) {
	// Real-Time Area Lighting: a Journey from Research to Production (p.102)
	// An approximation of the form factor of a horizon-clipped rectangle.
	float l = length( f );
	return max( ( l * l + f.z ) / ( l + 1.0 ), 0.0 );
}

vec3 LTC_EdgeVectorFormFactor(  vec3 v1,  vec3 v2 ) {
	float x = dot( v1, v2 );
	float y = abs( x );
	// rational polynomial approximation to theta / sin( theta ) / 2PI
	float a = 0.8543985 + ( 0.4965155 + 0.0145206 * y ) * y;
	float b = 3.4175940 + ( 4.1616724 + y ) * y;
	float v = a / b;
	float theta_sintheta = ( x > 0.0 ) ? v : 0.5 * inversesqrt( max( 1.0 - x * x, 1e-7 ) ) - v;
	return cross( v1, v2 ) * theta_sintheta;
}

vec3 LTC_Evaluate(  vec3 N,  vec3 V,  vec3 P,  mat3 mInv,  vec3 rectCoords[ 4 ] ) {
	// bail if point is on back side of plane of light
	// assumes ccw winding order of light vertices
	vec3 v1 = rectCoords[ 1 ] - rectCoords[ 0 ];
	vec3 v2 = rectCoords[ 3 ] - rectCoords[ 0 ];
	vec3 lightNormal = cross( v1, v2 );
	if( dot( lightNormal, P - rectCoords[ 0 ] ) < 0.0 ) return vec3( 0.0 );
	// construct orthonormal basis around N
	vec3 T1, T2;
	T1 = normalize( V - N * dot( V, N ) );
	T2 = - cross( N, T1 ); // negated from paper; possibly due to a different handedness of world coordinate system
	// compute transform
	mat3 mat = mInv * transposeMat3( mat3( T1, T2, N ) );
	// transform rect
	vec3 coords[ 4 ];
	coords[ 0 ] = mat * ( rectCoords[ 0 ] - P );
	coords[ 1 ] = mat * ( rectCoords[ 1 ] - P );
	coords[ 2 ] = mat * ( rectCoords[ 2 ] - P );
	coords[ 3 ] = mat * ( rectCoords[ 3 ] - P );
	// project rect onto sphere
	coords[ 0 ] = normalize( coords[ 0 ] );
	coords[ 1 ] = normalize( coords[ 1 ] );
	coords[ 2 ] = normalize( coords[ 2 ] );
	coords[ 3 ] = normalize( coords[ 3 ] );
	// calculate vector form factor
	vec3 vectorFormFactor = vec3( 0.0 );
	vectorFormFactor += LTC_EdgeVectorFormFactor( coords[ 0 ], coords[ 1 ] );
	vectorFormFactor += LTC_EdgeVectorFormFactor( coords[ 1 ], coords[ 2 ] );
	vectorFormFactor += LTC_EdgeVectorFormFactor( coords[ 2 ], coords[ 3 ] );
	vectorFormFactor += LTC_EdgeVectorFormFactor( coords[ 3 ], coords[ 0 ] );
	// adjust for horizon clipping
	float result = LTC_ClippedSphereFormFactor( vectorFormFactor );

	return vec3( result );
}{@}Lighting.glsl{@}#!ATTRIBUTES

#!UNIFORMS
struct LightConfig {
    vec3 normal;
    bool phong;
    bool areaToPoint;
    float phongAttenuation;
    float phongShininess;
    vec3 phongColor;
};

uniform sampler2D tLTC1;
uniform sampler2D tLTC2;

#!VARYINGS
varying vec3 vPos;
varying vec3 vWorldPos;
// varying vec3 vNormal; // error in nvidia cards with pbr shader
varying vec3 vViewDir;

#!SHADER: lighting.vs

void setupLight(vec3 p0, vec3 p1) { //inlinemain
    vPos = p0;
    // vNormal = normalize(normalMatrix * p1); // error in nvidia cards with pbr shader
    vWorldPos = vec3(modelMatrix * vec4(p0, 1.0));
    vViewDir = -vec3(modelViewMatrix * vec4(p0, 1.0));
}

#test !window.Metal
void setupLight(vec3 p0) {
    setupLight(p0, normal);
}
#endtest

#!SHADER: lighting.fs

#require(LightingCommon.glsl)

void setupLight() {

}
vec3 getCombinedColor(LightConfig config, vec3 vPos, vec3 vWorldPos, vec3 vViewDir, mat4 modelViewMatrix, mat4 viewMatrix, sampler2D tLTC1, sampler2D tLTC2) {
    vec3 color = vec3(0.0);


    for (int i = 0; i < NUM_LIGHTS; i++) {
        vec3 lColor = lightColor[i].rgb;
        vec3 lPos = lightPos[i].rgb;
        vec4 lData = lightData[i];
        vec4 lData2 = lightData2[i];
        vec4 lData3 = lightData3[i];
        vec4 lProps = lightProperties[i];

        if (lProps.w < 1.0) continue;

        if (lProps.w < 1.1) {
            color += lightDirectional(config, lColor, lPos, lData, lData2, lData3, lProps, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix);
        } else if (lProps.w < 2.1) {
            color += lightPoint(config, lColor, lPos, lData, lData2, lData3, lProps, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix);
        } else if (lProps.w < 3.1) {
            color += lightCone(config, lColor, lPos, lData, lData2, lData3, lProps, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix);
        } else if (lProps.w < 4.1) {
            color += lightArea(config, lColor, lPos, lData, lData2, lData3, lProps, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix, tLTC1, tLTC2);
        }
    }

    return lclamp(color);
}

vec3 getCombinedColor(LightConfig config) {
    #test !window.Metal
    return getCombinedColor(config, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix, tLTC1, tLTC2);
    #endtest
    return vec3(0.0);
}

vec3 getCombinedColor() {
    LightConfig config;
    config.normal = vNormal;
    return getCombinedColor(config);
}

vec3 getCombinedColor(vec3 normal) {
    LightConfig config;
    config.normal = normal;
    return getCombinedColor(config);
}

vec3 getCombinedColor(vec3 normal, vec3 vPos, vec3 vWorldPos, vec3 vViewDir, mat4 modelViewMatrix, mat4 viewMatrix, sampler2D tLTC1, sampler2D tLTC2) {
    LightConfig config;
    config.normal = normal;
    return getCombinedColor(config, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix, tLTC1, tLTC2);
}

vec3 getPointLightColor(LightConfig config, vec3 vPos, vec3 vWorldPos, vec3 vViewDir, mat4 modelViewMatrix, mat4 viewMatrix) {
    vec3 color = vec3(0.0);

    #pragma unroll_loop
    for (int i = 0; i < NUM_LIGHTS; i++) {
        vec3 lColor = lightColor[i].rgb;
        vec3 lPos = lightPos[i].rgb;
        vec4 lData = lightData[i];
        vec4 lData2 = lightData2[i];
        vec4 lData3 = lightData3[i];
        vec4 lProps = lightProperties[i];

        if (lProps.w > 1.9 && lProps.w < 2.1) {
            color += lightPoint(config, lColor, lPos, lData, lData2, lData3, lProps, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix);
        }
    }

    return lclamp(color);
}

vec3 getPointLightColor(LightConfig config) {
    #test !window.Metal
    return getPointLightColor(config, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix);
    #endtest
    return vec3(0.0);
}

vec3 getPointLightColor() {
    LightConfig config;
    config.normal = vNormal;
    return getPointLightColor(config);
}

vec3 getPointLightColor(vec3 normal) {
    LightConfig config;
    config.normal = normal;
    return getPointLightColor(config);
}

vec3 getPointLightColor(vec3 normal, vec3 vPos, vec3 vWorldPos, vec3 vViewDir, mat4 modelViewMatrix, mat4 viewMatrix) {
    LightConfig config;
    config.normal = normal;
    return getPointLightColor(config, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix);
}

vec3 getAreaLightColor(float roughness, LightConfig config, vec3 vPos, vec3 vWorldPos, vec3 vViewDir, mat4 modelViewMatrix, mat4 viewMatrix, sampler2D tLTC1, sampler2D tLTC2) {
    vec3 color = vec3(0.0);

    #test Lighting.fallbackAreaToPointTest()
    config.areaToPoint = true;
    #endtest

    #pragma unroll_loop
    for (int i = 0; i < NUM_LIGHTS; i++) {
        vec3 lColor = lightColor[i].rgb;
        vec3 lPos = lightPos[i].rgb;
        vec4 lData = lightData[i];
        vec4 lData2 = lightData2[i];
        vec4 lData3 = lightData3[i];
        vec4 lProps = lightProperties[i];

        lData.w *= roughness;

        if (lProps.w > 3.9 && lProps.w < 4.1) {
            if (config.areaToPoint) {
                color += lightPoint(config, lColor, lPos, lData, lData2, lData3, lProps, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix);
            } else {
                color += lightArea(config, lColor, lPos, lData, lData2, lData3, lProps, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix, tLTC1, tLTC2);
            }
        }
    }

    return lclamp(color);
}

vec3 getAreaLightColor(float roughness, LightConfig config) {
    #test !window.Metal
    return getAreaLightColor(roughness, config, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix, tLTC1, tLTC2);
    #endtest
    return vec3(0.0);
}


vec3 getAreaLightColor(float roughness) {
    LightConfig config;
    config.normal = vNormal;
    return getAreaLightColor(roughness, config);
}

vec3 getAreaLightColor() {
    LightConfig config;
    config.normal = vNormal;
    return getAreaLightColor(1.0, config);
}

vec3 getAreaLightColor(vec3 normal) {
    LightConfig config;
    config.normal = normal;
    return getAreaLightColor(1.0, config);
}

vec3 getAreaLightColor(vec3 normal, vec3 vPos, vec3 vWorldPos, vec3 vViewDir, mat4 modelViewMatrix, mat4 viewMatrix, sampler2D tLTC1, sampler2D tLTC2) {
    LightConfig config;
    config.normal = normal;
    return getAreaLightColor(1.0, config, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix, tLTC1, tLTC2);
}


vec3 getSpotLightColor(LightConfig config, vec3 vPos, vec3 vWorldPos, vec3 vViewDir, mat4 modelViewMatrix, mat4 viewMatrix) {
    vec3 color = vec3(0.0);

    #pragma unroll_loop
    for (int i = 0; i < NUM_LIGHTS; i++) {
        vec3 lColor = lightColor[i].rgb;
        vec3 lPos = lightPos[i].rgb;
        vec4 lData = lightData[i];
        vec4 lData2 = lightData2[i];
        vec4 lData3 = lightData3[i];
        vec4 lProps = lightProperties[i];

        if (lProps.w > 2.9 && lProps.w < 3.1) {
            color += lightCone(config, lColor, lPos, lData, lData2, lData3, lProps, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix);
        }
    }

    return lclamp(color);
}

vec3 getSpotLightColor(LightConfig config) {
    #test !window.Metal
    return getSpotLightColor(config, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix);
    #endtest
    return vec3(0.0);
}

vec3 getSpotLightColor() {
    LightConfig config;
    config.normal = vNormal;
    return getSpotLightColor(config);
}

vec3 getSpotLightColor(vec3 normal) {
    LightConfig config;
    config.normal = normal;
    return getSpotLightColor(config);
}

vec3 getSpotLightColor(vec3 normal, vec3 vPos, vec3 vWorldPos, vec3 vViewDir, mat4 modelViewMatrix, mat4 viewMatrix) {
    LightConfig config;
    config.normal = normal;
    return getSpotLightColor(config, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix);
}


vec3 getDirectionalLightColor(LightConfig config, vec3 vPos, vec3 vWorldPos, vec3 vViewDir, mat4 modelViewMatrix, mat4 viewMatrix) {
    vec3 color = vec3(0.0);

    #pragma unroll_loop
    for (int i = 0; i < NUM_LIGHTS; i++) {
        vec3 lColor = lightColor[i].rgb;
        vec3 lPos = lightPos[i].rgb;
        vec4 lData = lightData[i];
        vec4 lData2 = lightData2[i];
        vec4 lData3 = lightData3[i];
        vec4 lProps = lightProperties[i];

        if (lProps.w > 0.9 && lProps.w < 1.1) {
            color += lightDirectional(config, lColor, lPos, lData, lData2, lData3, lProps, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix);
        }
    }

    return lclamp(color);
}

vec3 getDirectionalLightColor(LightConfig config) {
    #test !window.Metal
    return getDirectionalLightColor(config, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix);
    #endtest
    return vec3(0.0);
}

vec3 getDirectionalLightColor(vec3 normal) {
    LightConfig config;
    config.normal = normal;
    return getDirectionalLightColor(config);
}

vec3 getDirectionalLightColor() {
    LightConfig config;
    config.normal = vNormal;
    return getDirectionalLightColor(config);
}

vec3 getDirectionalLightColor(vec3 normal, vec3 vPos, vec3 vWorldPos, vec3 vViewDir, mat4 modelViewMatrix, mat4 viewMatrix) {
    LightConfig config;
    config.normal = vNormal;
    return getDirectionalLightColor(config, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix);
}

vec3 getStandardColor(LightConfig config, vec3 vPos, vec3 vWorldPos, vec3 vViewDir, mat4 modelViewMatrix, mat4 viewMatrix) {
    vec3 color = vec3(0.0);

    #pragma unroll_loop
    for (int i = 0; i < NUM_LIGHTS; i++) {
        vec3 lColor = lightColor[i].rgb;
        vec3 lPos = lightPos[i].rgb;
        vec4 lData = lightData[i];
        vec4 lData2 = lightData2[i];
        vec4 lData3 = lightData3[i];
        vec4 lProps = lightProperties[i];

        if (lProps.w < 1.0) continue;

        if (lProps.w < 1.1) {
            color += lightDirectional(config, lColor, lPos, lData, lData2, lData3, lProps, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix);
        } else if (lProps.w < 2.1) {
            color += lightPoint(config, lColor, lPos, lData, lData2, lData3, lProps, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix);
        }
    }

    return lclamp(color);
}

vec3 getStandardColor(LightConfig config) {
    #test !window.Metal
    return getStandardColor(config, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix);
    #endtest
    return vec3(0.0);
}

vec3 getStandardColor() {
    LightConfig config;
    config.normal = vNormal;
    return getStandardColor(config);
}

vec3 getStandardColor(vec3 normal) {
    LightConfig config;
    config.normal = normal;
    return getStandardColor(config);
}

vec3 getStandardColor(vec3 normal, vec3 vPos, vec3 vWorldPos, vec3 vViewDir, mat4 modelViewMatrix, mat4 viewMatrix) {
    LightConfig config;
    config.normal = normal;
    return getStandardColor(config, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix);
}{@}LightingCommon.glsl{@}#require(AreaLights.glsl)

vec3 lworldLight(vec3 lightPos, vec3 localPos, mat4 modelViewMatrix, mat4 viewMatrix) {
    vec4 mvPos = modelViewMatrix * vec4(localPos, 1.0);
    vec4 worldPosition = viewMatrix * vec4(lightPos, 1.0);
    return worldPosition.xyz - mvPos.xyz;
}

float lrange(float oldValue, float oldMin, float oldMax, float newMin, float newMax) {
    float oldRange = oldMax - oldMin;
    float newRange = newMax - newMin;
    return (((oldValue - oldMin) * newRange) / oldRange) + newMin;
}

vec3 lclamp(vec3 v) {
    return clamp(v, vec3(0.0), vec3(1.0));
}

float lcrange(float oldValue, float oldMin, float oldMax, float newMin, float newMax) {
    return clamp(lrange(oldValue, oldMin, oldMax, newMin, newMax), min(newMax, newMin), max(newMin, newMax));
}

#require(Phong.glsl)

vec3 lightDirectional(LightConfig config, vec3 lColor, vec3 lPos, vec4 lData, vec4 lData2, vec4 lData3, vec4 lProps, vec3 vPos, vec3 vWorldPos, vec3 vViewDir, mat4 modelViewMatrix, mat4 viewMatrix) {
    vec3 lDir = lworldLight(lPos, vPos, modelViewMatrix, viewMatrix);
    float volume = dot(normalize(lDir), config.normal);

    return lColor * lcrange(volume, 0.0, 1.0, lProps.z, 1.0);
}

vec3 lightPoint(LightConfig config, vec3 lColor, vec3 lPos, vec4 lData, vec4 lData2, vec4 lData3, vec4 lProps, vec3 vPos, vec3 vWorldPos, vec3 vViewDir, mat4 modelViewMatrix, mat4 viewMatrix) {
    float dist = length(vWorldPos - lPos);
    if (dist > lProps.y) return vec3(0.0);

    vec3 color = vec3(0.0);

    vec3 lDir = lworldLight(lPos, vPos, modelViewMatrix, viewMatrix);

    if (config.phong) {
        color += phong(lProps.x, lColor, config.phongColor, config.phongShininess, config.phongAttenuation, config.normal, normalize(lDir), vViewDir, lProps.z);
    } else {
        float volume = dot(normalize(lDir), config.normal);
        volume = lcrange(volume, 0.0, 1.0, lProps.z, 1.0);
        float falloff = pow(lcrange(dist, 0.0, lProps.y, 1.0, 0.0), 2.0);
        color += lColor * volume * lProps.x * falloff;
    }

    return color;
}

vec3 lightCone(LightConfig config, vec3 lColor, vec3 lPos, vec4 lData, vec4 lData2, vec4 lData3, vec4 lProps, vec3 vPos, vec3 vWorldPos, vec3 vViewDir, mat4 modelViewMatrix, mat4 viewMatrix) {
    float dist = length(vWorldPos - lPos);
    if (dist > lProps.y) return vec3(0.0);

    vec3 lDir = lworldLight(lPos, vPos, modelViewMatrix, viewMatrix);
    vec3 sDir = degrees(-lData.xyz);
    float radius = lData.w;
    vec3 surfacePos = vWorldPos;
    vec3 surfaceToLight = normalize(lPos - surfacePos);
    float lightToSurfaceAngle = degrees(acos(dot(-surfaceToLight, normalize(sDir))));
    float attenuation = 1.0;

    vec3 nColor = lightPoint(config, lColor, lPos, lData, lData2, lData3, lProps, vPos, vWorldPos, vViewDir, modelViewMatrix, viewMatrix);

    float featherMin = 1.0 - lData2.x*0.1;
    float featherMax = 1.0 + lData2.x*0.1;

    attenuation *= smoothstep(lightToSurfaceAngle*featherMin, lightToSurfaceAngle*featherMax, radius);

    nColor *= attenuation;
    return nColor;
}

vec3 lightArea(LightConfig config, vec3 lColor, vec3 lPos, vec4 lData, vec4 lData2, vec4 lData3, vec4 lProps, vec3 vPos, vec3 vWorldPos, vec3 vViewDir, mat4 modelViewMatrix, mat4 viewMatrix, sampler2D tLTC1, sampler2D tLTC2) {
    float dist = length(vWorldPos - lPos);
    if (dist > lProps.y) return vec3(0.0);

    vec3 color = vec3(0.0);

    vec3 normal = config.normal;
    vec3 viewDir = normalize(vViewDir);
    vec3 position = -vViewDir;
    float roughness = lData.w;
    vec3 mPos = lData.xyz;
    vec3 halfWidth = lData2.xyz;
    vec3 halfHeight = lData3.xyz;

    float falloff = pow(lcrange(dist, 0.0, lProps.y, 1.0, 0.0), 2.0);

    vec3 rectCoords[ 4 ];
    rectCoords[ 0 ] = mPos + halfWidth - halfHeight;
    rectCoords[ 1 ] = mPos - halfWidth - halfHeight;
    rectCoords[ 2 ] = mPos - halfWidth + halfHeight;
    rectCoords[ 3 ] = mPos + halfWidth + halfHeight;

    vec2 uv = LTC_Uv( normal, viewDir, roughness );

    #test !!window.Metal
    uv.y = 1.0 - uv.y;
    #endtest

    vec4 t1 = texture2D(tLTC1, uv);
    vec4 t2 = texture2D(tLTC2, uv);

    mat3 mInv = mat3(
    vec3( t1.x, 0, t1.y ),
    vec3(    0, 1,    0 ),
    vec3( t1.z, 0, t1.w )
    );

    vec3 fresnel = ( lColor * t2.x + ( vec3( 1.0 ) - lColor ) * t2.y );
    color += lColor * fresnel * LTC_Evaluate( normal, viewDir, position, mInv, rectCoords ) * falloff * lProps.x;
    color += lColor * LTC_Evaluate( normal, viewDir, position, mat3( 1.0 ), rectCoords ) * falloff * lProps.x;

    return color;
}{@}LitMaterial.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;

#!VARYINGS
varying vec3 vPos;

#!SHADER: Vertex

#require(lighting.vs)

void main() {
    vUv = uv;
    vPos = position;
    setupLight(position);
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment

#require(lighting.fs)
#require(shadows.fs)

void main() {
    setupLight();

    vec3 color = texture2D(tMap, vUv).rgb;
    color *= getShadow(vPos);

    color += getCombinedColor();

    gl_FragColor = vec4(color, 1.0);
}{@}Phong.glsl{@}float pclamp(float v) {
    return clamp(v, 0.0, 1.0);
}

float dPhong(float shininess, float dotNH) {
    return (shininess * 0.5 + 1.0) * pow(dotNH, shininess);
}

vec3 schlick(vec3 specularColor, float dotLH) {
    float fresnel = exp2((-5.55437 * dotLH - 6.98316) * dotLH);
    return (1.0 - specularColor) * fresnel + specularColor;
}

vec3 calcBlinnPhong(vec3 specularColor, float shininess, vec3 normal, vec3 lightDir, vec3 viewDir) {
    vec3 halfDir = normalize(lightDir + viewDir);
    
    float dotNH = pclamp(dot(normal, halfDir));
    float dotLH = pclamp(dot(lightDir, halfDir));

    vec3 F = schlick(specularColor, dotLH);
    float G = 0.85;
    float D = dPhong(shininess, dotNH);
    
    return F * G * D;
}

vec3 calcBlinnPhong(vec3 specularColor, float shininess, vec3 normal, vec3 lightDir, vec3 viewDir, float minTreshold) {
    vec3 halfDir = normalize(lightDir + viewDir);

    float dotNH = pclamp(dot(normal, halfDir));
    float dotLH = pclamp(dot(lightDir, halfDir));

    dotNH = lrange(dotNH, 0.0, 1.0, minTreshold, 1.0);
    dotLH = lrange(dotLH, 0.0, 1.0, minTreshold, 1.0);

    vec3 F = schlick(specularColor, dotLH);
    float G = 0.85;
    float D = dPhong(shininess, dotNH);

    return F * G * D;
}

vec3 phong(float amount, vec3 diffuse, vec3 specular, float shininess, float attenuation, vec3 normal, vec3 lightDir, vec3 viewDir, float minThreshold) {
    float cosineTerm = pclamp(lrange(dot(normal, lightDir), 0.0, 1.0, minThreshold, 1.0));
    vec3 brdf = calcBlinnPhong(specular, shininess, normal, lightDir, viewDir, minThreshold);
    return brdf * amount * diffuse * attenuation * cosineTerm;
}{@}mousefluid.fs{@}uniform sampler2D tFluid;
uniform sampler2D tFluidMask;

vec2 getFluidVelocity() {
    float fluidMask = smoothstep(0.1, 0.7, texture2D(tFluidMask, vUv).r);
    return texture2D(tFluid, vUv).xy * fluidMask;
}

vec3 getFluidVelocityMask() {
    float fluidMask = smoothstep(0.1, 0.7, texture2D(tFluidMask, vUv).r);
    return vec3(texture2D(tFluid, vUv).xy * fluidMask, fluidMask);
}{@}SceneLayout.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform float uAlpha;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
void main() {
    vec3 pos = position;
    vUv = uv;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment
void main() {
    gl_FragColor = texture2D(tMap, vUv);
    gl_FragColor.a *= uAlpha;
    gl_FragColor.rgb /= gl_FragColor.a;
}{@}ScreenBokehDof.fs{@}
uniform float uDofAmount;
uniform float uDofPower;
uniform float uInvert;
uniform float uParabola;
uniform float uAspectRatio;
uniform vec2 uScale;
uniform vec2 uTranslate;
uniform float uRotate;
uniform float uPower;
uniform float uRadial;
uniform vec2 uPxSize;
uniform float uDebug;
uniform float uResScale;

uniform sampler2D tDiffuse;
varying vec2 vUv;

#require(transformUV.glsl)

const float GOLDEN_ANGLE = 2.39996323;
const int DOF_ITERATIONS = 15;
const float fIterations = float(DOF_ITERATIONS);
const float sqrtiter = sqrt(fIterations);

vec3 Dof(sampler2D tex, vec2 uv, float radius) {
    float spacing = sqrt(3.141592652 / fIterations) * radius;
    float level = log2(spacing);

    vec3 acc = vec3(0.0);

    for (int j = 0; j < DOF_ITERATIONS; j++) {
        float theta = GOLDEN_ANGLE * float(j);
        float r = sqrt(float(j)) / sqrtiter;
        vec2 p = r * vec2(cos(theta), sin(theta));
        vec3 col = texture2D(tex, uv + radius * p * uPxSize, level).rgb;
        acc += col;
    }
    return acc / fIterations;
}

void main() {
    float amount = 0.0;

    vec2 uv = vUv - 0.5;
    uv.x *= mix(1.0, resolution.x / resolution.y, clamp(uAspectRatio, 0.0, 1.0));
    uv += 0.5;

    uv = scaleUV(uv, uScale);
    uv = rotateUV(uv, uRotate / 57.295779513);
    uv = translateUV(uv, uTranslate);

    float linear = max(0.0, uv.y);
    float radial = max(0.0, length(uv - 0.5));

    amount = mix(linear, radial, uRadial);
    amount = mix(amount, smoothstep(0.2, 0.5, amount) * smoothstep(0.8, 0.5, amount), uParabola);
    amount = clamp(pow(amount, uPower), 0.0, 1.0);
    amount = mix(amount, 1.0 - amount, clamp(uInvert, 0.0, 1.0));

    float blur = max(0.0, uDofAmount * uResScale);
    blur = pow(blur, uDofPower);

    gl_FragColor.rgb = mix(Dof(tDiffuse, vUv, amount * blur).rgb, vec3(amount), clamp(uDebug, 0.0, 1.0));
    gl_FragColor.a = 1.0;
}
{@}Text3D.glsl{@}#!ATTRIBUTES
attribute vec3 animation;

#!UNIFORMS
uniform sampler2D tMap;
uniform vec3 uColor;
uniform float uAlpha;
uniform vec3 uTranslate;
uniform vec3 uRotate;
uniform float uTransition;
uniform float uWordCount;
uniform float uLineCount;
uniform float uLetterCount;
uniform float uByWord;
uniform float uByLine;
uniform float uPadding;
uniform vec3 uBoundingMin;
uniform vec3 uBoundingMax;

#!VARYINGS
varying float vTrans;
varying vec2 vUv;
varying vec3 vPos;

#!SHADER: Vertex

#require(range.glsl)
#require(eases.glsl)
#require(rotation.glsl)
#require(conditionals.glsl)

void main() {
    vUv = uv;
    vTrans = 1.0;

    vec3 pos = position;

    if (uTransition < 5.0) {
        float padding = uPadding;
        float letter = (animation.x + 1.0) / uLetterCount;
        float word = (animation.y + 1.0) / uWordCount;
        float line = (animation.z + 1.0) / uLineCount;

        float letterTrans = crange(uTransition, letter - padding, letter + padding, 0.0, 1.0);
        float wordTrans = crange(uTransition, word - padding, word + padding, 0.0, 1.0);
        float lineTrans = crange(uTransition, line - padding, line + padding, 0.0, 1.0);

        vTrans = mix(cubicOut(letterTrans), cubicOut(wordTrans), uByWord);
        vTrans = mix(vTrans, cubicOut(lineTrans), uByLine);

        float invTrans = (1.0 - vTrans);
        vec3 nRotate = normalize(uRotate);
        vec3 axisX = vec3(1.0, 0.0, 0.0);
        vec3 axisY = vec3(0.0, 1.0, 0.0);
        vec3 axisZ = vec3(0.0, 0.0, 1.0);
        vec3 axis = mix(axisX, axisY, when_gt(nRotate.y, nRotate.x));
        axis = mix(axis, axisZ, when_gt(nRotate.z, nRotate.x));
        pos = vec3(vec4(position, 1.0) * rotationMatrix(axis, radians(max(max(uRotate.x, uRotate.y), uRotate.z) * invTrans)));
        pos += uTranslate * invTrans;
    }

    vPos = pos;

    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment

#require(range.glsl)
#require(msdf.glsl)
#require(simplenoise.glsl)

vec2 getBoundingUV() {
    vec2 uv;
    uv.x = crange(vPos.x, uBoundingMin.x, uBoundingMax.x, 0.0, 1.0);
    uv.y = crange(vPos.y, uBoundingMin.y, uBoundingMax.y, 0.0, 1.0);
    return uv;
}

void main() {
    float alpha = msdf(tMap, vUv);

    //float noise = 0.5 + smoothstep(-1.0, 1.0, cnoise(vec3(vUv*50.0, time* 0.3))) * 0.5;

    gl_FragColor.rgb = uColor;
    gl_FragColor.a = alpha * uAlpha * vTrans;
}
{@}Button.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 uColor;
uniform float uHover;
uniform float uAlpha;
uniform float uRatio;
uniform float uScreenRatio;
uniform float uCut;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
void main() {
    vUv = uv;
    vec4 mvPosition = modelViewMatrix * vec4(position, 1.0);
    gl_Position = projectionMatrix * mvPosition;
}

#!SHADER: Fragment

#require(range.glsl)
#require(transformUV.glsl)

float aastep(float threshold, float value) {
    float afwidth = length(vec2(dFdx(value), dFdy(value))) * 0.70710678118654757;
    return smoothstep(threshold-afwidth, threshold+afwidth, value);
}

float rectangle(vec2 st, vec2 size) {
    size = vec2(0.5) - size * 0.5;
    vec2 uv = vec2(aastep(size.x, st.x), aastep(size.y, st.y));
    uv *= vec2(aastep(size.x, 1.0 - st.x), aastep(size.y, 1.0 - st.y));

    return uv.x * uv.y;
}

float getCutMask() {
    vec2 screen = gl_FragCoord.xy / resolution.xy;
    float inclination = 0.07 * uScreenRatio;
    float cutSt = screen.y + screen.x * inclination;
    float cutTop = aastep(cutSt, crange(uCut, -1., 0., 0.0, 1.0 + inclination));
    float cutBottom = 1. - aastep(cutSt, crange(uCut, 0., 1., 0.0, 1.0 + inclination));
    return cutTop * cutBottom;
}

void main() {
    vec2 uv = vUv;

    float hoverMask = aastep(rotateUV(vUv, 3.14/4.).x, crange(uHover, 0., 1., -.2, 1.2));
    float border = .07;
    float aa = rectangle(vUv, vec2(.998)); // antialias

    // cut
    float cut = getCutMask();

    float mask = max(
        hoverMask,
        1. - rectangle(uv, vec2(1. - border / uRatio, 1. - border))
    );
    gl_FragColor = vec4(uColor, uAlpha * mask * cut * aa);
}{@}ProductImg.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform float uProgress;
uniform float uAlpha;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
void main() {
    vUv = uv;
    vec4 mvPosition = modelViewMatrix * vec4(position, 1.0);
    gl_Position = projectionMatrix * mvPosition;
}

#!SHADER: Fragment

#require(range.glsl)
#require(transformUV.glsl)

float aastep(float threshold, float value) {
    float afwidth = length(vec2(dFdx(value), dFdy(value))) * 0.70710678118654757;
    return smoothstep(threshold-afwidth, threshold+afwidth, value);
}

float circle(vec2 st, float radius) {
    return 1. - aastep(radius, length(st - vec2(0.5)));
}


void main() {

    vec2 scale = vec2(crange(uProgress, -1., 0., 1.2, 1.));
    vec4 texel = texture2D(tMap, scaleUV(vUv, scale));
    float mask = circle(vUv, crange(uProgress, -1., 0., .4, .492));
    gl_FragColor = texel;
    gl_FragColor.a *= uAlpha * mask;
}{@}ArrowShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform vec3 uColor;
uniform float uAlpha;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
void main() {
    vUv = uv;
    vec4 mvPosition = modelViewMatrix * vec4(position, 1.0);
    gl_Position = projectionMatrix * mvPosition;
}

#!SHADER: Fragment

void main() {
    float mask = texture2D(tMap, vUv).g;
    gl_FragColor.rgb = uColor;
    gl_FragColor.a = uAlpha * mask;
}{@}TextShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS

uniform sampler2D tMap;
uniform vec3 uColor;
uniform float uAlpha;
uniform float uScreenRatio;
uniform float uCut;

#!VARYINGS

varying vec2 vUv;

#!SHADER: TextShader.vs

void main() {
    vUv = uv;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: TextShader.fs

#require(range.glsl)
#require(msdf.glsl)

float aastep(float threshold, float value) {
    float afwidth = length(vec2(dFdx(value), dFdy(value))) * 0.70710678118654757;
    return smoothstep(threshold-afwidth, threshold+afwidth, value);
}

float getCutMask() {
    vec2 screen = gl_FragCoord.xy / resolution.xy;
    float inclination = 0.07 * uScreenRatio;
    float cutSt = screen.y + screen.x * inclination;
    float cutTop = aastep(cutSt, crange(uCut, -1., 0., 0.0, 1.0 + inclination));
    float cutBottom = 1. - aastep(cutSt, crange(uCut, 0.,1., 0.0, 1.0 + inclination));
    return cutTop * cutBottom;
}

void main() {
    float alpha = msdf(tMap, vUv);
    float cut = getCutMask();
    gl_FragColor.rgb = uColor;
    gl_FragColor.a = alpha * uAlpha * cut;
}
