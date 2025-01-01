// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

#if SKIP

/// Kotlin representation of `Swift.Result`.
///
/// - Note: We do not map to `KotlinConverting<kotlin.Result...>` because `KotlinResult` is a value type
///   that is near impossible to use with our bridging reflection.
// SKIP DECLARE: sealed class Result<out Success, out Failure>: KotlinConverting<Pair<*, *>>, SwiftCustomBridged where Failure: Error
public enum Result<Success, Failure>: KotlinConverting<Pair<Success?, Failure?>>, SwiftCustomBridged where Failure : Error {
    case success(Success)
    case failure(Failure)

    public init(platformValue: Pair<Success?, Failure?>) {
        if let failure = platformValue.second {
            self = .failure(failure)
        } else {
            self = .success(platformValue.first!)
        }
    }

    public init(catching body: () throws -> Success) {
        do {
            self = .success(try body())
        } catch {
            self = .failure(error as Failure)
        }
    }
    
    public func get() throws -> Success {
        switch self {
        case .success(let success):
            return success
        case .failure(let failure):
            // SKIP REPLACE: throw failure as Throwable
            throw failure as! Swift.Error
        }
    }

    public override func kotlin(nocopy: Bool = false) -> Pair<Success?, Failure?> {
        switch self {
        case .success(let success):
            return Pair(success, nil)
        case .failure(let failure):
            return Pair(nil, failure)
        }
    }
}

#endif
