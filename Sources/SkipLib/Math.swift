// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

#if !SKIP
import Darwin
#else
// SKIP INSERT: import kotlin.math.pow
// SKIP INSERT: import kotlin.math.IEEErem
#endif

public func acosf(_ x: Float) -> Float {
    #if !SKIP
    fatalError() // Darwin.acosf(x)
    #else
    return kotlin.math.acos(x)
    #endif
}

public func acos(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.acos(x)
    #else
    return kotlin.math.acos(x)
    #endif
}

public func acosl(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.acos(x)
    #else
    return kotlin.math.acos(x)
    #endif
}

@available(*, unavailable)
public func asinf(_ x: Float) -> Float {
    #if !SKIP
    fatalError() // Darwin.asinf(x)
    #else
    return kotlin.math.asin(x)
    #endif
}

public func asin(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.asin(x)
    #else
    return kotlin.math.asin(x)
    #endif
}

public func asinl(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.asin(x)
    #else
    return kotlin.math.asin(x)
    #endif
}

public func atanf(_ x: Float) -> Float {
    #if !SKIP
    fatalError() // Darwin.atanf(x)
    #else
    return kotlin.math.atan(x)
    #endif
}

public func atan(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.atan(x)
    #else
    return kotlin.math.atan(x)
    #endif
}

public func atanl(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.atan(x)
    #else
    return kotlin.math.atan(x)
    #endif
}

public func atan2f(_ x: Float, _ y: Float) -> Float {
    #if !SKIP
    fatalError() // Darwin.atan2f(x, y)
    #else
    return kotlin.math.atan2(x, y)
    #endif
}

public func atan2(_ x: Double, _ y: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.atan2(x, y)
    #else
    return kotlin.math.atan2(x, y)
    #endif
}

public func atan2l(_ x: Double, _ y: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.atan2(x, y)
    #else
    return kotlin.math.atan2(x, y)
    #endif
}

public func cosf(_ x: Float) -> Float {
    #if !SKIP
    fatalError() // Darwin.cosf(x)
    #else
    return kotlin.math.cos(x)
    #endif
}

public func cos(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.cos(x)
    #else
    return kotlin.math.cos(x)
    #endif
}

public func cosl(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.cos(x)
    #else
    return kotlin.math.cos(x)
    #endif
}

public func sinf(_ x: Float) -> Float {
    #if !SKIP
    fatalError() // Darwin.sinf(x)
    #else
    return kotlin.math.sin(x)
    #endif
}

public func sin(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.sin(x)
    #else
    return kotlin.math.sin(x)
    #endif
}

public func sinl(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.sin(x)
    #else
    return kotlin.math.sin(x)
    #endif
}

public func tanf(_ x: Float) -> Float {
    #if !SKIP
    fatalError() // Darwin.tanf(x)
    #else
    return kotlin.math.tan(x)
    #endif
}

public func tan(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.tan(x)
    #else
    return kotlin.math.tan(x)
    #endif
}

public func tanl(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.tan(x)
    #else
    return kotlin.math.tan(x)
    #endif
}

public func acoshf(_ x: Float) -> Float {
    #if !SKIP
    fatalError() // Darwin.acoshf(x)
    #else
    return kotlin.math.acosh(x)
    #endif
}

public func acosh(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.acosh(x)
    #else
    return kotlin.math.acosh(x)
    #endif
}

public func acoshl(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.acosh(x)
    #else
    return kotlin.math.acosh(x)
    #endif
}

public func asinhf(_ x: Float) -> Float {
    #if !SKIP
    fatalError() // Darwin.asinhf(x)
    #else
    return kotlin.math.asinh(x)
    #endif
}

public func asinh(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.asinh(x)
    #else
    return kotlin.math.asinh(x)
    #endif
}

public func asinhl(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.asinh(x)
    #else
    return kotlin.math.asinh(x)
    #endif
}

public func atanhf(_ x: Float) -> Float {
    #if !SKIP
    fatalError() // Darwin.atanhf(x)
    #else
    return kotlin.math.atanh(x)
    #endif
}

public func atanh(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.atanh(x)
    #else
    return kotlin.math.atanh(x)
    #endif
}

public func atanhl(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.atanh(x)
    #else
    return kotlin.math.atanh(x)
    #endif
}

