// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

#if SKIP

private typealias PlatformValue<Success> = kotlin.Result<Success>

/// Kotlin representation of `Swift.Result`.
// SKIP DECLARE: sealed class Result<out Success, out Failure>: KotlinConverting<kotlin.Result<*>>, SwiftCustomBridged where Failure: Error
public enum Result<Success, Failure>: KotlinConverting<PlatformValue<Success>>, SwiftCustomBridged where Failure : Error {
    case success(Success)
    case failure(Failure)

    public init(platformValue: PlatformValue<Success>) {
        if let failure = platformValue.exceptionOrNull() {
            self = .failure(failure as Failure)
        } else {
            self = .success(platformValue.getOrThrow())
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

    public override func kotlin(nocopy: Bool = false) -> PlatformValue<Success> {
        switch self {
        case .success(let success):
            // SKIP REPLACE: return kotlin.Result.success(success)
            return PlatformValue.success(success)
        case .failure(let failure):
            // SKIP REPLACE: return kotlin.Result.failure(failure as Throwable)
            return PlatformValue.failure(failure as! Throwable)
        }
    }
}

#endif
