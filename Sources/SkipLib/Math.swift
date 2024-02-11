// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

#if SKIP

import kotlin.math.pow
import kotlin.math.IEEErem

public enum FloatingPointRoundingRule: Hashable {
    case toNearestOrAwayFromZero
    case toNearestOrEven
    case up
    case down
    case towardZero
    case awayFromZero
}

public func acosf(_ x: Float) -> Float {
    return kotlin.math.acos(x)
}

public func acos(_ x: Double) -> Double {
    return kotlin.math.acos(x)
}

public func acosl(_ x: Double) -> Double {
    return kotlin.math.acos(x)
}

public func asinf(_ x: Float) -> Float {
    return kotlin.math.asin(x)
}

public func asin(_ x: Double) -> Double {
    return kotlin.math.asin(x)
}

public func asinl(_ x: Double) -> Double {
    return kotlin.math.asin(x)
}

public func atanf(_ x: Float) -> Float {
    return kotlin.math.atan(x)
}

public func atan(_ x: Double) -> Double {
    return kotlin.math.atan(x)
}

public func atanl(_ x: Double) -> Double {
    return kotlin.math.atan(x)
}

public func atan2f(_ x: Float, _ y: Float) -> Float {
    return kotlin.math.atan2(x, y)
}

public func atan2(_ x: Double, _ y: Double) -> Double {
    return kotlin.math.atan2(x, y)
}

public func atan2l(_ x: Double, _ y: Double) -> Double {
    return kotlin.math.atan2(x, y)
}

public func cosf(_ x: Float) -> Float {
    return kotlin.math.cos(x)
}

public func cos(_ x: Double) -> Double {
    return kotlin.math.cos(x)
}

public func cosl(_ x: Double) -> Double {
    return kotlin.math.cos(x)
}

public func sinf(_ x: Float) -> Float {
    return kotlin.math.sin(x)
}

public func sin(_ x: Double) -> Double {
    return kotlin.math.sin(x)
}

public func sinl(_ x: Double) -> Double {
    return kotlin.math.sin(x)
}

public func tanf(_ x: Float) -> Float {
    return kotlin.math.tan(x)
}

public func tan(_ x: Double) -> Double {
    return kotlin.math.tan(x)
}

public func tanl(_ x: Double) -> Double {
    return kotlin.math.tan(x)
}

public func acoshf(_ x: Float) -> Float {
    return kotlin.math.acosh(x)
}

public func acosh(_ x: Double) -> Double {
    return kotlin.math.acosh(x)
}

public func acoshl(_ x: Double) -> Double {
    return kotlin.math.acosh(x)
}

public func asinhf(_ x: Float) -> Float {
    return kotlin.math.asinh(x)
}

public func asinh(_ x: Double) -> Double {
    return kotlin.math.asinh(x)
}

public func asinhl(_ x: Double) -> Double {
    return kotlin.math.asinh(x)
}

public func atanhf(_ x: Float) -> Float {
    return kotlin.math.atanh(x)
}

public func atanh(_ x: Double) -> Double {
    return kotlin.math.atanh(x)
}

public func atanhl(_ x: Double) -> Double {
    return kotlin.math.atanh(x)
}

public func coshf(_ x: Float) -> Float {
    return kotlin.math.cosh(x)
}

public func cosh(_ x: Double) -> Double {
    return kotlin.math.cosh(x)
}

public func coshl(_ x: Double) -> Double {
    return kotlin.math.cosh(x)
}

public func sinhf(_ x: Float) -> Float {
    return kotlin.math.sinh(x)
}

public func sinh(_ x: Double) -> Double {
    return kotlin.math.sinh(x)
}

public func sinhl(_ x: Double) -> Double {
    return kotlin.math.sinh(x)
}

public func tanhf(_ x: Float) -> Float {
    return kotlin.math.tanh(x)
}

public func tanh(_ x: Double) -> Double {
    return kotlin.math.tanh(x)
}

public func tanhl(_ x: Double) -> Double {
    return kotlin.math.tanh(x)
}

public func expf(_ x: Float) -> Float {
    return kotlin.math.exp(x)
}

public func exp(_ x: Double) -> Double {
    return kotlin.math.exp(x)
}

public func expl(_ x: Double) -> Double {
    return kotlin.math.exp(x)
}

public func exp2f(_ x: Float) -> Float {
    return powf(Float(2.0), x)
}

public func exp2(_ x: Double) -> Double {
    return pow(2.0, x)
}

public func exp2l(_ x: Double) -> Double {
    return pow(2.0, x)
}

public func expm1f(_ x: Float) -> Float {
    return kotlin.math.expm1(x)
}

public func expm1(_ x: Double) -> Double {
    return kotlin.math.expm1(x)
}

public func expm1l(_ x: Double) -> Double {
    return kotlin.math.expm1(x)
}

public func logf(_ x: Float) -> Float {
    return kotlin.math.log(x, kotlin.math.E.toFloat())
}

public func log(_ x: Double) -> Double {
    return kotlin.math.log(x, kotlin.math.E)
}