public func coshf(_ x: Float) -> Float {
    #if !SKIP
    fatalError() // Darwin.coshf(x)
    #else
    return kotlin.math.cosh(x)
    #endif
}

public func cosh(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.cosh(x)
    #else
    return kotlin.math.cosh(x)
    #endif
}

public func coshl(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.cosh(x)
    #else
    return kotlin.math.cosh(x)
    #endif
}

public func sinhf(_ x: Float) -> Float {
    #if !SKIP
    fatalError() // Darwin.sinhf(x)
    #else
    return kotlin.math.sinh(x)
    #endif
}

public func sinh(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.sinh(x)
    #else
    return kotlin.math.sinh(x)
    #endif
}

public func sinhl(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.sinh(x)
    #else
    return kotlin.math.sinh(x)
    #endif
}

public func tanhf(_ x: Float) -> Float {
    #if !SKIP
    fatalError() // Darwin.tanhf(x)
    #else
    return kotlin.math.tanh(x)
    #endif
}

public func tanh(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.tanh(x)
    #else
    return kotlin.math.tanh(x)
    #endif
}

public func tanhl(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.tanh(x)
    #else
    return kotlin.math.tanh(x)
    #endif
}

public func expf(_ x: Float) -> Float {
    #if !SKIP
    fatalError() // Darwin.expf(x)
    #else
    return kotlin.math.exp(x)
    #endif
}

public func exp(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.exp(x)
    #else
    return kotlin.math.exp(x)
    #endif
}

public func expl(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.exp(x)
    #else
    return kotlin.math.exp(x)
    #endif
}

public func exp2f(_ x: Float) -> Float {
    #if !SKIP
    fatalError() // Darwin.exp2f(x)
    #else
    return powf(Float(2.0), x)
    #endif
}

public func exp2(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.exp2(x)
    #else
    return pow(2.0, x)
    #endif
}

public func exp2l(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.exp2(x)
    #else
    return pow(2.0, x)
    #endif
}

public func expm1f(_ x: Float) -> Float {
    #if !SKIP
    fatalError() // Darwin.expm1f(x)
    #else
    return kotlin.math.expm1(x)
    #endif
}

public func expm1(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.expm1(x)
    #else
    return kotlin.math.expm1(x)
    #endif
}

public func expm1l(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.expm1(x)
    #else
    return kotlin.math.expm1(x)
    #endif
}

public func logf(_ x: Float) -> Float {
    #if !SKIP
    fatalError() // Darwin.logf(x)
    #else
    return kotlin.math.log(x, kotlin.math.E.toFloat())
    #endif
}

public func log(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.log(x)
    #else
    return kotlin.math.log(x, kotlin.math.E)
    #endif
}

public func logl(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.log(x)
    #else
    return kotlin.math.log(x, kotlin.math.E)
    #endif
}

public func log10f(_ x: Float) -> Float {
    #if !SKIP
    fatalError() // Darwin.log10f(x)
    #else
    return kotlin.math.log10(x)
    #endif
}

public func log10(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.log10(x)
    #else
    return kotlin.math.log10(x)
    #endif
}

public func log10l(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.log10(x)
    #else
    return kotlin.math.log10(x)
    #endif
}

public func log2f(_ x: Float) -> Float {
    #if !SKIP
    fatalError() // Darwin.log2f(x)
    #else
    return kotlin.math.log2(x)
    #endif
}

public func log2(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.log2(x)
    #else
    return kotlin.math.log2(x)
    #endif
}

public func log2l(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.log2(x)
    #else
    return kotlin.math.log2(x)
    #endif
}

public func log1pf(_ x: Float) -> Float {
    #if !SKIP
    fatalError() // Darwin.log1pf(x)
    #else
    return kotlin.math.ln(Float(1.0) + x)
    #endif
}

public func log1p(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.log1p(x)
    #else
    return kotlin.math.ln(1.0 + x)
    #endif
}

public func log1pl(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.log1p(x)
    #else
    return kotlin.math.ln(1.0 + x)
    #endif
}

public func logbf(_ x: Float) -> Float {
    #if !SKIP
    fatalError() // Darwin.logbf(x)
    #else
    return kotlin.math.ln(Float(1.0) + x) / kotlin.math.ln(Float(2.0))
    #endif
}

