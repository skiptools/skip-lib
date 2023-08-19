// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

#if SKIP

/// Kotlin representation of `Swift.Result`.
public enum Result<Success, Failure> where Failure : Error {
    case success(Success)
    case failure(Failure)

    public func get() throws -> Success {
        switch self {
        case .success(let success):
            return success
        case .failure(let failure):
            // SKIP REPLACE: throw failure as Throwable
            throw failure as! Swift.Error
        }
    }
}

#endif