public func logl(_ x: Double) -> Double {
    return kotlin.math.log(x, kotlin.math.E)
}

public func log10f(_ x: Float) -> Float {
    return kotlin.math.log10(x)
}

public func log10(_ x: Double) -> Double {
    return kotlin.math.log10(x)
}

public func log10l(_ x: Double) -> Double {
    return kotlin.math.log10(x)
}

public func log2f(_ x: Float) -> Float {
    return kotlin.math.log2(x)
}

public func log2(_ x: Double) -> Double {
    return kotlin.math.log2(x)
}

public func log2l(_ x: Double) -> Double {
    return kotlin.math.log2(x)
}

public func log1pf(_ x: Float) -> Float {
    return kotlin.math.ln(Float(1.0) + x)
}

public func log1p(_ x: Double) -> Double {
    return kotlin.math.ln(1.0 + x)
}

public func log1pl(_ x: Double) -> Double {
    return kotlin.math.ln(1.0 + x)
}

public func logbf(_ x: Float) -> Float {
    return kotlin.math.ln(Float(1.0) + x) / kotlin.math.ln(Float(2.0))
}

public func logb(_ x: Double) -> Double {
    return kotlin.math.ln(1.0 + x) / kotlin.math.ln(2.0)
}

public func logbl(_ x: Double) -> Double {
    return kotlin.math.ln(1.0 + x) / kotlin.math.ln(2.0)
}

public func abs(_ x: Double) -> Double {
    return kotlin.math.abs(x)
}

public func abs(_ x: Int) -> Int {
    return kotlin.math.abs(x)
}

public func abs(_ x: Int64) -> Int64 {
    return kotlin.math.abs(x)
}

public func fabsf(_ x: Float) -> Float {
    return kotlin.math.abs(x)
}

public func fabs(_ x: Double) -> Double {
    return kotlin.math.abs(x)
}

public func fabsl(_ x: Double) -> Double {
    return kotlin.math.abs(x)
}

public func cbrtf(_ x: Float) -> Float {
    return kotlin.math.cbrt(x)
}

public func cbrt(_ x: Double) -> Double {
    return kotlin.math.cbrt(x)
}

public func cbrtl(_ x: Double) -> Double {
    return kotlin.math.cbrt(x)
}

public func hypotf(_ x: Float, _ y: Float) -> Float {
    return kotlin.math.hypot(x, y)
}

public func hypot(_ x: Double, _ y: Double) -> Double {
    return kotlin.math.hypot(x, y)
}

public func hypotl(_ x: Double, _ y: Double) -> Double {
    return kotlin.math.hypot(x, y)
}

public func powf(_ x: Float, _ y: Float) -> Float {
    return x.pow(y)
}

public func pow(_ x: Double, _ y: Double) -> Double {
    return x.pow(y)
}

public func powl(_ x: Double, _ y: Double) -> Double {
    return x.pow(y)
}

public func sqrtf(_ x: Float) -> Float {
    return kotlin.math.sqrt(x)
}

public func sqrt(_ x: Double) -> Double {
    return kotlin.math.sqrt(x)
}

public func sqrtl(_ x: Double) -> Double {
    return kotlin.math.sqrt(x)
}

public func ceilf(_ x: Float) -> Float {
    return kotlin.math.ceil(x)
}

public func ceil(_ x: Double) -> Double {
    return kotlin.math.ceil(x)
}

public func ceill(_ x: Double) -> Double {
    return kotlin.math.ceil(x)
}

public func floorf(_ x: Float) -> Float {
    return kotlin.math.floor(x)
}

public func floor(_ x: Double) -> Double {
    return kotlin.math.floor(x)
}

public func floorl(_ x: Double) -> Double {
    return kotlin.math.floor(x)
}

public func roundf(_ x: Float) -> Float {
    return kotlin.math.round(x)
}

public func round(_ x: Double) -> Double {
    return kotlin.math.round(x)
}

public func roundl(_ x: Double) -> Double {
    return kotlin.math.round(x)
}

public func fmodf(_ x: Float, _ y: Float) -> Float {
    return x % y
}

public func fmod(_ x: Double, _ y: Double) -> Double {
    return x % y
}

public func fmodl(_ x: Double, _ y: Double) -> Double {
    return x % y
}

public func remainderf(_ x: Float, _ y: Float) -> Float {
    return x.IEEErem(y)
}

public func remainder(_ x: Double, _ y: Double) -> Double {
    return x.IEEErem(y)
}

public func remainderl(_ x: Double, _ y: Double) -> Double {
    return x.IEEErem(y)
}

public func fmaxf(_ x: Float, _ y: Float) -> Float {
    return max(x, y)
}

public func fmax(_ x: Double, _ y: Double) -> Double {
    return max(x, y)
}

public func fmaxl(_ x: Double, _ y: Double) -> Double {
    return max(x, y)
}

public func fminf(_ x: Float, _ y: Float) -> Float {
    return min(x, y)
}

public func fmin(_ x: Double, _ y: Double) -> Double {
    return fmin(x, y)
}

public func fminl(_ x: Double, _ y: Double) -> Double {
    return fmin(x, y)
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

#endif