public func logb(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.logb(x)
    #else
    return kotlin.math.ln(1.0 + x) / kotlin.math.ln(2.0)
    #endif
}

public func logbl(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.logb(x)
    #else
    return kotlin.math.ln(1.0 + x) / kotlin.math.ln(2.0)
    #endif
}

public func fabsf(_ x: Float) -> Float {
    #if !SKIP
    fatalError() // Darwin.fabsf(x)
    #else
    return kotlin.math.abs(x)
    #endif
}

public func fabs(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.fabs(x)
    #else
    return kotlin.math.abs(x)
    #endif
}

public func fabsl(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.fabs(x)
    #else
    return kotlin.math.abs(x)
    #endif
}

public func cbrtf(_ x: Float) -> Float {
    #if !SKIP
    fatalError() // Darwin.cbrtf(x)
    #else
    return kotlin.math.cbrt(x)
    #endif
}

public func cbrt(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.cbrt(x)
    #else
    return kotlin.math.cbrt(x)
    #endif
}

public func cbrtl(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.cbrt(x)
    #else
    return kotlin.math.cbrt(x)
    #endif
}

public func hypotf(_ x: Float, _ y: Float) -> Float {
    #if !SKIP
    fatalError() // Darwin.hypotf(x, y)
    #else
    return kotlin.math.hypot(x, y)
    #endif
}

public func hypot(_ x: Double, _ y: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.hypot(x, y)
    #else
    return kotlin.math.hypot(x, y)
    #endif
}

public func hypotl(_ x: Double, _ y: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.hypot(x, y)
    #else
    return kotlin.math.hypot(x, y)
    #endif
}

public func powf(_ x: Float, _ y: Float) -> Float {
    #if !SKIP
    fatalError() // Darwin.powf(x, y)
    #else
    return x.pow(y)
    #endif
}

public func pow(_ x: Double, _ y: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.pow(x, y)
    #else
    return x.pow(y)
    #endif
}

public func powl(_ x: Double, _ y: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.pow(x, y)
    #else
    return x.pow(y)
    #endif
}

public func sqrtf(_ x: Float) -> Float {
    #if !SKIP
    fatalError() // Darwin.sqrtf(x)
    #else
    return kotlin.math.sqrt(x)
    #endif
}

public func sqrt(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.sqrt(x)
    #else
    return kotlin.math.sqrt(x)
    #endif
}

public func sqrtl(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.sqrt(x)
    #else
    return kotlin.math.sqrt(x)
    #endif
}

public func ceilf(_ x: Float) -> Float {
    #if !SKIP
    fatalError() // Darwin.ceilf(x)
    #else
    return kotlin.math.ceil(x)
    #endif
}

public func ceil(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.ceil(x)
    #else
    return kotlin.math.ceil(x)
    #endif
}

public func ceill(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.ceil(x)
    #else
    return kotlin.math.ceil(x)
    #endif
}

public func floorf(_ x: Float) -> Float {
    #if !SKIP
    fatalError() // Darwin.floorf(x)
    #else
    return kotlin.math.floor(x)
    #endif
}

public func floor(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.floor(x)
    #else
    return kotlin.math.floor(x)
    #endif
}

public func floorl(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.floor(x)
    #else
    return kotlin.math.floor(x)
    #endif
}

public func roundf(_ x: Float) -> Float {
    #if !SKIP
    fatalError() // Darwin.roundf(x)
    #else
    return kotlin.math.round(x)
    #endif
}

public func round(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.round(x)
    #else
    return kotlin.math.round(x)
    #endif
}

public func roundl(_ x: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.round(x)
    #else
    return kotlin.math.round(x)
    #endif
}

public func fmodf(_ x: Float, _ y: Float) -> Float {
    #if !SKIP
    fatalError() // Darwin.fmodf(x, y)
    #else
    return x % y
    #endif
}

public func fmod(_ x: Double, _ y: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.fmod(x, y)
    #else
    return x % y
    #endif
}

public func fmodl(_ x: Double, _ y: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.fmod(x, y)
    #else
    return x % y
    #endif
}

public func remainderf(_ x: Float, _ y: Float) -> Float {
    #if !SKIP
    fatalError() // Darwin.remainderf(x, y)
    #else
    return x.IEEErem(y)
    #endif
}

