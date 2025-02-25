// Copyright 2024–2025 Skip
// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
/// Marker protocol for types that are custom bridged from the Swift side.
///
/// - Seealso: `KotlinConverting`
public protocol SwiftCustomBridged {
}

/// Implemented by the generated Kotlin side of a bridged type to provide its Swift projection.
///
/// We keep this in SkipLib so that the Kotlin output of transpiled bridged modules does not have a
/// dependency on SkipBridge. We can add the SkipBridge dependency only when compiling for bridging.
///
/// - Returns: A closure that returns a Swift projection of this object when invoked.
/// - Warning: This protocol is not designed for general use. It is designed for generated bridge code.
/// - Seealso: `SkipBridge.BridgeSupport`
public protocol SwiftProjecting {
    func Swift_projection(options: Int) -> () -> Any
}
