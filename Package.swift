// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "skip-lib",
    platforms: [.iOS(.v16), .macOS(.v13), .tvOS(.v16), .watchOS(.v9), .macCatalyst(.v16)],
    products: [
        .library(name: "SkipLib", targets: ["SkipLib"]),
    ],
    dependencies: [
        .package(url: "https://github.com/skiptools/skip.git", from: "1.9.6"),
        .package(url: "https://github.com/skiptools/skip-unit.git", from: "1.7.1"),
    ],
    targets: [
        .target(name: "SkipLib", dependencies: [.product(name: "SkipUnit", package: "skip-unit")], plugins: [.plugin(name: "skipstone", package: "skip")]),
        .testTarget(name: "SkipLibTests", dependencies: ["SkipLib", .product(name: "SkipTest", package: "skip")], plugins: [.plugin(name: "skipstone", package: "skip")]),
    ]
)

// SKIP_DYNAMIC_LIBRARIES and SKIP_BRIDGE both enforce building as dynamic
// libraries; SKIP_BRIDGE additionally puts the skipstone plugin in bridge mode
let bridgeMode = (Context.environment["SKIP_BRIDGE"] ?? "0") != "0"
let forceDylib = bridgeMode || (Context.environment["SKIP_DYNAMIC_LIBRARIES"] ?? "0") != "0"

if forceDylib {
    // all library types must be dynamic to support bridging
    package.products = package.products.map({ product in
        guard let libraryProduct = product as? Product.Library else { return product }
        return .library(name: libraryProduct.name, type: .dynamic, targets: libraryProduct.targets)
    })
}