public func remainder(_ x: Double, _ y: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.remainder(x, y)
    #else
    return x.IEEErem(y)
    #endif
}

public func remainderl(_ x: Double, _ y: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.remainder(x, y)
    #else
    return x.IEEErem(y)
    #endif
}

public func fmaxf(_ x: Float, _ y: Float) -> Float {
    #if !SKIP
    fatalError() // Darwin.fmaxf(x, y)
    #else
    return max(x, y)
    #endif
}

public func fmax(_ x: Double, _ y: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.fmax(x, y)
    #else
    return max(x, y)
    #endif
}

public func fmaxl(_ x: Double, _ y: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.fmax(x, y)
    #else
    return max(x, y)
    #endif
}

public func fminf(_ x: Float, _ y: Float) -> Float {
    #if !SKIP
    fatalError() // Darwin.fminf(x, y)
    #else
    return min(x, y)
    #endif
}

public func fmin(_ x: Double, _ y: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.fmin(x, y)
    #else
    return fmin(x, y)
    #endif
}

public func fminl(_ x: Double, _ y: Double) -> Double {
    #if !SKIP
    fatalError() // Darwin.fmin(x, y)
    #else
    return fmin(x, y)
    #endif
}


@available(*, unavailable)
public func lroundf(_ x: Float) -> Int { fatalError() }
@available(*, unavailable)
public func lround(_ x: Double) -> Int { fatalError() }
@available(*, unavailable)
public func lroundl(_ x: Double) -> Int { fatalError() }

@available(*, unavailable)
public func truncf(_ x: Float) -> Float { fatalError() }
@available(*, unavailable)
public func trunc(_ x: Double) -> Double { fatalError() }
@available(*, unavailable)
public func truncl(_ x: Double) -> Double { fatalError() }

@available(*, unavailable)
public func nearbyintf(_ x: Float) -> Float { fatalError() }
@available(*, unavailable)
public func nearbyint(_ x: Double) -> Double { fatalError() }
@available(*, unavailable)
public func nearbyintl(_ x: Double) -> Double { fatalError() }

@available(*, unavailable)
public func rintf(_ x: Float) -> Float { fatalError() }
@available(*, unavailable)
public func rint(_ x: Double) -> Double { fatalError() }
@available(*, unavailable)
public func rintl(_ x: Double) -> Double { fatalError() }

@available(*, unavailable)
public func lrintf(_ x: Float) -> Int { fatalError() }
@available(*, unavailable)
public func lrint(_ x: Double) -> Int { fatalError() }
@available(*, unavailable)
public func lrintl(_ x: Double) -> Int { fatalError() }

@available(*, unavailable)
public func erff(_ x: Float) -> Float { fatalError() }
@available(*, unavailable)
public func erf(_ x: Double) -> Double { fatalError() }
@available(*, unavailable)
public func erfl(_ x: Double) -> Double { fatalError() }

@available(*, unavailable)
public func erfcf(_ x: Float) -> Float { fatalError() }
@available(*, unavailable)
public func erfc(_ x: Double) -> Double { fatalError() }
@available(*, unavailable)
public func erfcl(_ x: Double) -> Double { fatalError() }

@available(*, unavailable)
public func lgammaf(_ x: Float) -> Float { fatalError() }
@available(*, unavailable)
public func lgamma(_ x: Double) -> Double { fatalError() }
@available(*, unavailable)
public func lgammal(_ x: Double) -> Double { fatalError() }

@available(*, unavailable)
public func tgammaf(_ x: Float) -> Float { fatalError() }
@available(*, unavailable)
public func tgamma(_ x: Double) -> Double { fatalError() }
@available(*, unavailable)
public func tgammal(_ x: Double) -> Double { fatalError() }

@available(*, unavailable)
public func modff(_ x: Float, _ y: Any /* UnsafeMutablePointer<Float>! */) -> Float { fatalError() }
@available(*, unavailable)
public func modf(_ x: Double, _ y: Any /* UnsafeMutablePointer<Double>! */) -> Double { fatalError() }
@available(*, unavailable)
public func modfl(_ x: Double, _ y: Any /* UnsafeMutablePointer<Double>! */) -> Double { fatalError() }

@available(*, unavailable)
public func ldexpf(_ x: Float, _ y: Int32) -> Float { fatalError() }
@available(*, unavailable)
public func ldexp(_ x: Double, _ y: Int32) -> Double { fatalError() }
@available(*, unavailable)
public func ldexpl(_ x: Double, _ y: Int32) -> Double { fatalError() }

@available(*, unavailable)
public func frexpf(_ x: Float, _ y: Any /* UnsafeMutablePointer<Int32>! */) -> Float { fatalError() }
@available(*, unavailable)
public func frexp(_ x: Double, _ y: Any /* UnsafeMutablePointer<Int32>! */) -> Double { fatalError() }
@available(*, unavailable)
public func frexpl(_ x: Double, _ y: Any /* UnsafeMutablePointer<Int32>! */) -> Double { fatalError() }

@available(*, unavailable)
public func ilogbf(_ x: Float) -> Int32 { fatalError() }
@available(*, unavailable)
public func ilogb(_ x: Double) -> Int32 { fatalError() }
@available(*, unavailable)
public func ilogbl(_ x: Double) -> Int32 { fatalError() }

@available(*, unavailable)
public func scalbnf(_ x: Float, _ y: Int32) -> Float { fatalError() }
@available(*, unavailable)
public func scalbn(_ x: Double, _ y: Int32) -> Double { fatalError() }
@available(*, unavailable)
public func scalbnl(_ x: Double, _ y: Int32) -> Double { fatalError() }

@available(*, unavailable)
public func scalblnf(_ x: Float, _ y: Int) -> Float { fatalError() }
@available(*, unavailable)
public func scalbln(_ x: Double, _ y: Int) -> Double { fatalError() }
@available(*, unavailable)
public func scalblnl(_ x: Double, _ y: Int) -> Double { fatalError() }

@available(*, unavailable)
public func remquof(_ x: Float, _ y: Float, _ z: Any /* UnsafeMutablePointer<Int32>! */) -> Float { fatalError() }
@available(*, unavailable)
public func remquo(_ x: Double, _ y: Double, _ z: Any /* UnsafeMutablePointer<Int32>! */) -> Double { fatalError() }
@available(*, unavailable)
public func remquol(_ x: Double, _ y: Double, _ z: Any /* UnsafeMutablePointer<Int32>! */) -> Double { fatalError() }

@available(*, unavailable)
public func copysignf(_ x: Float, _ y: Float) -> Float { fatalError() }
@available(*, unavailable)
public func copysign(_ x: Double, _ y: Double) -> Double { fatalError() }
@available(*, unavailable)
public func copysignl(_ x: Double, _ y: Double) -> Double { fatalError() }

@available(*, unavailable)
public func nanf(_ x: Any /* UnsafePointer<CChar>! */) -> Float { fatalError() }
@available(*, unavailable)
public func nan(_ x: Any /* UnsafePointer<CChar>! */) -> Double { fatalError() }
@available(*, unavailable)
public func nanl(_ x: Any /* UnsafePointer<CChar>! */) -> Double { fatalError() }

@available(*, unavailable)
public func nextafterf(_ x: Float, _ y: Float) -> Float { fatalError() }
@available(*, unavailable)
public func nextafter(_ x: Double, _ y: Double) -> Double { fatalError() }
@available(*, unavailable)
public func nextafterl(_ x: Double, _ y: Double) -> Double { fatalError() }

@available(*, unavailable)
public func nexttowardf(_ x: Float, _ y: Double) -> Float { fatalError() }
@available(*, unavailable)
public func nexttoward(_ x: Double, _ y: Double) -> Double { fatalError() }
@available(*, unavailable)
public func nexttowardl(_ x: Double, _ y: Double) -> Double { fatalError() }

@available(*, unavailable)
public func fdimf(_ x: Float, _ y: Float) -> Float { fatalError() }
@available(*, unavailable)
public func fdim(_ x: Double, _ y: Double) -> Double { fatalError() }
@available(*, unavailable)
public func fdiml(_ x: Double, _ y: Double) -> Double { fatalError() }

@available(*, unavailable)
public func fmaf(_ x: Float, _ y: Float, _ z: Float) -> Float { fatalError() }
@available(*, unavailable)
public func fma(_ x: Double, _ y: Double, _ z: Double) -> Double { fatalError() }
@available(*, unavailable)
public func fmal(_ x: Double, _ y: Double, _ z: Double) -> Double { fatalError() }

